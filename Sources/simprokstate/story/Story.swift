//
//  Story.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.01.2020.
//  Copyright (c) 2020 simprok. All rights reserved.

import Foundation
import simprokmachine

public struct Story<Event> {

    public let id = UUID()
    public let transit: Mapper<Event, Story<Event>?>?

    private init(_ transit: Mapper<Event, Story<Event>?>?) {
        self.transit = transit
    }

    public static func finale() -> Story<Event> {
        Story { _ in nil }
    }

    public static func create(transit: @escaping Mapper<Event, Story<Event>?>) -> Story<Event> {
        Story(nil)
    }
}