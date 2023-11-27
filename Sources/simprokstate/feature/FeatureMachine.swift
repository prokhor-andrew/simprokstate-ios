//
// Created by Andriy Prokhorenko on 14.02.2023.
//

import simprokmachine

public extension Machine {

    init<IntTrigger, IntEffect>(
        _ feature: @escaping @Sendable () -> Feature<IntTrigger, IntEffect, Input, Output, Message>
    ) {
        self.init { logger in
            FeatureHolder<IntTrigger, IntEffect, Input, Output>(
                initial: feature,
                logger: logger
            )
        } onChange: {
            $0.onChange($1)
        } onProcess: {
            await $0.onProcess($1)
        }
    }

    
    private actor FeatureHolder<IntTrigger, IntEffect, ExtTrigger, ExtEffect> {
        
        private let logger: (Message) -> Void
        
        private let initial: () -> Feature<IntTrigger, IntEffect, ExtTrigger, ExtEffect, Message>
        
        private var callback: MachineCallback<ExtEffect>?
        private var processes: [Machine<IntEffect, IntTrigger, Message>: Process<IntEffect, IntTrigger, Message>] = [:]
        private var transit: Optional<
            (
                FeatureEvent<IntTrigger, ExtTrigger>,
                (Message) -> Void
            ) -> FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect, Message>?
        > = nil
        
        internal init(
            initial: @escaping () -> Feature<IntTrigger, IntEffect, ExtTrigger, ExtEffect, Message>,
            logger: @escaping (Message) -> Void
        ) {
            self.initial = initial
            self.logger = logger
        }
        
        internal func onChange(_ callback: MachineCallback<ExtEffect>?) {
            self.callback = callback
            
            if callback != nil {
                let state = initial()
                
                processes = state.machines.reduce([:]) { partialResult, element in
                    var copy = partialResult
                    copy[element] = element.run {
                        await handle(.int($0))
                    } logger: { [weak self] in self?.logger($0) }
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
            
            guard let transition = _transit(event, logger) else { return }
            
            var existing: [Process<IntEffect, IntTrigger, Message>] = []
            
            processes = transition.state.machines.reduce([:]) { partialResult, element in
                if let value = processes[element] {
                    existing.append(value)
                    var copy = partialResult
                    copy[element] = value
                    return copy
                } else {
                    var copy = partialResult
                    copy[element] = element.run { await handle(.int($0)) } logger: { [weak self] in self?.logger($0) }
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
                            _ = group.addTaskUnlessCancelled(priority: nil) {
                                await process.send(effect)
                            }
                        }
                        
                        await group.waitForAll()
                    }
                }
            }
        }
    }
}
