//
//  File.swift
//  
//
//  Created by Andriy Prokhorenko on 01.09.2023.
//


public protocol AnyOutlineIntTrigger {}

public protocol AnyOutlineIntEffect {}

public protocol AnyOutlineExtTrigger {}

public protocol AnyOutlineExtEffect {}


public extension Outline where IntTrigger: AnyOutlineIntTrigger {
    
    func eraseIntTrigger() -> Outline<AnyOutlineIntTrigger, IntEffect, ExtTrigger, ExtEffect> {
        if let transit {
            return Outline<AnyOutlineIntTrigger, IntEffect, ExtTrigger, ExtEffect>.create { trigger in
                switch trigger {
                case .int(let int):
                    if let casted = int as? IntTrigger {
                        if let transition = transit(.int(casted)) {
                            return OutlineTransition(
                                transition.state.eraseIntTrigger(),
                                effects: transition.effects
                            )
                        } else {
                            return nil
                        }
                    } else {
                        return nil
                    }
                case .ext(let ext):
                    if let transition = transit(.ext(ext)) {
                        return OutlineTransition(transition.state.eraseIntTrigger(), effects: transition.effects)
                    } else {
                        return nil
                    }
                }
            }
        } else {
            return .finale()
        }
    }
}

public extension Outline where IntEffect: AnyOutlineIntEffect {
    
    func eraseIntEffect() -> Outline<IntTrigger, AnyOutlineIntEffect, ExtTrigger, ExtEffect> {
        if let transit {
            return Outline<IntTrigger, AnyOutlineIntEffect, ExtTrigger, ExtEffect>.create { trigger in
                switch trigger {
                case .int(let int):
                    if let transition = transit(.int(int)) {
                        return OutlineTransition(
                            transition.state.eraseIntEffect(),
                            effects: transition.effects.map {
                                switch $0 {
                                case .int(let effect):
                                    return .int(effect)
                                case .ext(let effect):
                                    return .ext(effect)
                                }
                            }
                        )
                    } else {
                        return nil
                    }
                case .ext(let ext):
                    if let transition = transit(.ext(ext)) {
                        return OutlineTransition(
                            transition.state.eraseIntEffect(),
                            effects: transition.effects.map {
                                switch $0 {
                                case .int(let effect):
                                    return .int(effect)
                                case .ext(let effect):
                                    return .ext(effect)
                                }
                            }
                        )
                    } else {
                        return nil
                    }
                }
            }
        } else {
            return .finale()
        }
    }
}

public extension Outline where ExtTrigger: AnyOutlineExtTrigger {
    
    func eraseExtTrigger() -> Outline<IntTrigger, IntEffect, AnyOutlineExtTrigger, ExtEffect> {
        if let transit {
            return Outline<IntTrigger, IntEffect, AnyOutlineExtTrigger, ExtEffect>.create { trigger in
                switch trigger {
                case .int(let int):
                    if let transition = transit(.int(int)) {
                        return OutlineTransition(
                            transition.state.eraseExtTrigger(),
                            effects: transition.effects
                        )
                    } else {
                        return nil
                    }
                case .ext(let ext):
                    if let casted = ext as? ExtTrigger {
                        if let transition = transit(.ext(casted)) {
                            return OutlineTransition(
                                transition.state.eraseExtTrigger(),
                                effects: transition.effects
                            )
                        } else {
                            return nil
                        }
                    } else {
                        return nil
                    }
                }
            }
        } else {
            return .finale()
        }
    }
}

public extension Outline where ExtEffect: AnyOutlineExtEffect {
    
