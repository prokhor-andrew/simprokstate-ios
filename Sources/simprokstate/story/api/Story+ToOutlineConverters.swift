//
// Created by Andriy Prokhorenko on 14.02.2023.
//

public extension Story {

    func asExtTriggerExtEffect<IntTrigger, IntEffect>() -> Outline<Payload, IntTrigger, IntEffect, Event, Event> {
        asScene().asExtTriggerExtEffect()
    }

    func asIntEffectExtTrigger<IntTrigger, ExtEffect>() -> Outline<Payload, IntTrigger, Event, Event, ExtEffect> {
        asScene().asIntEffectExtTrigger()
    }

    func asIntTriggerExtEffect<IntEffect, ExtTrigger>() -> Outline<Payload, Event, IntEffect, ExtTrigger, Event>  {
        asScene().asIntTriggerExtEffect()
    }

    func asIntTriggerIntEffect<ExtTrigger, ExtEffect>() -> Outline<Payload, Event, Event, ExtTrigger, ExtEffect> {
        asScene().asIntTriggerIntEffect()
    }

    func asIntEffectExtTriggerExtEffect<IntTrigger>() -> Outline<Payload, IntTrigger, Event, Event, Event> {
        asScene().asIntEffectExtTriggerExtEffect()
    }

    func asIntTriggerIntEffectExtEffect<ExtTrigger>() -> Outline<Payload, Event, Event, ExtTrigger, Event> {
        asScene().asIntTriggerIntEffectExtEffect()
    }

    func asIntTriggerIntEffectExtTrigger<ExtEffect>() -> Outline<Payload, Event, Event, Event, ExtEffect> {
        asScene().asIntTriggerIntEffectExtTrigger()
    }

    func asIntTriggerExtTriggerExtEffect<IntEffect>() -> Outline<Payload, Event, IntEffect, Event, Event> {
        asScene().asIntTriggerExtTriggerExtEffect()
    }

    func asIntTriggerIntEffectExtTriggerExtEffect() -> Outline<Payload, Event, Event, Event, Event> {
        asScene().asIntTriggerIntEffectExtTriggerExtEffect()
    }
}
