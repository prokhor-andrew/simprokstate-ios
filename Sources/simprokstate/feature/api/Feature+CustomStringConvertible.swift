//
// Created by Andriy Prokhorenko on 14.02.2023.
//


extension Feature: CustomStringConvertible {

    public var description: String {
        "Feature machines [" + machines.description + "]"
    }
}