//
// Created by Andriy Prokhorenko on 14.02.2023.
//

extension Feature: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public static func ==(lhs: Feature<IntTrigger, IntEffect, ExtTrigger, ExtEffect>, rhs: Feature<IntTrigger, IntEffect, ExtTrigger, ExtEffect>) -> Bool {
        lhs.id == rhs.id
    }
}
