//
//  Feature.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.01.2020.
//  Copyright (c) 2020 simprok. All rights reserved.

import Foundation
import simprokmachine

public struct Feature<IntTrigger, IntEffect, ExtTrigger, ExtEffect> {

    public let id = UUID()
    public let isFinale: Bool
    public let machines: Set<Machine<IntEffect, IntTrigger>>

    private let _transit: Mapper<FeatureEvent<IntTrigger, ExtTrigger>, FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>>

    private init(
            machines: Set<Machine<IntEffect, IntTrigger>>,
            isFinale: Bool,
            transit: @escaping Mapper<FeatureEvent<IntTrigger, ExtTrigger>, FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>>
    ) {
        self.machines = machines
        self.isFinale = isFinale
        _transit = transit
    }

    public static func finale() -> Feature<IntTrigger, IntEffect, ExtTrigger, ExtEffect> {
        Feature(machines: [], isFinale: true) { _ in
            FeatureTransition(finale())
        }
    }

    public static func create<Machines: FeatureMachines>(
            _ machines: Machines,
            transit: @escaping BiMapper<Machines, FeatureEvent<IntTrigger, ExtTrigger>, FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>>
    ) -> Feature<IntTrigger, IntEffect, ExtTrigger, ExtEffect>  where Machines.Trigger == IntTrigger, Machines.Effect == IntEffect {
        Feature(machines: machines.machines, isFinale: false) {
            transit(machines, $0)
        }
    }

    public func transit(trigger: FeatureEvent<IntTrigger, ExtTrigger>) -> FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect> {
        _transit(trigger)
    }
}



