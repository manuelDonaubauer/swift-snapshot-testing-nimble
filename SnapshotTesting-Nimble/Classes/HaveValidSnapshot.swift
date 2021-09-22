//
//  HaveValidSnapshot.swift
//  Pods
//
//  Created by DJ Mitchell on 11/30/18.
//

import Foundation
import Nimble
import SnapshotTesting

public func haveValidSnapshot<Value, Format>(
    as strategy: Snapshotting<Value, Format>,
    named name: String? = nil,
    record recording: Bool = false,
    timeout: TimeInterval = 5,
    file: StaticString = #file,
    testName: String? = nil,
    line: UInt = #line
    ) -> Predicate<Value> {
    let testName = testName
    ?? CurrentCaseTracker.shared.currentTestCase?.sanitizedName
    ?? CurrentCaseTracker.sanitize(#function)

    return Predicate { actualExpression in
        guard let value = try actualExpression.evaluate() else {
            return PredicateResult(status: .fail, message: .fail("have valid snapshot"))
        }

        guard let errorMessage = verifySnapshot(
            matching: value,
            as: strategy,
            named: name,
            record: recording,
            timeout: timeout,
            file: file,
            testName: testName,
            line: line
            ) else {
                return PredicateResult(bool: true, message: .fail("have valid snapshot"))
        }

        return PredicateResult(
            bool: false,
            message: .fail(errorMessage)
        )
    }
}
