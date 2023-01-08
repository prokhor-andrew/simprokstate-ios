//
//  ScenarioAutomaton.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


public final class ScenarioAutomaton<InternalTrigger, InternalEffect, ExternalTrigger, ExternalEffect>: Machine {
    public typealias Input = ExternalTrigger
    public typealias Output = ExternalEffect
    
    private var state: BasicScenario<InternalTrigger, InternalEffect, ExternalTrigger, ExternalEffect>

    private var subscriptions: [ObjectIdentifier: Subscription<InternalEffect, InternalTrigger>] = [:]

    public init<S: Scenario>(_ initial: S) where
    S.InternalTrigger == InternalTrigger,
    S.InternalEffect == InternalEffect,
    S.ExternalTrigger == ExternalTrigger,
    S.ExternalEffect == ExternalEffect {
        self.state = initial.basic
    }

    public let isProcessOnMain: Bool = false
    
    public func onProcess(input: Input?, callback: @escaping Handler<Output>) {
        if let input = input {
            handle(event: .ext(input), callback: callback)
        } else {
            // initial
            config(callback: callback)
        }
    }

    private func handle(event: Directed<InternalTrigger, ExternalTrigger>, callback: @escaping Handler<Output>) {
        switch state.transit(trigger: event) {
        case .skip:
            break
        case .set(let new):
            state = new
            config(callback: callback)
        }
    }

    private func config(callback: @escaping Handler<Output>) {
        // removing subscriptions that are not present in new state
        subscriptions = subscriptions.reduce(subscriptions) { dict, element in
            let (key, _) = element

            let ids: Set<ObjectIdentifier> = Set(state.machines.map { ObjectIdentifier($0) })
            if !ids.contains(key) {
                var copy = dict
                copy.removeValue(forKey: key)
                return copy
            } else {
                return dict
            }
        }

        // adding subscriptions that are present in new state
        subscriptions = state.machines.reduce(subscriptions) { [weak self] dict, machine in
            let key = ObjectIdentifier(machine)

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
        state.effects.forEach { event in
            switch event {
            case .int(let output):
                subscriptions.forEach { $0.value.send(input: output) }
            case .ext(let output):
                callback(output)
            }
        }
    }
    
    public func onClearUp() {
        
    }
}


private extension Scenario {

    var basic: BasicScenario<InternalTrigger, InternalEffect, ExternalTrigger, ExternalEffect> {
        BasicScenario(effects: effects, machines: machines) {
            switch transit(trigger: $0) {
            case .skip:
                return .skip
            case .set(let new):
                return .set(new.basic)
            }
        }
    }
}
