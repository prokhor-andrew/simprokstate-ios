//
//  File.swift
//  
//
//  Created by Andriy Prokhorenko on 28.11.2023.
//

import simprokmachine

public struct FeatureExtras<Machines: FeatureMachines>: Identifiable {
    
    public let id: String
    public let machines: Machines
    public let logger: (Loggable) -> Void
    
    internal init(
        id: String,
        machines: Machines,
        logger: @escaping (Loggable) -> Void
    ) {
        self.id = id
        self.machines = machines
        self.logger = logger
    }
}
