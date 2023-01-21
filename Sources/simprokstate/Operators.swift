//
//  Operators.swift
//  simprokstate
//
//  Created by Andrey Prokhorenko on 01.12.2021.
//  Copyright (c) 2022 simprok. All rights reserved.

import simprokmachine

infix operator + : AssignmentPrecedence

public func + <IntTrigger, IntEffect, ExtTrigger, ExtEffect>(
    lhs: Machines<IntEffect, IntTrigger>,
    rhs: FeatureObject<IntTrigger, IntEffect, ExtTrigger, ExtEffect>
) -> FeatureObject<IntTrigger, IntEffect, ExtTrigger, ExtEffect> {
    let array = lhs.array.filter { i in
        rhs.machines.array.contains(where: { j in
            i.isChildEqual(to: j)
        })
    } + rhs.machines.array
    
    
    return FeatureObject(machines: Machines(array)) { _, event in
        rhs.transit(trigger: event)
    }
}


infix operator - : AssignmentPrecedence

public func - <IntTrigger, IntEffect, ExtTrigger, ExtEffect>(
    lhs: Machines<IntEffect, IntTrigger>,
    rhs: FeatureObject<IntTrigger, IntEffect, ExtTrigger, ExtEffect>
) -> FeatureObject<IntTrigger, IntEffect, ExtTrigger, ExtEffect> {
    let array = rhs.machines.array.filter { i in
        lhs.array.contains(where: { j in
            i.isChildEqual(to: j)
        })
    }
    
    return FeatureObject(machines: Machines(array)) { _, event in
        rhs.transit(trigger: event)
    }
}

infix operator ^ : AssignmentPrecedence


public func ^ <IntTrigger, IntEffect, ExtTrigger, ExtEffect>(
    lhs: Machines<IntEffect, IntTrigger>,
    rhs: FeatureObject<IntTrigger, IntEffect, ExtTrigger, ExtEffect>
) -> FeatureObject<IntTrigger, IntEffect, ExtTrigger, ExtEffect> {
    FeatureObject(machines: lhs) { _, event in
        rhs.transit(trigger: event)
    }
}
