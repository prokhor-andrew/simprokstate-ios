//
// Created by Andriy Prokhorenko on 19.02.2023.
//


extension Outline: CustomStringConvertible, CustomDebugStringConvertible {

    public var description: String {
        "Outline id: \(id)"
    }
    
    public var debugDescription: String { description }
}
