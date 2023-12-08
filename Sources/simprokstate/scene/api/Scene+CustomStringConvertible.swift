//
// Created by Andriy Prokhorenko on 17.02.2023.
//


extension Scene: CustomStringConvertible, CustomDebugStringConvertible {

    public var description: String {
        "Scene id: \(id)"
    }
    
    public var debugDescription: String { description }
}
