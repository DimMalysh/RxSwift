import Foundation

public func example(_ rxOperator: String, action: () -> ()) {
    print("\n--- Exampe of:", rxOperator, "---")
    action()
}
