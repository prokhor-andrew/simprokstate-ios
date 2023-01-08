//
//  Transition.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.


public enum Transition<F: Scenario> {
    case skip
    case set(F)
}
