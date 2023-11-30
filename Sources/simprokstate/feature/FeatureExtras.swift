//
//  File.swift
//  
//
//  Created by Andriy Prokhorenko on 28.11.2023.
//

import simprokmachine

public struct FeatureExtras<Machines: FeatureMachines>: Identifiable {
    
    public let id: String
    public let machineId: String
    public let machines: Machines
    public let logger: (Loggable) -> Void
    
    internal init(
        id: String,
        machineId: String,
        machines: Machines,
        logger: @escaping (Loggable) -> Void
    ) {
        self.id = id
        self.machineId = machineId
        self.machines = machines
        self.logger = logger
    }
}
