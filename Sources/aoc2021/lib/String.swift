//
//  String.swift
//  
//
//  Created by Antonin on 11/12/2021.
//

/// Extends String  with usefull methods for the project
extension String {
    /// Returns the character at index `i`, as a string
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    /// Returns a range of characters based on `r`, the Range type passed as parameter
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(count, r.lowerBound)),
                                            upper: min(count, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    /// Returns the substring of `Self` from `fromIndex` to the end of the string
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, count) ..< count]
    }
    /// Returns the substring of `Self` from `0` to `toIndex`
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
}
