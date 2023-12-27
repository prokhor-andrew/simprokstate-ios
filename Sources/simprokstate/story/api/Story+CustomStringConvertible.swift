//
// Created by Andriy Prokhorenko on 14.02.2023.
//


extension Story: CustomStringConvertible {

    public var description: String {
        "Story<\(Payload.self), \(Event.self)> payload=\(payload)"
    }
}
