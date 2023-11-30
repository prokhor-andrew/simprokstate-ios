//
//  File.swift
//  
//
//  Created by Andriy Prokhorenko on 28.11.2023.
//

import simprokmachine

public struct OutlineExtras: Identifiable {
    
    public let id: String
    public let machineId: String
    public let logger: (Loggable) -> Void
    
    internal init(id: String, machineId: String, logger: @escaping (Loggable) -> Void) {
        self.id = id
        self.machineId = machineId
        self.logger = logger
    }
}
