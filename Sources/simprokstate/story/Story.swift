//
//  Story.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.01.2020.
//  Copyright (c) 2020 simprok. All rights reserved.

import simprokmachine

public struct Story<Event> {

    public let info: String
    private let _transit: Mapper<Event, Story<Event>?>

    public init(_ info: String, transit: @escaping BiMapper<String, Event, Story<Event>?>) {
        self.info = info
        _transit = {
            transit(info, $0)
        }
    }

    public func transit(_ event: Event) -> Story<Event>? {
        _transit(event)
    }
}