//
// Created by Andriy Prokhorenko on 17.02.2023.
//

public extension Scene {

    func asExtTriggerExtEffect<IntTrigger, IntEffect>() -> Feature<IntTrigger, IntEffect, Trigger, Effect> {
        asExtTriggerExtEffect().asFeature(SetOfMachines())
    }

    func asIntEffectExtTrigger<ExtEffect, Machines: FeatureMachines>(
            _ machines: Machines
    ) -> Feature<Machines.Trigger, Effect, Trigger, ExtEffect> where Machines.Effect == Effect {
        asIntEffectExtTrigger().asFeature(machines)
    }

    func asIntTriggerExtEffect<ExtTrigger, Machines: FeatureMachines>(
            _ machines: Machines
    ) -> Feature<Trigger, Machines.Effect, ExtTrigger, Effect> where Machines.Trigger == Trigger {
        asIntTriggerExtEffect().asFeature(machines)
    }

    func asIntTriggerIntEffect<ExtTrigger, ExtEffect, Machines: FeatureMachines>(
            _ machines: Machines
    ) -> Feature<Trigger, Effect, ExtTrigger, ExtEffect> where Machines.Trigger == Trigger, Machines.Effect == Effect {
        asIntTriggerIntEffect().asFeature(machines)
    }

    func asIntEffectExtTriggerExtEffect<Machines: FeatureMachines>(
            _ machines: Machines
    ) -> Feature<Machines.Trigger, Effect, Trigger, Effect> where Machines.Effect == Effect {
        asIntEffectExtTriggerExtEffect().asFeature(machines)
    }

    func asIntTriggerIntEffectExtEffect<ExtTrigger, Machines: FeatureMachines>(
            _ machines: Machines
    ) -> Feature<Trigger, Effect, ExtTrigger, Effect> where Machines.Trigger == Trigger, Machines.Effect == Effect {
        asIntTriggerIntEffectExtEffect().asFeature(machines)
    }

    func asIntTriggerIntEffectExtTrigger<ExtEffect, Machines: FeatureMachines>(
            _ machines: Machines
    ) -> Feature<Trigger, Effect, Trigger, ExtEffect> where Machines.Trigger == Trigger, Machines.Effect == Effect {
        asIntTriggerIntEffectExtTrigger().asFeature(machines)
    }

    func asIntTriggerExtTriggerExtEffect<Machines: FeatureMachines>(
            _ machines: Machines
    ) -> Feature<Trigger, Machines.Effect, Trigger, Effect> where Machines.Trigger == Trigger, Machines.Effect == Effect {
        asIntTriggerExtTriggerExtEffect().asFeature(machines)
    }

    func asIntTriggerIntEffectExtTriggerExtEffect<Machines: FeatureMachines>(
            _ machines: Machines
    ) -> Feature<Trigger, Effect, Trigger, Effect> where Machines.Trigger == Trigger, Machines.Effect == Effect {
        asIntTriggerIntEffectExtTriggerExtEffect().asFeature(machines)
    }
}
