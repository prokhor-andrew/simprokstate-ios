//
// Created by Andriy Prokhorenko on 14.02.2023.
//

extension Feature: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(info)
        hasher.combine(machines)
    }

    public static func ==(lhs: Feature<IntTrigger, IntEffect, ExtTrigger, ExtEffect>, rhs: Feature<IntTrigger, IntEffect, ExtTrigger, ExtEffect>) -> Bool {
        lhs.machines == rhs.machines && lhs.info == rhs.info
    }
}
