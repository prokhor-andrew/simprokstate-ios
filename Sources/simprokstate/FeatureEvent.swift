//
//  FeatureEvent.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.


public enum FeatureEvent<Internal, External> {
    case int(Internal)
    case ext(External)

    public var isExternal: Bool {
        switch self {
        case .int:
            return false
        case .ext:
            return true
        }
    }

    public var isInternal: Bool {
        !isExternal
    }
}


extension FeatureEvent: Equatable where Internal: Equatable, External: Equatable {
    public static func ==(lhs: FeatureEvent<Internal, External>, rhs: FeatureEvent<Internal, External>) -> Bool {
        switch (lhs, rhs) {
        case (.int(let val1), .int(let val2)):
            return val1 == val2
        case (.ext(let val1), .ext(let val2)):
            return val1 == val2
        default:
            return false
        }
    }
}