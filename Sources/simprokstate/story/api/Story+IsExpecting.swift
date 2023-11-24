//
// Created by Andriy Prokhorenko on 17.02.2023.
//

public extension Story {


    func isExpecting(event: Event) -> Bool {
        transit(event) != nil
    }

    func isExpecting(any events: [Event]) -> Bool {
        for event in events {
            if transit(event) != nil {
                return true
            }
        }
        return false
    }

    func isExpecting(any events: Event...) -> Bool {
        isExpecting(any: events)
    }

    func isExpecting(all events: [Event]) -> Bool {
        if events.isEmpty {
            return false
        }
        
        for event in events {
            if transit(event) == nil {
                return false
            }
        }
        return true
    }

    func isExpecting(all events: Event...) -> Bool {
        isExpecting(all: events)
    }
}
