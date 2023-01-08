//
//  ScenarioMachine.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine


public protocol ScenarioMachine: ParentMachine {
    associatedtype S: Scenario
    
    var scenario: S { get }
}


public extension ScenarioMachine {
    
    var child: some Machine {
        ScenarioAutomaton(scenario)
    }
}
