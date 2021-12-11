//
//  Types.swift
//  
//
//  Created by Antonin on 11/12/2021.
//

/// Returned from Exercise to describe a process result
enum Result<T: Equatable>: Equatable {
    /// Process has been fine, and return the value
    case ok(T)
    /// Process resulted in an error, return it as a String
    // TODO: Replace the String type to another generic one?
    case error(String)
    
    func unwrap(prefix: String = "") {
        switch self {
        case .ok(let result): print("\(prefix)solution is \(result)")
        case .error(let error): print("\(prefix)error: \(error)")
        }
    }
}
