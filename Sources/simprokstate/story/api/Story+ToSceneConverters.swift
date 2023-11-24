//
// Created by Andriy Prokhorenko on 14.02.2023.
//


public extension Story {

    func asScene() -> Scene<Event, Event> {
        Scene { value in
            if let new = transit(value) {
                return SceneTransition(
                    new.asScene(),
                    effects: value
                )
            } else {
                return SceneTransition(asScene())
            }
        }
    }
}
