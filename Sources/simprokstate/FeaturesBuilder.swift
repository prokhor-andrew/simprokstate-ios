//
//  FeaturesBuilder.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.


@resultBuilder
public struct FeaturesBuilder<IntTrigger, IntEffect, ExtTrigger, ExtEffect> {

    public static func buildBlock(
            _ components: Features<IntTrigger, IntEffect, ExtTrigger, ExtEffect>...
    ) -> [FeatureObject<IntTrigger, IntEffect, ExtTrigger, ExtEffect>] {
        components.flatMap {
            $0.array
        }
    }

    public static func buildBlock(
            _ components: FeatureObject<IntTrigger, IntEffect, ExtTrigger, ExtEffect>...
    ) -> [FeatureObject<IntTrigger, IntEffect, ExtTrigger, ExtEffect>] {
        components
    }


    private init() {

    }
}
