//
// Created by Andriy Prokhorenko on 19.02.2023.
//

extension Outline: Hashable {

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public static func ==(lhs: Outline<IntTrigger, IntEffect, ExtTrigger, ExtEffect>, rhs: Outline<IntTrigger, IntEffect, ExtTrigger, ExtEffect>) -> Bool {
        lhs.id == rhs.id
    }
}
