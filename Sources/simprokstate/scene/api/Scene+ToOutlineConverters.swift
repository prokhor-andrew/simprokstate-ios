//
// Created by Andriy Prokhorenko on 19.02.2023.
//


public extension Scene {

    func asExtTriggerExtEffect<IntTrigger, IntEffect>() -> Outline<IntTrigger, IntEffect, Trigger, Effect> {
        if let transit {
            return Outline.create { event in
                switch event {
                case .ext(let value):
                    let new = transit(value)
                    return OutlineTransition(
                        new.state.asExtTriggerExtEffect(),
                        effects: new.effects.map { .ext($0) }
                    )
                case .int:
                    return OutlineTransition(asExtTriggerExtEffect())
                }
            }
        } else {
            return .finale()
        }
    }

    func asIntEffectExtTrigger<IntTrigger, ExtEffect>() -> Outline<IntTrigger, Effect, Trigger, ExtEffect> {
        if let transit {
            return Outline.create { event in
                switch event {
                case .ext(let value):
                    let new = transit(value)
                    return OutlineTransition(
                        new.state.asIntEffectExtTrigger(),
                        effects: new.effects.map {
                            .int($0)
                        }
                    )
                case .int:
                    return OutlineTransition(asIntEffectExtTrigger())
                }
            }
        } else {
            return .finale()
        }
    }

    func asIntTriggerExtEffect<IntEffect, ExtTrigger>() -> Outline<Trigger, IntEffect, ExtTrigger, Effect> {
        if let transit {
            return Outline.create { event in
                switch event {
                case .ext:
                    return OutlineTransition(asIntTriggerExtEffect())
                case .int(let value):
                    let new = transit(value)
                    return OutlineTransition(
                        new.state.asIntTriggerExtEffect(),
                        effects: new.effects.map {
                            .ext($0)
                        }
                    )
                }
            }
        } else {
            return .finale()
        }
    }

    func asIntTriggerIntEffect<ExtTrigger, ExtEffect>() -> Outline<Trigger, Effect, ExtTrigger, ExtEffect> {
        if let transit {
            return Outline.create { event in
                switch event {
                case .ext:
                    return OutlineTransition(asIntTriggerIntEffect())
                case .int(let value):
                    let new = transit(value)
                    return OutlineTransition(
                        new.state.asIntTriggerIntEffect(),
                        effects: new.effects.map {
                            .int($0)
                        }
                    )
                }
            }
        } else {
            return .finale()
        }
    }


    func asIntEffectExtTriggerExtEffect<IntTrigger>() -> Outline<IntTrigger, Effect, Trigger, Effect> {
        if let transit {
            return Outline.create { event in
                switch event {
                case .ext(let value):
                    let new = transit(value)
                    return OutlineTransition(
                        new.state.asIntEffectExtTriggerExtEffect(),
                        effects: new.effects.flatMap {
                            [.int($0), .ext($0)]
                        }
                    )
                case .int:
                    return OutlineTransition(asIntEffectExtTriggerExtEffect())
                }
            }
        } else {
            return .finale()
        }
    }

    func asIntTriggerIntEffectExtEffect<ExtTrigger>() -> Outline<Trigger, Effect, ExtTrigger, Effect> {
        if let transit {
            return Outline.create { event in
                switch event {
                case .ext:
                    return OutlineTransition(asIntTriggerIntEffectExtEffect())
                case .int(let value):
                    let new = transit(value)
                    return OutlineTransition(
                        new.state.asIntTriggerIntEffectExtEffect(),
                        effects: new.effects.flatMap {
                            [.int($0), .ext($0)]
                        }
                    )
                }
            }
        } else {
            return .finale()
        }
    }

    func asIntTriggerIntEffectExtTrigger<ExtEffect>() -> Outline<Trigger, Effect, Trigger, ExtEffect> {
        if let transit {
            return Outline.create { event in
                switch event {
                case .ext(let value),
                     .int(let value):
                    let new = transit(value)
                    return OutlineTransition(
                        new.state.asIntTriggerIntEffectExtTrigger(),
                        effects: new.effects.map {
                            .int($0)
                        }
                    )
                }
            }
        } else {
            return .finale()
        }
    }

    func asIntTriggerExtTriggerExtEffect<IntEffect>() -> Outline<Trigger, IntEffect, Trigger, Effect> {
        if let transit {
            return Outline.create { event in
                switch event {
                case .ext(let value),
                     .int(let value):
                    let new = transit(value)
                    return OutlineTransition(
                        new.state.asIntTriggerExtTriggerExtEffect(),
                        effects: new.effects.map {
                            .ext($0)
                        }
                    )
                }
            }
        } else {
            return .finale()
        }
    }

    func asIntTriggerIntEffectExtTriggerExtEffect() -> Outline<Trigger, Effect, Trigger, Effect>  {
        if let transit {
            return Outline.create { event in
                switch event {
                case .ext(let value),
                     .int(let value):
                    let new = transit(value)
                    return OutlineTransition(
                        new.state.asIntTriggerIntEffectExtTriggerExtEffect(),
                        effects: new.effects.flatMap {
                            [.int($0), .ext($0)]
                        }
                    )
                }
            }
        } else {
            return .finale()
        }
    }
}
