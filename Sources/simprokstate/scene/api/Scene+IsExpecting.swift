//
// Created by Andriy Prokhorenko on 17.02.2023.
//


public extension Scene {

    func isExpecting(event: Trigger) -> Bool {
        if let transit {
            return transit(event) != nil
        } else {
            return false
        }
    }

    func isExpecting(any events: [Trigger]) -> Bool {
        if let transit {
            for event in events {
                if transit(event) != nil {
                    return true
                }
            }
            return false
        } else {
            return false
        }
    }

    func isExpecting(any events: Trigger...) -> Bool {
        isExpecting(any: events)
    }

    func isExpecting(all events: [Trigger]) -> Bool {
        if let transit {
            for event in events {
                if transit(event) == nil {
                    return false
                }
            }
            return true
        } else {
            return false
        }
    }

    func isExpecting(all events: Trigger...) -> Bool {
        isExpecting(all: events)
    }
}