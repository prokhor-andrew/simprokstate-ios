//
//  File.swift
//  
//
//  Created by Andriy Prokhorenko on 28.11.2023.
//

import simprokmachine


public struct StoryExtras: Identifiable {
    
    public let id: String
    public let logger: (Loggable) -> Void
    
    internal init(id: String, logger: @escaping (Loggable) -> Void) {
        self.id = id
        self.logger = logger
    }
}
