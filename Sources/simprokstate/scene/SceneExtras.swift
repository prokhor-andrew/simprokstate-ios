//
//  File.swift
//  
//
//  Created by Andriy Prokhorenko on 28.11.2023.
//

import simprokmachine


public struct SceneExtras<Payload: Sendable, Loggable: Sendable>: Sendable {
    
    public let payload: Payload
    public let machineId: String
    public let logger: MachineLogger<Loggable>
    
    
    internal init(payload: Payload, machineId: String, logger: MachineLogger<Loggable>) {
        self.payload = payload
        self.machineId = machineId
        self.logger = logger
    }
}


extension SceneExtras: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        "SceneExtras<\(Payload.self), \(Loggable.self)> payload=\(payload), machineId=\(machineId)"
    }
    
    public var debugDescription: String { description }
}

public extension Scene {
    
    func extras(machineId: String, logger: MachineLogger<Loggable>) -> SceneExtras<Payload, Loggable> {
        SceneExtras(payload: payload, machineId: machineId, logger: logger)
    }
}
