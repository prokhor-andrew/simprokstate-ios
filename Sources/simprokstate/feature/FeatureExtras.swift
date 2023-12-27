//
//  File.swift
//  
//
//  Created by Andriy Prokhorenko on 28.11.2023.
//

import simprokmachine

public struct FeatureExtras<Payload: Sendable, IntTrigger: Sendable, IntEffect: Sendable>: Sendable {
    
    public let payload: Payload
    public let machineId: String
    public let machines: Set<Machine<IntEffect, IntTrigger>>
    public let logger: MachineLogger
    
    internal init(
        payload: Payload,
        machineId: String,
        machines: Set<Machine<IntEffect, IntTrigger>>,
        logger: MachineLogger
    ) {
        self.payload = payload
        self.machineId = machineId
        self.machines = machines
        self.logger = logger
    }
}

extension FeatureExtras: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        "FeatureExtras<\(Payload.self), \(IntTrigger.self), \(IntEffect.self)> payload=\(payload) _ machineId=\(machineId) _ machines=\(machines)"
    }
    
    public var debugDescription: String { description }
}
