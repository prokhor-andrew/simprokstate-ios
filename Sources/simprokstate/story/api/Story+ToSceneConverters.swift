//
// Created by Andriy Prokhorenko on 14.02.2023.
//


public extension Story {

    func asScene() -> Scene<Payload, Event, Event, Loggable> {
        Scene(payload: payload) { extras, trigger in
            if let new = transit(trigger, extras.machineId, extras.logger) {
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