    func eraseExtEffect() -> Outline<IntTrigger, IntEffect, ExtTrigger, AnyOutlineExtEffect> {
        if let transit {
            return Outline<IntTrigger, IntEffect, ExtTrigger, AnyOutlineExtEffect>.create { trigger in
                switch trigger {
                case .int(let int):
                    if let transition = transit(.int(int)) {
                        return OutlineTransition(
                            transition.state.eraseExtEffect(),
                            effects: transition.effects.map {
                                switch $0 {
                                case .int(let effect):
                                    return .int(effect)
                                case .ext(let effect):
                                    return .ext(effect)
                                }
                            }
                        )
                    } else {
                        return nil
                    }
                case .ext(let ext):
                    if let transition = transit(.ext(ext)) {
                        return OutlineTransition(
                            transition.state.eraseExtEffect(),
                            effects: transition.effects.map {
                                switch $0 {
                                case .int(let effect):
                                    return .int(effect)
                                case .ext(let effect):
                                    return .ext(effect)
                                }
                            }
                        )
                    } else {
                        return nil
                    }
                }
            }
        } else {
            return .finale()
        }
    }
}

public extension Outline where IntTrigger: AnyOutlineIntTrigger, IntEffect: AnyOutlineIntEffect {
    
    func eraseIntTriggerIntEffect() -> Outline<AnyOutlineIntTrigger, AnyOutlineIntEffect, ExtTrigger, ExtEffect> {
        if let transit {
            return Outline<AnyOutlineIntTrigger, AnyOutlineIntEffect, ExtTrigger, ExtEffect>.create { trigger in
                switch trigger {
                case .int(let int):
                    if let casted = int as? IntTrigger {
                        if let transition = transit(.int(casted)) {
                            return OutlineTransition(
                                transition.state.eraseIntTriggerIntEffect(),
                                effects: transition.effects.map {
                                    switch $0 {
                                    case .int(let int):
                                        return .int(int)
                                    case .ext(let ext):
                                        return .ext(ext)
                                    }
                                }
                            )
                        } else {
                            return nil
                        }
                    } else {
                        return nil
                    }
                case .ext(let ext):
                    if let transition = transit(.ext(ext)) {
                        return OutlineTransition(
                            transition.state.eraseIntTriggerIntEffect(),
                            effects: transition.effects.map {
                                switch $0 {
                                case .int(let int):
                                    return .int(int)
                                case .ext(let ext):
                                    return .ext(ext)
                                }
                            }
                        )
                    } else {
                        return nil
                    }
                }
            }
        } else {
            return .finale()
        }
    }
}

public extension Outline where IntTrigger: AnyOutlineIntTrigger, ExtTrigger: AnyOutlineExtTrigger {
    
    func eraseIntTriggerExtTrigger() -> Outline<AnyOutlineIntTrigger, IntEffect, AnyOutlineExtTrigger, ExtEffect> {
        if let transit {
            return Outline<AnyOutlineIntTrigger, IntEffect, AnyOutlineExtTrigger, ExtEffect>.create { trigger in
                switch trigger {
                case .int(let int):
                    if let casted = int as? IntTrigger {
                        if let transition = transit(.int(casted)) {
                            return OutlineTransition(
                                transition.state.eraseIntTriggerExtTrigger(),
                                effects: transition.effects.map {
                                    switch $0 {
                                    case .int(let int):
                                        return .int(int)
                                    case .ext(let ext):
                                        return .ext(ext)
                                    }
                                }
                            )
                        } else {
                            return nil
                        }
                    } else {
                        return nil
                    }
                case .ext(let ext):
                    if let casted = ext as? ExtTrigger {
                        if let transition = transit(.ext(casted)) {
                            return OutlineTransition(
                                transition.state.eraseIntTriggerExtTrigger(),
                                effects: transition.effects.map {
                                    switch $0 {
                                    case .int(let int):
                                        return .int(int)
                                    case .ext(let ext):
                                        return .ext(ext)
                                    }
                                }
                            )
                        } else {
                            return nil
                        }
                    } else {
                        return nil
                    }
                }
            }
        } else {
            return .finale()
        }
    }
}

public extension Outline where IntTrigger: AnyOutlineIntTrigger, ExtEffect: AnyOutlineExtEffect {
    
