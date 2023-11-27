//
// Created by Andriy Prokhorenko on 17.02.2023.
//

public extension Scene {

    func asExtTriggerExtEffect<IntTrigger, IntEffect>() -> Feature<IntTrigger, IntEffect, Trigger, Effect, Message> {
        asExtTriggerExtEffect().asFeature(SetOfMachines())
    }

    func asIntEffectExtTrigger<ExtEffect, Machines: FeatureMachines>(
        _ machines: Machines
    ) -> Feature<Machines.Trigger, Effect, Trigger, ExtEffect, Message> where Machines.Effect == Effect, Machines.Message == Message {
        asIntEffectExtTrigger().asFeature(machines)
    }

    func asIntTriggerExtEffect<ExtTrigger, Machines: FeatureMachines>(
        _ machines: Machines
    ) -> Feature<Trigger, Machines.Effect, ExtTrigger, Effect, Message> where Machines.Trigger == Trigger, Machines.Message == Message {
        asIntTriggerExtEffect().asFeature(machines)
    }

    func asIntTriggerIntEffect<ExtTrigger, ExtEffect, Machines: FeatureMachines>(
        _ machines: Machines
    ) -> Feature<Trigger, Effect, ExtTrigger, ExtEffect, Message> where Machines.Trigger == Trigger, Machines.Effect == Effect, Machines.Message == Message {
        asIntTriggerIntEffect().asFeature(machines)
    }

    func asIntEffectExtTriggerExtEffect<Machines: FeatureMachines>(
        _ machines: Machines
    ) -> Feature<Machines.Trigger, Effect, Trigger, Effect, Message> where Machines.Effect == Effect, Machines.Message == Message {
        asIntEffectExtTriggerExtEffect().asFeature(machines)
    }

    func asIntTriggerIntEffectExtEffect<ExtTrigger, Machines: FeatureMachines>(
        _ machines: Machines
    ) -> Feature<Trigger, Effect, ExtTrigger, Effect, Message> where Machines.Trigger == Trigger, Machines.Effect == Effect, Machines.Message == Message {
        asIntTriggerIntEffectExtEffect().asFeature(machines)
    }

    func asIntTriggerIntEffectExtTrigger<ExtEffect, Machines: FeatureMachines>(
        _ machines: Machines
    ) -> Feature<Trigger, Effect, Trigger, ExtEffect, Message> where Machines.Trigger == Trigger, Machines.Effect == Effect, Machines.Message == Message {
        asIntTriggerIntEffectExtTrigger().asFeature(machines)
    }

    func asIntTriggerExtTriggerExtEffect<Machines: FeatureMachines>(
        _ machines: Machines
    ) -> Feature<Trigger, Machines.Effect, Trigger, Effect, Message> where Machines.Trigger == Trigger, Machines.Effect == Effect, Machines.Message == Message {
        asIntTriggerExtTriggerExtEffect().asFeature(machines)
    }

    func asIntTriggerIntEffectExtTriggerExtEffect<Machines: FeatureMachines>(
        _ machines: Machines
    ) -> Feature<Trigger, Effect, Trigger, Effect, Message> where Machines.Trigger == Trigger, Machines.Effect == Effect, Machines.Message == Message {
        asIntTriggerIntEffectExtTriggerExtEffect().asFeature(machines)
    }
}
