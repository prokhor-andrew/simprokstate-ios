//
// Created by Andriy Prokhorenko on 14.02.2023.
//

import simprokmachine

public extension Machine {

    init<IntTrigger, IntEffect>(
        _ feature: @escaping @Sendable () -> Feature<IntTrigger, IntEffect, Input, Output>
    ) {
        self.init {
            FeatureHolder(feature)
        } onChange: {
            $0.onChange($1)
        } onProcess: {
            await $0.onProcess($1)
        }
    }

    
    private actor FeatureHolder<IntTrigger, IntEffect, ExtTrigger, ExtEffect> {
        
        private let initial: () -> Feature<IntTrigger, IntEffect, ExtTrigger, ExtEffect>
        
        private var callback: Optional<(ExtEffect) async -> Void> = nil
        private var processes: [Machine<IntEffect, IntTrigger>: Process<IntEffect, IntTrigger>] = [:]
        private var transit: Optional<
            (FeatureEvent<IntTrigger, ExtTrigger>) -> FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>?
        > = nil
        
        internal init(_ initial: @escaping () -> Feature<IntTrigger, IntEffect, ExtTrigger, ExtEffect>) {
            self.initial = initial
        }
        
        internal func onChange(_ callback: Optional<@Sendable (ExtEffect) async -> Void>) {
            self.callback = callback
            
            if callback != nil {
                let state = initial()
                
                processes = state.machines.reduce([:]) { partialResult, element in
                    var copy = partialResult
                    copy[element] = element.run {
                        await handle(.int($0))
                    }
                    return copy
                }
                transit = state.transit
            } else {
                processes = [:]
                transit = nil
            }
        }
        
        internal func onProcess(_ input: ExtTrigger) async {
            await handle(.ext(input))
        }
        
        private func handle(_ event: FeatureEvent<IntTrigger, ExtTrigger>) async {
            guard let _transit = transit else { return }
            
            guard let transition = _transit(event) else { return }
            
            var existing: [Process<IntEffect, IntTrigger>] = []
            
            processes = transition.state.machines.reduce([:]) { partialResult, element in
                if let value = processes[element] {
                    existing.append(value)
                    var copy = partialResult
                    copy[element] = value
                    return copy
                } else {
                    var copy = partialResult
                    copy[element] = element.run { await handle(.int($0)) }
                    return copy
                }
            }
            transit = transition.state.transit
            
            for effect in transition.effects {
                switch effect {
                case .ext(let effect):
                    await callback?(effect)
                case .int(let effect):
                    await withTaskGroup(of: Void.self) { group in
                        existing.forEach { process in
                            group.addTask {
                                await process.send(effect)
                            }
                        }
                    }
                }
            }
        }
    }
}
