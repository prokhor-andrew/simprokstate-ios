//
//  FeatureEvent.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.01.2020.
//  Copyright (c) 2020 simprok. All rights reserved.

import Foundation

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
