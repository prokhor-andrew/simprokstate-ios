//
//  Feature.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.01.2020.
//  Copyright (c) 2020 simprok. All rights reserved.

import simprokmachine

public struct Feature<IntTrigger, IntEffect, ExtTrigger, ExtEffect> {

    public struct Transition {

        public let state: Feature<IntTrigger, IntEffect, ExtTrigger, ExtEffect>
        public let effects: [FeatureEvent<IntEffect, ExtEffect>]

        public init(
                _ state: Feature<IntTrigger, IntEffect, ExtTrigger, ExtEffect>,
                effects: FeatureEvent<IntEffect, ExtEffect>...
        ) {
            self.init(state, effects: effects)
        }

        public init(
                _ state: Feature<IntTrigger, IntEffect, ExtTrigger, ExtEffect>,
                effects: [FeatureEvent<IntEffect, ExtEffect>]
        ) {
            self.state = state
            self.effects = effects
        }
    }


    public let machines: [Machine<IntEffect, IntTrigger>]

    private let _transit: Mapper<FeatureEvent<IntTrigger, ExtTrigger>, Transition?>

    public init(
            machines: [Machine<IntEffect, IntTrigger>],
            transit: @escaping BiMapper<[Machine<IntEffect, IntTrigger>], FeatureEvent<IntTrigger, ExtTrigger>, Transition?>
    ) {
        self.machines = machines
        self._transit = {
            transit(machines, $0)
        }
    }

    public init(transit: @escaping Mapper<ExtTrigger, Transition?>) {
        self.init(machines: []) { _, event in
            switch event {
            case .int:
                return nil
            case .ext(let value):
                return transit(value)
            }
        }
    }

    public func transit(trigger: FeatureEvent<IntTrigger, ExtTrigger>) -> Transition? {
        _transit(trigger)
    }
}



public extension Machine {

    init<IntTrigger, IntEffect>(
            _ transition: Feature<IntTrigger, IntEffect, Input, Output>.Transition
    ) {
        self.init(FeatureHolder(transition), isProcessOnMain: false) { object, input, callback in
            object.process(input: input, callback: callback)
        }
    }


    private class FeatureHolder<IntTrigger, IntEffect, ExtTrigger, ExtEffect> {

        private var transition: Feature<IntTrigger, IntEffect, ExtTrigger, ExtEffect>.Transition
        private var subscriptions: [Machine<IntEffect, IntTrigger>: Subscription<IntEffect, IntTrigger>] = [:]

        internal init(_ initial: Feature<IntTrigger, IntEffect, ExtTrigger, ExtEffect>.Transition) {
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
            if let new = transition.state.transit(trigger: event) {
                // order matters as "transition" is used inside "config()"
                transition = new
                config(callback: callback)
            } else {
                // do nothing
            }
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