    func eraseIntTriggerExtEffect() -> Outline<AnyOutlineIntTrigger, IntEffect, ExtTrigger, AnyOutlineExtEffect> {
        if let transit {
            return Outline<AnyOutlineIntTrigger, IntEffect, ExtTrigger, AnyOutlineExtEffect>.create { trigger in
                switch trigger {
                case .int(let int):
                    if let casted = int as? IntTrigger {
                        if let transition = transit(.int(casted)) {
                            return OutlineTransition(
                                transition.state.eraseIntTriggerExtEffect(),
                                effects: transition.effects.map {
                                    switch $0 {
                                    case .int(let int):
                                        return .int(int)
                                    case .ext(let ext):
                                        return .ext(ext)
                                    }
                                }
                            )
                        } else {
                            return nil
                        }
                    } else {
                        return nil
                    }
                case .ext(let ext):
                    if let transition = transit(.ext(ext)) {
                        return OutlineTransition(
                            transition.state.eraseIntTriggerExtEffect(),
                            effects: transition.effects.map {
                                switch $0 {
                                case .int(let int):
                                    return .int(int)
                                case .ext(let ext):
                                    return .ext(ext)
                                }
                            }
                        )
                    } else {
                        return nil
                    }
                }
            }
        } else {
            return .finale()
        }
    }
}

public extension Outline where IntEffect: AnyOutlineIntEffect, ExtTrigger: AnyOutlineExtTrigger {
    
    func eraseIntEffectExtTrigger() -> Outline<IntTrigger, AnyOutlineIntEffect, AnyOutlineExtTrigger, ExtEffect> {
        if let transit {
            return Outline<IntTrigger, AnyOutlineIntEffect, AnyOutlineExtTrigger, ExtEffect>.create { trigger in
                switch trigger {
                case .int(let int):
                    if let transition = transit(.int(int)) {
                        return OutlineTransition(
                            transition.state.eraseIntEffectExtTrigger(),
                            effects: transition.effects.map {
                                switch $0 {
                                case .int(let int):
                                    return .int(int)
                                case .ext(let ext):
                                    return .ext(ext)
                                }
                            }
                        )
                    } else {
                        return nil
                    }
                case .ext(let ext):
                    if let casted = ext as? ExtTrigger {
                        if let transition = transit(.ext(casted)) {
                            return OutlineTransition(
                                transition.state.eraseIntEffectExtTrigger(),
                                effects: transition.effects.map {
                                    switch $0 {
                                    case .int(let int):
                                        return .int(int)
                                    case .ext(let ext):
                                        return .ext(ext)
                                    }
                                }
                            )
                        } else {
                            return nil
                        }
                    } else {
                        return nil
                    }
                }
            }
        } else {
            return .finale()
        }
    }
}

public extension Outline where IntEffect: AnyOutlineIntEffect, ExtEffect: AnyOutlineExtEffect {
    
    func eraseIntEffectExtEffect() -> Outline<IntTrigger, AnyOutlineIntEffect, ExtTrigger, AnyOutlineExtEffect> {
        if let transit {
            return Outline<IntTrigger, AnyOutlineIntEffect, ExtTrigger, AnyOutlineExtEffect>.create { trigger in
                switch trigger {
                case .int(let int):
                    if let transition = transit(.int(int)) {
                        return OutlineTransition(
                            transition.state.eraseIntEffectExtEffect(),
                            effects: transition.effects.map {
                                switch $0 {
                                case .int(let int):
                                    return .int(int)
                                case .ext(let ext):
                                    return .ext(ext)
                                }
                            }
                        )
                    } else {
                        return nil
                    }
                case .ext(let ext):
                    if let transition = transit(.ext(ext)) {
                        return OutlineTransition(
                            transition.state.eraseIntEffectExtEffect(),
                            effects: transition.effects.map {
                                switch $0 {
                                case .int(let int):
                                    return .int(int)
                                case .ext(let ext):
                                    return .ext(ext)
                                }
                            }
                        )
                    } else {
                        return nil
                    }
                }
            }
        } else {
            return .finale()
        }
    }
}

public extension Outline where IntTrigger: AnyOutlineIntTrigger, IntEffect: AnyOutlineIntEffect, ExtTrigger: AnyOutlineExtTrigger {
    
