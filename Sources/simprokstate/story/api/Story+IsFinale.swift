//
// Created by Andriy Prokhorenko on 17.02.2023.
//


public extension Story {


    var isFinale: Bool {
        transit == nil
    }
}