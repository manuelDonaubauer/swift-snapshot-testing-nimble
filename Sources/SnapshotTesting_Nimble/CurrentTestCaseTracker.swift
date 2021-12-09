//
//  CurrentTestCaseTracker.swift
//  GrailedTests
//
//  Created by DJ Mitchell on 11/28/18.
//  Copyright © 2018 Grailed. All rights reserved.
//

import Foundation
import XCTest

extension XCTestCase {
    public var sanitizedName: String? {
        let fullName = self.name
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
