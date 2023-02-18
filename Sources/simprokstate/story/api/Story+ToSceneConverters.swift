//
// Created by Andriy Prokhorenko on 14.02.2023.
//

import simprokmachine

public extension Story {

    func asScene() -> Scene<Event, Event> {
        if let transit {
            let scene: Scene<Event, Event> = Scene.create { value in
                if let new = transit(value) {
                    return SceneTransition(
                            new.asScene(),
                            effects: value
                    )
                } else {
                    return SceneTransition(scene)
                }
            }

            return scene
        } else {
            return .finale()
        }
    }
}