//
// Created by Andriy Prokhorenko on 17.02.2023.
//

public struct Scene<Trigger: Sendable, Effect: Sendable>: Sendable {

    public let id: String = .id
    
    public let transit: Optional<@Sendable (Trigger) -> SceneTransition<Trigger, Effect>?>

    private init(_ transit: Optional<@Sendable (Trigger) -> SceneTransition<Trigger, Effect>?>) {
        self.transit = transit
    }

    public static func create(transit: @escaping @Sendable (Trigger) -> SceneTransition<Trigger, Effect>?) -> Scene<Trigger, Effect> {
        self.init(transit)
    }

    public static func finale() -> Scene<Trigger, Effect> {
        self.init(nil)
    }
}
