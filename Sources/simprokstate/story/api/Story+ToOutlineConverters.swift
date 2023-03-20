//
// Created by Andriy Prokhorenko on 14.02.2023.
//

public extension Story {

    func asExtTriggerExtEffect<IntTrigger, IntEffect>() -> Outline<IntTrigger, IntEffect, Event, Event> {
        asScene().asExtTriggerExtEffect()
    }

    func asIntEffectExtTrigger<IntTrigger, ExtEffect>() -> Outline<IntTrigger, Event, Event, ExtEffect> {
        asScene().asIntEffectExtTrigger()
    }

    func asIntTriggerExtEffect<IntEffect, ExtTrigger>() -> Outline<Event, IntEffect, ExtTrigger, Event>  {
        asScene().asIntTriggerExtEffect()
    }

    func asIntTriggerIntEffect<ExtTrigger, ExtEffect>() -> Outline<Event, Event, ExtTrigger, ExtEffect> {
        asScene().asIntTriggerIntEffect()
    }

    func asIntEffectExtTriggerExtEffect<IntTrigger>() -> Outline<IntTrigger, Event, Event, Event> {
        asScene().asIntEffectExtTriggerExtEffect()
    }

    func asIntTriggerIntEffectExtEffect<ExtTrigger>() -> Outline<Event, Event, ExtTrigger, Event> {
        asScene().asIntTriggerIntEffectExtEffect()
    }

    func asIntTriggerIntEffectExtTrigger<ExtEffect>() -> Outline<Event, Event, Event, ExtEffect> {
        asScene().asIntTriggerIntEffectExtTrigger()
    }

    func asIntTriggerExtTriggerExtEffect<IntEffect>() -> Outline<Event, IntEffect, Event, Event> {
        asScene().asIntTriggerExtTriggerExtEffect()
    }

    func asIntTriggerIntEffectExtTriggerExtEffect() -> Outline<Event, Event, Event, Event> {
        asScene().asIntTriggerIntEffectExtTriggerExtEffect()
    }
}
