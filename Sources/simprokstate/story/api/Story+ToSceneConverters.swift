//
// Created by Andriy Prokhorenko on 14.02.2023.
//


public extension Story {

    func asScene() -> Scene<Event, Event> {
        Scene { extras, trigger in
            if let new = transit(trigger, extras.logger) {
                return SceneTransition(
                    new.asScene(),
                    effects: trigger
                )
            } else {
                return SceneTransition(asScene())
            } 
        }
    }
}
