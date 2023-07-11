//
// Created by Andriy Prokhorenko on 17.02.2023.
//

import simprokmachine

public struct Scene<Trigger, Effect> {

    public let id: String = .id
    
    public let transit: Optional<(Trigger) -> SceneTransition<Trigger, Effect>?>

    private init(_ transit: Optional<(Trigger) -> SceneTransition<Trigger, Effect>?>) {
        self.transit = transit
    }

    public static func create(transit: @escaping (Trigger) -> SceneTransition<Trigger, Effect>?) -> Scene<Trigger, Effect> {
        self.init(transit)
    }

    public static func finale() -> Scene<Trigger, Effect> {
        self.init(nil)
    }
}
