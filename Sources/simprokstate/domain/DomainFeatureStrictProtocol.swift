//
//  DomainFeatureStrictProtocol.swift
//  simprokcore
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.


public protocol DomainFeatureStrictProtocol: DomainFeatureProtocol where ToFeature == Self {
    
}
