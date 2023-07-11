//
//  Story.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.01.2020.
//  Copyright (c) 2020 simprok. All rights reserved.

import simprokmachine

public struct Story<Event> {
    
    public let id: String = .id
    
    public let transit: Optional<(Event) -> Story<Event>?>

    private init(_ transit: Optional<(Event) -> Story<Event>?>) {
        self.transit = transit
    }

    public static func finale() -> Story<Event> {
        Story(nil)
    }

    public static func create(transit: @escaping (Event) -> Story<Event>?) -> Story<Event> {
        Story(transit)
    }
}
