//
//  File.swift
//  
//
//  Created by Andriy Prokhorenko on 28.11.2023.
//

import simprokmachine

public struct FeatureExtras<Payload: Sendable, IntTrigger: Sendable, IntEffect: Sendable, Loggable: Sendable>: Sendable {
    
    public let payload: Payload
    public let machineId: String
    public let machines: Set<Machine<IntEffect, IntTrigger, Loggable>>
    public let logger: MachineLogger<Loggable>
    
    internal init(
        payload: Payload,
        machineId: String,
        machines: Set<Machine<IntEffect, IntTrigger, Loggable>>,
        logger: MachineLogger<Loggable>
    ) {
        self.payload = payload
        self.machineId = machineId
        self.machines = machines
        self.logger = logger
    }
}

extension FeatureExtras: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        "FeatureExtras<\(Payload.self), \(IntTrigger.self), \(IntEffect.self), \(Loggable.self)> payload=\(payload) _ machineId=\(machineId) _ machines=\(machines)"
    }
    
    public var debugDescription: String { description }
}


public extension Feature {
    
    func extras(machineId: String, logger: MachineLogger<Loggable>) -> FeatureExtras<Payload, IntTrigger, IntEffect, Loggable> {
        FeatureExtras(payload: payload, machineId: machineId, machines: machines, logger: logger)
    }
}
