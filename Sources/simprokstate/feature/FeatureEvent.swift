//
//  FeatureEvent.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.01.2020.
//  Copyright (c) 2020 simprok. All rights reserved.



public enum FeatureEvent<Internal: Sendable, External: Sendable>: Sendable {
    case int(Internal)
    case ext(External)

    public var isExternal: Bool {
        switch self {
        case .int: false
        case .ext: true
        }
    }

    public var isInternal: Bool {
        !isExternal
    }
}
