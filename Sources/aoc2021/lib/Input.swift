//
//  Input.swift
//  
//
//  Created by Antonin on 11/12/2021.
//

/// Returns an array of generic type `T` from a file determined by `from`
func getInput<T>(from: String, encodeTo: ((_ str: String) -> T)) throws -> Result<[T]> {
    do {
        let data = try String(contentsOfFile: from, encoding: .utf8)
        let lines = data.components(separatedBy: .newlines)
        return .ok(lines.map { encodeTo($0) })
    } catch {
        return .error("\(error)")
    }
}

/// Returns an array of String from a file determined by `from`
func getInput(from: String) throws -> Result<[String]> {
    do {
        let data = try String(contentsOfFile: from, encoding: .utf8)
        let lines = data.components(separatedBy: .newlines)
        return .ok(lines)
    } catch {
        return .error("\(error)")
    }
}

/// From String to Int
func toInt(s: String) -> Int? {
    return Int(s)
}

/// From String to Float
func toFloat(s: String) -> Float? {
    return Float(s)
}
