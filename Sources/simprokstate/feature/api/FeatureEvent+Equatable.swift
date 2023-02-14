//
// Created by Andriy Prokhorenko on 14.02.2023.
//

extension FeatureEvent: Equatable where Internal: Equatable, External: Equatable {
    public static func ==(lhs: FeatureEvent<Internal, External>, rhs: FeatureEvent<Internal, External>) -> Bool {
        switch (lhs, rhs) {
        case (.int(let val1), .int(let val2)):
            return val1 == val2
        case (.ext(let val1), .ext(let val2)):
            return val1 == val2
        default:
            return false
        }
    }
}
