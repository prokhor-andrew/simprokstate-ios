//
//  File.swift
//  
//
//  Created by Andriy Prokhorenko on 28.11.2023.
//

import simprokmachine


public struct StoryExtras: Identifiable, Sendable {
    
    public let id: String
    public let machineId: String
    public let logger: @Sendable (Loggable) -> Void
    
    internal init(id: String, machineId: String, logger: @escaping @Sendable (Loggable) -> Void) {
        self.id = id
        self.machineId = machineId
        self.logger = logger
    }
}

extension StoryExtras: CustomStringConvertible, CustomDebugStringConvertible {
    
    
    public var description: String {
        "id=\(id), machineId=\(machineId)"
    }
    
    public var debugDescription: String { description }
}
