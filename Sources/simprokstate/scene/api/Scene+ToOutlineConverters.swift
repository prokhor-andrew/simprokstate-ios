//
// Created by Andriy Prokhorenko on 19.02.2023.
//


public extension Scene {

    func asExtTriggerExtEffect<IntTrigger, IntEffect>() -> Outline<IntTrigger, IntEffect, Trigger, Effect> {
        Outline { event in
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
    }

    func asIntEffectExtTrigger<IntTrigger, ExtEffect>() -> Outline<IntTrigger, Effect, Trigger, ExtEffect> {
        Outline { event in
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
    }

    func asIntTriggerExtEffect<IntEffect, ExtTrigger>() -> Outline<Trigger, IntEffect, ExtTrigger, Effect> {
        Outline { event in
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
    }

    func asIntTriggerIntEffect<ExtTrigger, ExtEffect>() -> Outline<Trigger, Effect, ExtTrigger, ExtEffect> {
        Outline { event in
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
    }


    func asIntEffectExtTriggerExtEffect<IntTrigger>() -> Outline<IntTrigger, Effect, Trigger, Effect> {
        Outline { event in
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
    }

    func asIntTriggerIntEffectExtEffect<ExtTrigger>() -> Outline<Trigger, Effect, ExtTrigger, Effect> {
        Outline { event in
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
    }

    func asIntTriggerIntEffectExtTrigger<ExtEffect>() -> Outline<Trigger, Effect, Trigger, ExtEffect> {
        Outline { event in
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
    }

    func asIntTriggerExtTriggerExtEffect<IntEffect>() -> Outline<Trigger, IntEffect, Trigger, Effect> {
        Outline { event in
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
    }

    func asIntTriggerIntEffectExtTriggerExtEffect() -> Outline<Trigger, Effect, Trigger, Effect>  {
        Outline { event in
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
    }
}
