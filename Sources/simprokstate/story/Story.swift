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
    public let isFinale: Bool
    private let _transit: Mapper<Event, Story<Event>?>


    private init(isFinale: Bool, transit: @escaping Mapper<Event, Story<Event>?>) {
        self.isFinale = isFinale
        _transit = transit
    }

    public func transit(_ event: Event) -> Story<Event>? {
        _transit(event)
    }


    public static func finale() -> Story<Event> {
        Story(isFinale: true) { _ in nil }
    }

    public static func create(transit: @escaping Mapper<Event, Story<Event>?>) -> Story<Event> {
        Story(isFinale: false, transit: transit)
    }
}