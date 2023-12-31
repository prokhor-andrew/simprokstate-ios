//
//  File.swift
//  
//
//  Created by Andriy Prokhorenko on 28.11.2023.
//

import simprokmachine

public struct OutlineExtras<Payload: Sendable, Loggable: Sendable>: Sendable {
    
    public let payload: Payload
    public let machineId: String
    public let logger: MachineLogger<Loggable>
    
    internal init(payload: Payload, machineId: String, logger: MachineLogger<Loggable>) {
        self.payload = payload
        self.machineId = machineId
        self.logger = logger
    }
}

extension OutlineExtras: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        "Payload<\(Payload.self), \(Loggable.self)> payload=\(payload) _ machineId=\(machineId)"
    }
    
    public var debugDescription: String { description }
}

public extension Outline {
    
    func extras(machineId: String, logger: MachineLogger<Loggable>) -> OutlineExtras<Payload, Loggable> {
        OutlineExtras(payload: payload, machineId: machineId, logger: logger)
    }
}
