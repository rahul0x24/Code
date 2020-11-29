//
//  Extension+NSTextView.swift
//  Code
//
//  Created by Joshua Rutkowski on 11/29/20.
//

import Cocoa

extension NSTextView {
    var selectedText: String {
        string[selectedRange()]
    }
}

extension String {
    subscript (_ range: NSRange) -> Self {
        .init(self[index(startIndex, offsetBy: range.lowerBound) ..< index(startIndex, offsetBy: range.upperBound)])
    }
}
