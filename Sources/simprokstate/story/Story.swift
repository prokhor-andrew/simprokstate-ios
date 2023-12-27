//
//  Story.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.01.2020.
//  Copyright (c) 2020 simprok. All rights reserved.

import simprokmachine

public struct Story<Payload: Sendable, Event: Sendable>: Sendable {
    
    public let payload: Payload
    public let transit: @Sendable (Event, String, MachineLogger) -> Story<Payload, Event>?

    public init(payload: Payload, transit: @escaping @Sendable (StoryExtras<Payload>, Event) -> Story<Payload, Event>?) {
        self.payload = payload
        self.transit = { trigger, machineId, logger in
            transit(StoryExtras(payload: payload, machineId: machineId, logger: logger), trigger)
        }
    }
}
