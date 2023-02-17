//
// Created by Andriy Prokhorenko on 16.02.2023.
//


extension Story: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public static func ==(lhs: Story<Event>, rhs: Story<Event>) -> Bool {
        lhs.id == rhs.id
    }
}