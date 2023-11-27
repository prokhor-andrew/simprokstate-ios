//
// Created by Andriy Prokhorenko on 17.02.2023.
//


extension Scene: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public static func ==(lhs: Scene<Trigger, Effect, Message>, rhs: Scene<Trigger, Effect, Message>) -> Bool {
        lhs.id == rhs.id
    }
}
