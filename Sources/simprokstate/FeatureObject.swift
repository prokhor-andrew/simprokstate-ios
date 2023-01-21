//
//  FeatureObject.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


public struct FeatureObject<IntTrigger, IntEffect, ExtTrigger, ExtEffect> {

    public let machines: Machines<IntEffect, IntTrigger>

    private let _transit: Mapper<FeatureEvent<IntTrigger, ExtTrigger>, FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>?>

    public init(
            machines: Machines<IntEffect, IntTrigger>,
            transit: @escaping BiMapper<Machines<IntEffect, IntTrigger>, FeatureEvent<IntTrigger, ExtTrigger>, FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>?>
    ) {
        self.machines = machines
        self._transit = {
            transit(machines, $0)
        }
    }

    public init(transit: @escaping Mapper<FeatureEvent<IntTrigger, ExtTrigger>, FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>?>) {
        self.init(machines: Machines()) { _, event in
            transit(event)
        }
    }

    public func transit(trigger: FeatureEvent<IntTrigger, ExtTrigger>) -> FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>? {
        _transit(trigger)
    }
}
