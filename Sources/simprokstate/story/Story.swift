//
//  Story.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.01.2020.
//  Copyright (c) 2020 simprok. All rights reserved.


public struct Story<Event: Sendable, Message>: Identifiable, Sendable {
    
    public let id: String = .id
    
    public let transit: @Sendable (Event, (Message) -> Void) -> Story<Event, Message>?

    public init(transit: @escaping @Sendable (Event, (Message) -> Void) -> Story<Event, Message>?) {
        self.transit = transit
    }
}
