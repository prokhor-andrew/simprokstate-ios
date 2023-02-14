//
// Created by Andriy Prokhorenko on 14.02.2023.
//

import simprokmachine

public extension Story {

    init(transit: @escaping Mapper<Event, Story<Event>?>) {
        self.init("") { _, event in
            transit(event)
        }
    }
}