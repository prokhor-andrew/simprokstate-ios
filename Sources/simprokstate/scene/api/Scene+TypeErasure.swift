//
//  File.swift
//  
//
//  Created by Andriy Prokhorenko on 01.09.2023.
//


public protocol AnySceneEffect {
    
}

public protocol AnySceneTrigger {
    
}


public extension Scene where Trigger: AnySceneTrigger {
    
    func eraseTrigger() -> Scene<AnySceneTrigger, Effect> {
        if let transit {
            return Scene<AnySceneTrigger, Effect>.create { trigger in
                if let casted = trigger as? Trigger {
                    if let transition = transit(casted) {
                        return SceneTransition(
                            transition.state.eraseTrigger(),
                            effects: transition.effects
                        )
                    } else {
                        return nil
                    }
                } else {
                    return nil
                }
            }
        } else {
            return .finale()
        }
    }
}

public extension Scene where Effect: AnySceneEffect {
    
    func eraseEffect() -> Scene<Trigger, AnySceneEffect> {
        if let transit {
            return Scene<Trigger, AnySceneEffect>.create { trigger in
                if let transition = transit(trigger) {
                    return SceneTransition(
                        transition.state.eraseEffect(),
                        effects: transition.effects
                    )
                } else {
                    return nil
                }
            }
        } else {
            return .finale()
        }
    }
}

public extension Scene where Trigger: AnySceneTrigger, Effect: AnySceneEffect {
    
    func erase() -> Scene<AnySceneTrigger, AnySceneEffect> {
        if let transit {
            return Scene<AnySceneTrigger, AnySceneEffect>.create { trigger in
                if let casted = trigger as? Trigger {
                    if let transition = transit(casted) {
                        return SceneTransition(
                            transition.state.erase(),
                            effects: transition.effects
                        )
                    } else {
                        return nil
                    }
                } else {
                    return nil
                }
            }
        } else {
            return .finale()
        }
    }
}

prefix operator ^

public prefix func ^<Trigger: AnySceneTrigger, Effect: AnySceneEffect>(
    scene: Scene<Trigger, Effect>
) -> Scene<AnySceneTrigger, AnySceneEffect> {
    scene.erase()
}
