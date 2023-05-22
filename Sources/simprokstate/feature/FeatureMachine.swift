//
// Created by Andriy Prokhorenko on 14.02.2023.
//

import Foundation
import simprokmachine

public extension Machine {

    convenience init<IntTrigger, IntEffect>(
            _ transition: FeatureTransition<IntTrigger, IntEffect, Input, Output>
    ) {
        self.init(FeatureHolder(transition), isProcessOnMain: false) { object, input, callback in
            object.process(input: input, callback: callback)
        }
    }


    private class FeatureHolder<IntTrigger, IntEffect, ExtTrigger, ExtEffect> {

        // MARK: TODO - fix dispatch naming
        private let queue = DispatchQueue(label: "")
        
        private func enqueue(event: FeatureEvent<IntTrigger, ExtTrigger>?, callback: @escaping Handler<ExtEffect>) {
            queue.async { [weak self] in
                if let event {
                    self?.handle(event: event, callback: callback)
                } else {
                    // initial
                    self?.config(callback: callback)
                }
            }
        }
        
        private var transition: FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>

        internal init(_ initial: FeatureTransition<IntTrigger, IntEffect, ExtTrigger, ExtEffect>) {
            transition = initial
        }

        internal func process(input: ExtTrigger?, callback: @escaping Handler<ExtEffect>) {
            if let input {
                enqueue(event: .ext(input), callback: callback)
            } else {
                enqueue(event: nil, callback: callback)
            }
        }

        private func handle(event: FeatureEvent<IntTrigger, ExtTrigger>, callback: @escaping Handler<ExtEffect>) {
            guard let transit = transition.state.transit else {
                // this is the finale
                return
            }
            guard let new = transit(event) else {
                return
            }
            
            
            // order matters as "transition" is used inside "config()"
            transition = new
            config(callback: callback)
        }

        private func config(callback: @escaping Handler<ExtEffect>) {
            // start machines that are not started
            for machine in transition.state.machines { 
                machine.start { [weak self] output, _ in
                    self?.enqueue(event: .int(output), callback: callback)
                }
            }

            // sending effects
            transition.effects.forEach { event in
                switch event {
                case .int(let output):
                    transition.state.machines.forEach {
                        $0.send(input: output)
                    }
                case .ext(let output):
                    callback(output)
                }
            }
        }
    }
}
