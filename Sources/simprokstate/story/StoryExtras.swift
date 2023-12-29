//
//  File.swift
//  
//
//  Created by Andriy Prokhorenko on 28.11.2023.
//

import simprokmachine


public struct StoryExtras<Payload: Sendable>: Sendable {
    
    public let payload: Payload
    public let machineId: String
    public let logger: MachineLogger
    
    internal init(payload: Payload, machineId: String, logger: MachineLogger) {
        self.payload = payload
        self.machineId = machineId
        self.logger = logger
    }
}

extension StoryExtras: CustomStringConvertible, CustomDebugStringConvertible {
    
    
    public var description: String {
        "StoryExtras<\(Payload.self)> payload=\(payload) _ machineId=\(machineId)"
    }
    
    public var debugDescription: String { description }
}

public extension Story {
    
    func extras(machineId: String, logger: MachineLogger) -> StoryExtras<Payload> {
        StoryExtras(payload: payload, machineId: machineId, logger: logger)
    }
}
