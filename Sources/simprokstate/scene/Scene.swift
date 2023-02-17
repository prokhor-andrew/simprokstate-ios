//
// Created by Andriy Prokhorenko on 17.02.2023.
//

import Foundation
import simprokmachine

public struct Scene<Trigger, Effect> {

    public let id = UUID()
    public let transit: Mapper<Trigger, SceneTransition<Trigger, Effect>?>?

    private init(_ transit: Mapper<Trigger, SceneTransition<Trigger, Effect>?>?) {
        self.transit = transit
    }

    public static func create(transit: @escaping Mapper<Trigger, SceneTransition<Trigger, Effect>?>) -> Scene<Trigger, Effect> {
        self.init(transit)
    }

    public static func finale() -> Scene<Trigger, Effect> {
        self.init(nil)
    }
}
