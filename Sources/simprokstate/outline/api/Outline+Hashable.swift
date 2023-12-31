//
// Created by Andriy Prokhorenko on 19.02.2023.
//

extension Outline: Hashable where Payload: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(payload)
    }
}

extension Outline: Equatable where Payload: Equatable {
    
    public static func ==(
        lhs: Outline<Payload, IntTrigger, IntEffect, ExtTrigger, ExtEffect, Loggable>,
        rhs: Outline<Payload, IntTrigger, IntEffect, ExtTrigger, ExtEffect, Loggable>
    ) -> Bool {
        lhs.payload == rhs.payload
    }
}
