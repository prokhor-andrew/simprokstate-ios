//
//  Story.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.01.2020.
//  Copyright (c) 2020 simprok. All rights reserved.

import simprokmachine

public struct Story<Event: Sendable>: Identifiable, Sendable {
    
    public let id: String
    public let transit: @Sendable (Event, @escaping (Loggable) -> Void) -> Story<Event>?

    public init(transit: @escaping @Sendable (StoryExtras, Event) -> Story<Event>?) {
        let id: String = .id
        self.id = id
        self.transit = {
            transit(StoryExtras(id: id, logger: $1), $0)
        }
    }
}
