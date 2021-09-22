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
    testName: String = #function,
    file: StaticString = #file,
    line: UInt = #line
) -> Predicate<Value> {
    let testName = sanitize(testName)

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

private func sanitize(_ fullName: String) -> String {
    let characterSet = CharacterSet(charactersIn: "[]+-")
    #if swift(>=4)
    let name = fullName.components(separatedBy: characterSet).joined()
    #else
    let name = (fullName ?? "").components(separatedBy: characterSet).joined()
    #endif

    return name
}
