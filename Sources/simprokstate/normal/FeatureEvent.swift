//
//  FeatureEvent.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.


public enum FeatureEvent<T> {
    case int(T)
    case ext(T)
    
    public var value: T {
        switch self {
        case .ext(let value), .int(let value):
            return value
        }
    }
    
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
