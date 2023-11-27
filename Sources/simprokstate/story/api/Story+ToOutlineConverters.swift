//
// Created by Andriy Prokhorenko on 14.02.2023.
//

public extension Story {

    func asExtTriggerExtEffect<IntTrigger, IntEffect>() -> Outline<IntTrigger, IntEffect, Event, Event, Message> {
        asScene().asExtTriggerExtEffect()
    }

    func asIntEffectExtTrigger<IntTrigger, ExtEffect>() -> Outline<IntTrigger, Event, Event, ExtEffect, Message> {
        asScene().asIntEffectExtTrigger()
    }

    func asIntTriggerExtEffect<IntEffect, ExtTrigger>() -> Outline<Event, IntEffect, ExtTrigger, Event, Message>  {
        asScene().asIntTriggerExtEffect()
    }

    func asIntTriggerIntEffect<ExtTrigger, ExtEffect>() -> Outline<Event, Event, ExtTrigger, ExtEffect, Message> {
        asScene().asIntTriggerIntEffect()
    }

    func asIntEffectExtTriggerExtEffect<IntTrigger>() -> Outline<IntTrigger, Event, Event, Event, Message> {
        asScene().asIntEffectExtTriggerExtEffect()
    }

    func asIntTriggerIntEffectExtEffect<ExtTrigger>() -> Outline<Event, Event, ExtTrigger, Event, Message> {
        asScene().asIntTriggerIntEffectExtEffect()
    }

    func asIntTriggerIntEffectExtTrigger<ExtEffect>() -> Outline<Event, Event, Event, ExtEffect, Message> {
        asScene().asIntTriggerIntEffectExtTrigger()
    }

    func asIntTriggerExtTriggerExtEffect<IntEffect>() -> Outline<Event, IntEffect, Event, Event, Message> {
        asScene().asIntTriggerExtTriggerExtEffect()
    }

    func asIntTriggerIntEffectExtTriggerExtEffect() -> Outline<Event, Event, Event, Event, Message> {
        asScene().asIntTriggerIntEffectExtTriggerExtEffect()
    }
}
