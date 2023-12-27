//
// Created by Andriy Prokhorenko on 14.02.2023.
//

import simprokmachine



public extension Machine {

    init<Payload, IntTrigger, IntEffect>(
        _ feature: @escaping @Sendable (String, MachineLogger) -> Feature<Payload, IntTrigger, IntEffect, Input, Output>
    ) {
        self.init { id, logger in
            FeatureHolder<Payload, IntTrigger, IntEffect, Input, Output>(
                id: id,
                initial: { feature(id, logger) },
                logger: logger
            )
        } onChange: { obj, callback in
            obj.onChange(callback)
        } onProcess: { obj, input in
            await obj.onProcess(input)
        }
    }


    private actor FeatureHolder<Payload, IntTrigger, IntEffect, ExtTrigger, ExtEffect> {
        
        private let id: String
        private let logger: MachineLogger
        
        private let initial: () -> Feature<Payload, IntTrigger, IntEffect, ExtTrigger, ExtEffect>
        
        private var callback: MachineCallback<ExtEffect>?
        
        private var processes: Set<Process<IntEffect>> = []
        private var transit: Optional<
            (
                FeatureEvent<IntTrigger, ExtTrigger>,
                String,
                MachineLogger
            ) -> FeatureTransition<Payload, IntTrigger, IntEffect, ExtTrigger, ExtEffect>
        > = nil
        
        internal init(
            id: String,
            initial: @escaping () -> Feature<Payload, IntTrigger, IntEffect, ExtTrigger, ExtEffect>,
            logger: MachineLogger
        ) {
            self.id = id
            self.initial = initial
            self.logger = logger
        }
        
        internal func onChange(_ callback: MachineCallback<ExtEffect>?) {
            self.callback = callback
            
            if callback != nil {
                let state = initial()
                transit = state.transit
                processes = Set(state.machines.map { $0.run(logger: logger) { await handle(.int($0)) } })
            } else {
                transit = nil
                processes.forEach { $0.cancel() }
                processes = []
            }
        }
        
        internal func onProcess(_ input: ExtTrigger) async {
            await handle(.ext(input))
        }
        
        private func handle(_ event: FeatureEvent<IntTrigger, ExtTrigger>) async {
            guard let _transit = transit else { return }
            
            let transition = _transit(event, id, logger)
            
            let resultingMachines = transition.state.machines
            
            let machinesToAdd = resultingMachines.filter { machine in
                !processes.contains(where: { process in
                    process.id == machine.id
                })
            }
            
            let processesToRemove = processes.filter { process in
                !resultingMachines.contains(where: { machine in
                    process.id == machine.id
                })
            }
            
            let processesToKeep = processes.filter { process in
                !machinesToAdd.contains(where: { machine in
                    machine.id == process.id
                })
                &&
                !processesToRemove.contains(where: { processToRemove in
                    process.id == processToRemove.id
                })
            }
            
            processesToRemove.forEach { $0.cancel() }
            let processesToAdd = machinesToAdd.map { machine in
                machine.run(logger: logger) { output in
                    await handle(.int(output))
                }
            }
            
            processes = Set(processesToKeep + processesToAdd)
            transit = transition.state.transit
            
            let effects = transition.effects
            
            await withTaskGroup(of: Void.self) { group in
                
                _ = group.addTaskUnlessCancelled {
                    for effect in effects {
                        switch effect {
                        case .ext(let effect):
                            // Using self here is totally safe
                            await self.callback?(effect)
                        case .int:
                            break
                        }
                    }
                }
                
                processesToKeep.forEach { process in
                    _ = group.addTaskUnlessCancelled {
                        for effect in effects {
                            switch effect {
                            case .int(let effect):
                                await process.send(effect)
                            case .ext:
                                break
                            }
                        }
                    }
                }
                
                await group.waitForAll()
            }
        }
    }
}
