//
//  Story.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.01.2020.
//  Copyright (c) 2020 simprok. All rights reserved.

import simprokmachine

public struct Story<Event: Sendable>: Identifiable, Sendable {
    
    public let id: String = .id
    
    public let transit: @Sendable (Event, (Loggable) -> Void) -> Story<Event>?

    public init(transit: @escaping @Sendable (Event, (Loggable) -> Void) -> Story<Event>?) {
        self.transit = transit
    }
}
