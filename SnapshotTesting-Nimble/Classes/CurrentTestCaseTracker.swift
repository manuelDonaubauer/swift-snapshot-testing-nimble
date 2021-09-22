//
//  CurrentTestCaseTracker.swift
//  GrailedTests
//
//  Created by DJ Mitchell on 11/28/18.
//  Copyright © 2018 Grailed. All rights reserved.
//

import Foundation
import XCTest

@objc public final class CurrentCaseTracker: NSObject, XCTestObservation {
    public override init() {
        super.init()
        
        XCTestObservationCenter.shared.addTestObserver(self)
    }
    
    @objc public static let shared = CurrentCaseTracker()

    public private(set) var currentTestCase: XCTestCase?

    @objc public func testCaseWillStart(_ testCase: XCTestCase) {
        currentTestCase = testCase
    }

    @objc public func testCaseDidFinish(_ testCase: XCTestCase) {
        currentTestCase = nil
    }

    internal static func sanitize(_ fullName: String) -> String {
        let characterSet = CharacterSet(charactersIn: "[]+-")
        #if swift(>=4)
        let name = fullName.components(separatedBy: characterSet).joined()
        #else
        let name = (fullName ?? "").components(separatedBy: characterSet).joined()
        #endif

        if let quickClass = NSClassFromString("QuickSpec"), self.isKind(of: quickClass) {
            let className = String(describing: type(of: self))
            if let range = name.range(of: className), range.lowerBound == name.startIndex {
                return name.replacingCharacters(in: range, with: "")
                    .trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }

        return name
    }
}

extension XCTestCase {
    internal var sanitizedName: String? {
        return CurrentCaseTracker.sanitize(self.name)
    }
}
