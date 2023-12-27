//
// Created by Andriy Prokhorenko on 17.02.2023.
//


extension Scene: Hashable where Payload: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(payload)
    }
}

extension Scene: Equatable where Payload: Equatable {

    public static func ==(lhs: Scene<Payload, Trigger, Effect>, rhs: Scene<Payload, Trigger, Effect>) -> Bool {
        lhs.payload == rhs.payload
    }
}
