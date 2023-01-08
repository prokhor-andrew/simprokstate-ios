//
//  Directed.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.


public enum Directed<Internal, External> {
    case int(Internal)
    case ext(External)
}
