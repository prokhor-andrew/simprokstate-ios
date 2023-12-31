//
// Created by Andriy Prokhorenko on 19.02.2023.
//


public extension Scene {

    func asExtTriggerExtEffect<IntTrigger, IntEffect>() -> Outline<Payload, IntTrigger, IntEffect, Trigger, Effect, Loggable> {
        Outline(payload: payload) { extras, trigger in
            switch trigger {
            case .ext(let value):
                let new = transit(value, extras.machineId, extras.logger)
                return OutlineTransition(
                    new.state.asExtTriggerExtEffect(),
                    effects: new.effects.map { .ext($0) }
                )
            case .int:
                return OutlineTransition(asExtTriggerExtEffect())
            }
        }
    }

    func asIntEffectExtTrigger<IntTrigger, ExtEffect>() -> Outline<Payload, IntTrigger, Effect, Trigger, ExtEffect, Loggable> {
        Outline(payload: payload) { extras, trigger in
            switch trigger {
            case .ext(let value):
                let new = transit(value, extras.machineId, extras.logger)
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
    }

    func asIntTriggerExtEffect<IntEffect, ExtTrigger>() -> Outline<Payload, Trigger, IntEffect, ExtTrigger, Effect, Loggable> {
        Outline(payload: payload) { extras, trigger in
            switch trigger {
            case .ext:
                return OutlineTransition(asIntTriggerExtEffect())
            case .int(let value):
                let new = transit(value, extras.machineId, extras.logger)
                return OutlineTransition(
                    new.state.asIntTriggerExtEffect(),
                    effects: new.effects.map {
                        .ext($0)
                    }
                )
            }
        }
    }

    func asIntTriggerIntEffect<ExtTrigger, ExtEffect>() -> Outline<Payload, Trigger, Effect, ExtTrigger, ExtEffect, Loggable> {
        Outline(payload: payload) { extras, trigger in
            switch trigger {
            case .ext:
                return OutlineTransition(asIntTriggerIntEffect())
            case .int(let value):
                let new = transit(value, extras.machineId, extras.logger)
                return OutlineTransition(
                    new.state.asIntTriggerIntEffect(),
                    effects: new.effects.map {
                        .int($0)
                    }
                )
            }
        }
    }


    func asIntEffectExtTriggerExtEffect<IntTrigger>() -> Outline<Payload, IntTrigger, Effect, Trigger, Effect, Loggable> {
        Outline(payload: payload) { extras, trigger in
            switch trigger {
            case .ext(let value):
                let new = transit(value, extras.machineId, extras.logger)
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
    }

    func asIntTriggerIntEffectExtEffect<ExtTrigger>() -> Outline<Payload, Trigger, Effect, ExtTrigger, Effect, Loggable> {
        Outline(payload: payload) { extras, trigger in
            switch trigger {
            case .ext:
                return OutlineTransition(asIntTriggerIntEffectExtEffect())
            case .int(let value):
                let new = transit(value, extras.machineId, extras.logger)
                return OutlineTransition(
                    new.state.asIntTriggerIntEffectExtEffect(),
                    effects: new.effects.flatMap {
                        [.int($0), .ext($0)]
                    }
                )
            }
        }
    }

    func asIntTriggerIntEffectExtTrigger<ExtEffect>() -> Outline<Payload, Trigger, Effect, Trigger, ExtEffect, Loggable> {
        Outline(payload: payload) { extras, trigger in
            switch trigger {
            case .ext(let value),
                 .int(let value):
                let new = transit(value, extras.machineId, extras.logger)
                return OutlineTransition(
                    new.state.asIntTriggerIntEffectExtTrigger(),
                    effects: new.effects.map {
                        .int($0)
                    }
                )
            }
        }
    }

    func asIntTriggerExtTriggerExtEffect<IntEffect>() -> Outline<Payload, Trigger, IntEffect, Trigger, Effect, Loggable> {
        Outline(payload: payload) { extras, trigger in
            switch trigger {
            case .ext(let value),
                 .int(let value):
                let new = transit(value, extras.machineId, extras.logger)
                return OutlineTransition(
                    new.state.asIntTriggerExtTriggerExtEffect(),
                    effects: new.effects.map {
                        .ext($0)
                    }
                )
            }
        }
    }

    func asIntTriggerIntEffectExtTriggerExtEffect() -> Outline<Payload, Trigger, Effect, Trigger, Effect, Loggable>  {
        Outline(payload: payload) { extras, trigger in
            switch trigger {
            case .ext(let value),
                 .int(let value):
                let new = transit(value, extras.machineId, extras.logger)
                return OutlineTransition(
                    new.state.asIntTriggerIntEffectExtTriggerExtEffect(),
                    effects: new.effects.flatMap {
                        [.int($0), .ext($0)]
                    }
                )
            }
        }
    }
}
