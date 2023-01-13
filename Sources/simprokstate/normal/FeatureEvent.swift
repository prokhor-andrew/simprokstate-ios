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
    
    public var isInternal: Bool { !isExternal }
}
