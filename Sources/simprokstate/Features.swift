//
//  Features.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine

public struct Features<IntTrigger, IntEffect, ExtTrigger, ExtEffect> {

    public let array: [FeatureObject<IntTrigger, IntEffect, ExtTrigger, ExtEffect>]

    public init(
            @FeaturesBuilder<IntTrigger, IntEffect, ExtTrigger, ExtEffect> _ build: Supplier<[FeatureObject<IntTrigger, IntEffect, ExtTrigger, ExtEffect>]>
    ) {
        self.array = build()
    }
}
