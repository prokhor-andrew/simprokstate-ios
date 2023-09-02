//
//  File.swift
//  
//
//  Created by Andriy Prokhorenko on 29.08.2023.
//



public protocol AnyStoryEvent {
    
}


public extension Story where Event: AnyStoryEvent {
    
    func erase() -> Story<AnyStoryEvent> {
        if let transit {
            return Story<AnyStoryEvent>.create { event in
                if let casted = event as? Event {
                    return transit(casted)?.erase()
                } else {
                    return nil
                }
            }
        } else {
            return .finale()
        }
    }
}

prefix operator ^

public prefix func ^<Event: AnyStoryEvent>(
    story: Story<Event>
) -> Story<AnyStoryEvent> {
    story.erase()
}
