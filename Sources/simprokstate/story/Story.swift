//
//  Story.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.01.2020.
//  Copyright (c) 2020 simprok. All rights reserved.


public struct Story<Event: Sendable>: Identifiable, Sendable {
    
    public let id: String = .id
    
    public let transit: Optional<@Sendable (Event) -> Story<Event>?>

    private init(_ transit: Optional<@Sendable (Event) -> Story<Event>?>) {
        self.transit = transit
    }

    public static func finale() -> Story<Event> {
        Story(nil)
    }

    public static func create(transit: @escaping @Sendable (Event) -> Story<Event>?) -> Story<Event> {
        Story(transit)
    }
}