    func eraseIntTriggerIntEffect() -> Outline<AnyOutlineIntTrigger, AnyOutlineIntEffect, AnyOutlineExtTrigger, ExtEffect> {
        if let transit {
            return Outline<AnyOutlineIntTrigger, AnyOutlineIntEffect, AnyOutlineExtTrigger, ExtEffect>.create { trigger in
                switch trigger {
                case .int(let int):
                    if let casted = int as? IntTrigger {
                        if let transition = transit(.int(casted)) {
                            return OutlineTransition(
                                transition.state.eraseIntTriggerIntEffect(),
                                effects: transition.effects.map {
                                    switch $0 {
                                    case .int(let int):
                                        return .int(int)
                                    case .ext(let ext):
                                        return .ext(ext)
                                    }
                                }
                            )
                        } else {
                            return nil
                        }
                    } else {
                        return nil
                    }
                case .ext(let ext):
                    if let casted = ext as? ExtTrigger {
                        if let transition = transit(.ext(casted)) {
                            return OutlineTransition(
                                transition.state.eraseIntTriggerIntEffect(),
                                effects: transition.effects.map {
                                    switch $0 {
                                    case .int(let int):
                                        return .int(int)
                                    case .ext(let ext):
                                        return .ext(ext)
                                    }
                                }
                            )
                        } else {
                            return nil
                        }
                    } else {
                        return nil
                    }
                }
            }
        } else {
            return .finale()
        }
    }
}

public extension Outline where IntTrigger: AnyOutlineIntTrigger, IntEffect: AnyOutlineIntEffect, ExtEffect: AnyOutlineExtEffect {
    
    func eraseIntTriggerIntEffectExtEffect() -> Outline<AnyOutlineIntTrigger, AnyOutlineIntEffect, ExtTrigger, AnyOutlineExtEffect> {
        if let transit {
            return Outline<AnyOutlineIntTrigger, AnyOutlineIntEffect, ExtTrigger, AnyOutlineExtEffect>.create { trigger in
                switch trigger {
                case .int(let int):
                    if let casted = int as? IntTrigger {
                        if let transition = transit(.int(casted)) {
                            return OutlineTransition(
                                transition.state.eraseIntTriggerIntEffectExtEffect(),
                                effects: transition.effects.map {
                                    switch $0 {
                                    case .int(let int):
                                        return .int(int)
                                    case .ext(let ext):
                                        return .ext(ext)
                                    }
                                }
                            )
                        } else {
                            return nil
                        }
                    } else {
                        return nil
                    }
                case .ext(let ext):
                    if let transition = transit(.ext(ext)) {
                        return OutlineTransition(
                            transition.state.eraseIntTriggerIntEffectExtEffect(),
                            effects: transition.effects.map {
                                switch $0 {
                                case .int(let int):
                                    return .int(int)
                                case .ext(let ext):
                                    return .ext(ext)
                                }
                            }
                        )
                    } else {
                        return nil
                    }
                }
            }
        } else {
            return .finale()
        }
    }
}

public extension Outline where IntTrigger: AnyOutlineIntTrigger, ExtTrigger: AnyOutlineExtTrigger, ExtEffect: AnyOutlineExtEffect {
    
    func eraseIntTriggerExtTriggerExtEffect() -> Outline<AnyOutlineIntTrigger, IntEffect, AnyOutlineExtTrigger, AnyOutlineExtEffect> {
        if let transit {
            return Outline<AnyOutlineIntTrigger, IntEffect, AnyOutlineExtTrigger, AnyOutlineExtEffect>.create { trigger in
                switch trigger {
                case .int(let int):
                    if let casted = int as? IntTrigger {
                        if let transition = transit(.int(casted)) {
                            return OutlineTransition(
                                transition.state.eraseIntTriggerExtTriggerExtEffect(),
                                effects: transition.effects.map {
                                    switch $0 {
                                    case .int(let int):
                                        return .int(int)
                                    case .ext(let ext):
                                        return .ext(ext)
                                    }
                                }
                            )
                        } else {
                            return nil
                        }
                    } else {
                        return nil
                    }
                case .ext(let ext):
                    if let casted = ext as? ExtTrigger {
                        if let transition = transit(.ext(casted)) {
                            return OutlineTransition(
                                transition.state.eraseIntTriggerExtTriggerExtEffect(),
                                effects: transition.effects.map {
                                    switch $0 {
                                    case .int(let int):
                                        return .int(int)
                                    case .ext(let ext):
                                        return .ext(ext)
                                    }
                                }
                            )
                        } else {
                            return nil
                        }
                    } else {
                        return nil
                    }
                }
            }
        } else {
            return .finale()
        }
    }
}

