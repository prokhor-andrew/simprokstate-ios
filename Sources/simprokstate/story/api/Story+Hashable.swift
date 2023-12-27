//
// Created by Andriy Prokhorenko on 16.02.2023.
//


extension Story: Hashable where Payload: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(payload)
    }
}

extension Story: Equatable where Payload: Equatable {

    public static func ==(lhs: Story<Payload, Event>, rhs: Story<Payload, Event>) -> Bool {
        lhs.payload == rhs.payload
    }
}
