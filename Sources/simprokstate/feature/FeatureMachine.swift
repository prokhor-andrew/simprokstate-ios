//
// Created by Andriy Prokhorenko on 14.02.2023.
//

import simprokmachine

public extension Machine {

    init<IntTrigger, IntEffect>(
            _ transition: FeatureTransition<IntTrigger, IntEffect, Input, Output>
    ) {
        self.init(FeatureHolder(transition), isProcessOnMain: false) { object, input, callback in
            object.process(input: input, callback: callback)
        }
    }


    private class FeatureHolder<IntTrigger, IntEffect, ExtTrigger, ExtEffect> {

        private var transition: FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>
        private var subscriptions: [Machine<IntEffect, IntTrigger>: Subscription<IntEffect, IntTrigger>] = [:]

        internal init(_ initial: FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>) {
            transition = initial
        }

        internal func process(input: ExtTrigger?, callback: @escaping Handler<ExtEffect>) {
            if let input = input {
                handle(event: .ext(input), callback: callback)
            } else {
                // initial
                config(callback: callback)
            }
        }

        private func handle(event: FeatureEvent<IntTrigger, ExtTrigger>, callback: @escaping Handler<ExtEffect>) {
            guard let transit = transition.state.transit else {
                // this is the finale
                return
            }
            // order matters as "transition" is used inside "config()"
            transition = transit(event)
            config(callback: callback)
        }

        private func config(callback: @escaping Handler<ExtEffect>) {
            // removing subscriptions that are not present in new state

            let machines = transition.state.machines
            subscriptions = subscriptions.reduce(subscriptions) { dict, element in
                let (key, _) = element

                let ids: Set<Machine<IntEffect, IntTrigger>> = Set(machines)

                if !ids.contains(key) {
                    var copy = dict
                    copy.removeValue(forKey: key)
                    return copy
                } else {
                    return dict
                }
            }

            // adding subscriptions that are present in new state
            subscriptions = machines.reduce(subscriptions) { [weak self] dict, machine in
                let key = machine

                if dict[key] == nil {
                    var copy = dict
                    copy[key] = machine.subscribe { [weak self] output, _ in
                        self?.handle(event: .int(output), callback: callback)
                    }
                    return copy
                } else {
                    return dict
                }
            }

            // sending effects
            transition.effects.forEach { event in
                switch event {
                case .int(let output):
                    subscriptions.forEach {
                        $0.value.send(input: output)
                    }
                case .ext(let output):
                    callback(output)
                }
            }
        }
    }
}
