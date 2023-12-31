//
// Created by Andriy Prokhorenko on 14.02.2023.
//

public extension Story {

    func asExtTriggerExtEffect<IntTrigger, IntEffect>() -> Outline<Payload, IntTrigger, IntEffect, Event, Event, Loggable> {
        asScene().asExtTriggerExtEffect()
    }

    func asIntEffectExtTrigger<IntTrigger, ExtEffect>() -> Outline<Payload, IntTrigger, Event, Event, ExtEffect, Loggable> {
        asScene().asIntEffectExtTrigger()
    }

    func asIntTriggerExtEffect<IntEffect, ExtTrigger>() -> Outline<Payload, Event, IntEffect, ExtTrigger, Event, Loggable>  {
        asScene().asIntTriggerExtEffect()
    }

    func asIntTriggerIntEffect<ExtTrigger, ExtEffect>() -> Outline<Payload, Event, Event, ExtTrigger, ExtEffect, Loggable> {
        asScene().asIntTriggerIntEffect()
    }

    func asIntEffectExtTriggerExtEffect<IntTrigger>() -> Outline<Payload, IntTrigger, Event, Event, Event, Loggable> {
        asScene().asIntEffectExtTriggerExtEffect()
    }

    func asIntTriggerIntEffectExtEffect<ExtTrigger>() -> Outline<Payload, Event, Event, ExtTrigger, Event, Loggable> {
        asScene().asIntTriggerIntEffectExtEffect()
    }

    func asIntTriggerIntEffectExtTrigger<ExtEffect>() -> Outline<Payload, Event, Event, Event, ExtEffect, Loggable> {
        asScene().asIntTriggerIntEffectExtTrigger()
    }

    func asIntTriggerExtTriggerExtEffect<IntEffect>() -> Outline<Payload, Event, IntEffect, Event, Event, Loggable> {
        asScene().asIntTriggerExtTriggerExtEffect()
    }

    func asIntTriggerIntEffectExtTriggerExtEffect() -> Outline<Payload, Event, Event, Event, Event, Loggable> {
        asScene().asIntTriggerIntEffectExtTriggerExtEffect()
    }
}
