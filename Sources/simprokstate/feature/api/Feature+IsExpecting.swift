//
// Created by Andriy Prokhorenko on 17.02.2023.
//

public extension Feature {

    func isExpecting(event: FeatureEvent<IntTrigger, ExtTrigger>) -> Bool {
        if let transit {
            return transit(event).state.id != id
        } else {
            return false
        }
    }

    func isExpecting(any events: [FeatureEvent<IntTrigger, ExtTrigger>]) -> Bool {
        if let transit {
            for event in events {
                if transit(event).state.id != id {
                    return true
                }
            }
            return false
        } else {
            return false
        }
    }

    func isExpecting(any events: FeatureEvent<IntTrigger, ExtTrigger>...) -> Bool {
        isExpecting(any: events)
    }

    func isExpecting(all events: [FeatureEvent<IntTrigger, ExtTrigger>]) -> Bool {
        if let transit {
            for event in events {
                if transit(event).state.id == id {
                    return false
                }
            }
            return true
        } else {
            return false
        }
    }

    func isExpecting(all events: FeatureEvent<IntTrigger, ExtTrigger>...) -> Bool {
        isExpecting(all: events)
    }
}