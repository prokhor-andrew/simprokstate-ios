//
// Created by Andriy Prokhorenko on 14.02.2023.
//

extension Feature: Hashable where Payload: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(payload)
        hasher.combine(machines)
    }
}

extension Feature: Equatable where Payload: Equatable {
    public static func ==(lhs: Feature<Payload, IntTrigger, IntEffect, ExtTrigger, ExtEffect, Loggable>, rhs: Feature<Payload, IntTrigger, IntEffect, ExtTrigger, ExtEffect, Loggable>) -> Bool {
        lhs.payload == rhs.payload && lhs.machines == rhs.machines
    }
}