public extension Outline where IntEffect: AnyOutlineIntEffect, ExtTrigger: AnyOutlineExtTrigger, ExtEffect: AnyOutlineExtEffect {
    
    func eraseIntEffectExtTriggerExtEffect() -> Outline<IntTrigger, AnyOutlineIntEffect, AnyOutlineExtTrigger, AnyOutlineExtEffect> {
        if let transit {
            return Outline<IntTrigger, AnyOutlineIntEffect, AnyOutlineExtTrigger, AnyOutlineExtEffect>.create { trigger in
                switch trigger {
                case .int(let int):
                    if let transition = transit(.int(int)) {
                        return OutlineTransition(
                            transition.state.eraseIntEffectExtTriggerExtEffect(),
                            effects: transition.effects.map {
                                switch $0 {
                                case .int(let int):
                                    return .int(int)
                                case .ext(let ext):
                                    return .ext(ext)
                                }
                            }
                        )
                    } else {
                        return nil
                    }
                case .ext(let ext):
                    if let casted = ext as? ExtTrigger {
                        if let transition = transit(.ext(casted)) {
                            return OutlineTransition(
                                transition.state.eraseIntEffectExtTriggerExtEffect(),
                                effects: transition.effects.map {
                                    switch $0 {
                                    case .int(let int):
                                        return .int(int)
                                    case .ext(let ext):
                                        return .ext(ext)
                                    }
                                }
                            )
                        } else {
                            return nil
                        }
                    } else {
                        return nil
                    }
                }
            }
        } else {
            return .finale()
        }
    }
}

public extension Outline where IntTrigger: AnyOutlineIntTrigger, IntEffect: AnyOutlineIntEffect, ExtTrigger: AnyOutlineExtTrigger, ExtEffect: AnyOutlineExtEffect {
    
    func erase() -> Outline<AnyOutlineIntTrigger, AnyOutlineIntEffect, AnyOutlineExtTrigger, AnyOutlineExtEffect> {
        if let transit {
            return Outline<AnyOutlineIntTrigger, AnyOutlineIntEffect, AnyOutlineExtTrigger, AnyOutlineExtEffect>.create { trigger in
                switch trigger {
                case .int(let int):
                    if let casted = int as? IntTrigger {
                        if let transition = transit(.int(casted)) {
                            return OutlineTransition(
                                transition.state.erase(),
                                effects: transition.effects.map {
                                    switch $0 {
                                    case .int(let int):
                                        return .int(int)
                                    case .ext(let ext):
                                        return .ext(ext)
                                    }
                                }
                            )
                        } else {
                            return nil
                        }
                    } else {
                        return nil
                    }
                case .ext(let ext):
                    if let casted = ext as? ExtTrigger {
                        if let transition = transit(.ext(casted)) {
                            return OutlineTransition(
                                transition.state.erase(),
                                effects: transition.effects.map {
                                    switch $0 {
                                    case .int(let int):
                                        return .int(int)
                                    case .ext(let ext):
                                        return .ext(ext)
                                    }
                                }
                            )
                        } else {
                            return nil
                        }
                    } else {
                        return nil
                    }
                }
            }
        } else {
            return .finale()
        }
    }
}

prefix operator ^

public prefix func ^<IntTrigger: AnyOutlineIntTrigger, IntEffect: AnyOutlineIntEffect, ExtTrigger: AnyOutlineExtTrigger, ExtEffect: AnyOutlineExtEffect>(
    outline: Outline<IntTrigger, IntEffect, ExtTrigger, ExtEffect>
) -> Outline<AnyOutlineIntTrigger, AnyOutlineIntEffect, AnyOutlineExtTrigger, AnyOutlineExtEffect> {
    outline.erase()
}
