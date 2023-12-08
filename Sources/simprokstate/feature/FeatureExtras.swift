//
//  File.swift
//  
//
//  Created by Andriy Prokhorenko on 28.11.2023.
//

import simprokmachine

public struct FeatureExtras<Machines: FeatureMachines>: Identifiable, Sendable {
    
    public let id: String
    public let machineId: String
    public let machines: Machines
    public let logger: @Sendable (Loggable) -> Void
    
    internal init(
        id: String,
        machineId: String,
        machines: Machines,
        logger: @escaping @Sendable (Loggable) -> Void
    ) {
        self.id = id
        self.machineId = machineId
        self.machines = machines
        self.logger = logger
    }
}

extension FeatureExtras: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String { "id=\(id) _ machineId=\(machineId) _ machines=\(machines)" }
    
    public var debugDescription: String { description }
}
