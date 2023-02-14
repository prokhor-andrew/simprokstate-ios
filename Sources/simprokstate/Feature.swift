//
//  Feature.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.01.2020.
//  Copyright (c) 2020 simprok. All rights reserved.

import simprokmachine

public struct Feature<IntTrigger, IntEffect, ExtTrigger, ExtEffect> {

    public let machines: Set<Machine<IntEffect, IntTrigger>>
    public let info: String

    private let _transit: Mapper<FeatureEvent<IntTrigger, ExtTrigger>, FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>>

    public init<Machines: FeatureMachines>(
            _ machines: Machines,
            info: String = "",
            transit: @escaping TriMapper<Machines, String, FeatureEvent<IntTrigger, ExtTrigger>, FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>>
    ) where Machines.Trigger == IntTrigger, Machines.Effect == IntEffect {
        self.machines = machines.machines
        self.info = info
        _transit = {
            transit(machines, info, $0)
        }
    }

    public init(info: String = "", transit: @escaping Mapper<ExtTrigger, FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>>) {
        func feature() -> Feature<IntTrigger, IntEffect, ExtTrigger, ExtEffect> {
            Feature(EmptyMachines(), info: info) { _, _, trigger in
                switch trigger {
                case .int:
                    return FeatureTransition(feature())
                case .ext(let value):
                    return transit(value)
                }
            }
        }

        self = feature()
    }

    public func transit(trigger: FeatureEvent<IntTrigger, ExtTrigger>) -> FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect> {
        _transit(trigger)
    }
}


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
            // order matters as "transition" is used inside "config()"
            transition = transition.state.transit(trigger: event)
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


extension Feature: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(info)
        hasher.combine(machines)
    }

    public static func ==(lhs: Feature<IntTrigger, IntEffect, ExtTrigger, ExtEffect>, rhs: Feature<IntTrigger, IntEffect, ExtTrigger, ExtEffect>) -> Bool {
        lhs.machines == rhs.machines && lhs.info == rhs.info
    }
}