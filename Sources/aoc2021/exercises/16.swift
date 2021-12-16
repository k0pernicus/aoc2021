//
//  16.swift
//
//
//  Created by Antonin on 16/12/2021.
//

import Foundation
import XCTest

let TransmissionMapper: [Character: String] = [
    "0": "0000",
    "1": "0001",
    "2": "0010",
    "3": "0011",
    "4": "0100",
    "5": "0101",
    "6": "0110",
    "7": "0111",
    "8": "1000",
    "9": "1001",
    "A": "1010",
    "B": "1011",
    "C": "1100",
    "D": "1101",
    "E": "1110",
    "F": "1111",
]

/// Wraps the information into two different forms:
/// * Packets with type ID 4 represent a literal value. Literal value packets encode a single binary number.
/// * Every other type of packet (any packet with a type ID other than 4) represent an operator that performs some calculation on one or more sub-packets contained within.
enum Packet {
    case Literal(version: Int, value: Int)
    case Operator(version: Int, typeID: Int, packets: [Packet])
    
    /// Returns the version of the current Packet - used for Part 1
    func getVersion() -> Int {
        switch self {
        case .Literal(let version, _): return version
        case .Operator(let version, _, let packets):
            return version + packets.reduce(into: 0, { acc, packet in acc += packet.getVersion() })
        }
    }
    
    /// Returns the value of the current Packet - used for Part 2
    func getValue() -> Int {
        switch self {
        case .Literal(_, let value): return value
        case .Operator(_, let typeID, let packets):
            switch typeID {
            case 0: return packets.reduce(into: 0, { acc, packet in acc += packet.getValue() })
            case 1: return packets.reduce(into: 1, { acc, packet in acc *= packet.getValue() })
            case 2: return packets[1...].reduce(into: packets[0].getValue(), { acc, packet in acc = min(acc, packet.getValue()) })
            case 3: return packets[1...].reduce(into: packets[0].getValue(), { acc, packet in acc = max(acc, packet.getValue()) })
            case 5: return packets[0].getValue() > packets[1].getValue() ? 1 : 0 // Let it fail if the length is not correct
            case 6: return packets[0].getValue() < packets[1].getValue() ? 1 : 0 // Let it fail if the length is not correct
            case 7: return packets[0].getValue() == packets[1].getValue() ? 1 : 0 // Let it fail if the length is not correct
            default: fatalError("got typeID \(typeID), which does not exist!")
            }
        }
    }
}

/// Returns the value of the literal packet (taken as parameter), and the remaining packet string  / transmission, which
/// was not used to create the Literal packet
private func parseLiteral(rawLiteral packet: String) -> (Int?, String) {
    var remainingPacket = packet
    var groups: String = ""
    while true {
        var group = remainingPacket.take(5)
        let finishBit = group.take(1)
        groups.append(String(group))
        if finishBit == "0" {
            break
        }
    }
    return (Int(groups, radix: 2), remainingPacket)
}

/// Returns an array of packets, and the remaining packet string  / transmission, which
/// was not used to create the Operator packet
private func parseOperator(rawOperator packet: String) -> ([Packet], String) {
    var remainingPacket = packet
    let lengthTypeID = remainingPacket.take(1)
    var packets: [Packet] = []
    switch lengthTypeID {
    case "0":
        let lengthSubPackets = remainingPacket.take(15)
        var remainingBits = remainingPacket.take(Int(lengthSubPackets, radix: 2)!)
        while remainingBits.count > 0 {
            let (packet, rem) = process(rawPacket: remainingBits)
            if (packet == nil) {
                fatalError("packet is nil")
            }
            remainingBits = rem
            packets.append(packet!)
        }
    case "1":
        let nbPackets = Int(remainingPacket.take(11), radix: 2)!
        while packets.count < nbPackets {
            let (packet, rem) = process(rawPacket: remainingPacket)
            if (packet == nil) {
                fatalError("packet is nil")
            }
            remainingPacket = rem
            packets.append(packet!)
        }
    default: fatalError("length type ID \(lengthTypeID) incorrect")
    }
    return (packets, remainingPacket)
}

/// Returns a packet (if the `rawPacket` parameter is valid) or `nil`, and the remaining
/// raw packet (value not taken) that was not necessary / used to format the returned packet
private func process(rawPacket: String) -> (Packet?, String) {
    var rawPacket = rawPacket
    if rawPacket.count < 6 {
        return (nil, "")
    }
    guard let version = Int(rawPacket.take(3), radix: 2) else {
        return (nil, "")
    }
    guard let typeID = Int(rawPacket.take(3), radix: 2) else {
        return (nil, "")
    }
    // typeID 4 represents a LITERAL value *ONLY*
    if typeID == 4 {
        let (value, remainingPacket) = parseLiteral(rawLiteral: rawPacket)
        if value == nil {
            return (nil, rawPacket)
        }
        return (Packet.Literal(version: version, value: value!), remainingPacket)
    }
    let (packets, remainingPacket) = parseOperator(rawOperator: rawPacket)
    return (Packet.Operator(version: version, typeID: typeID, packets: packets), remainingPacket)
}

struct Transmission {
    var message: String
    
    init?(data: String) {
        self.message = Array(data).map({ character in TransmissionMapper[character]! }).joined(separator: "")
    }
    
    /// Returns all the well formated packets
    mutating func process() -> [Packet] {
        var packets: [Packet] = []
        while self.message.count > 0 {
            // Remove the padding
            if self.message.allSatisfy({ character in character == "0"}) {
                break
            }
            let (newPacket, remainingHex) = aoc2021.process(rawPacket: self.message)
            if newPacket == nil {
                fatalError("The message \(self.message) did not format a correct packet")
            }
            packets.append(newPacket!)
            self.message = remainingHex
        }
        return packets
    }
}

class Ex16: Exercise {
    var name: String = "16"
   
    typealias InputPart1 = String
    typealias InputPart2 = String
    typealias OutputPart1 = Int
    typealias OutputPart2 = Int
    
    private init() {
        let result = Exercises.shared.register(self.name)
        if result == .alreadyExists {
            fatalError("exercise with name \(self.name) already exists - cannot register...")
        }
    }
    
    internal func part1(from: String) -> Result<Int> {
        do {
            let data: Result<[String]> = try getInput(from: from)
            switch data {
            case .ok(let data):
                return self.part1(value: data[0])
            case .error(let err):
                return .error(err)
            }
        }
        catch {
            return .error("\(error)")
        }
    }
    
    internal func part2(from: String) -> Result<Int> {
        do {
            let data: Result<[String]> = try getInput(from: from)
            switch data {
            case .ok(let data):
                return self.part2(value: data[0])
            case .error(let err):
                return .error(err)
            }
        }
        catch {
            return .error("\(error)")
        }
    }
    
    internal func part1(value data: String) -> Result<Int> {
        guard var transmission: Transmission = Transmission(data: data) else {
            return .error("the transmission is not ok")
        }
        let packets = transmission.process()
        let versionSum: Int = packets.reduce(into: 0, { acc, packet in acc += packet.getVersion() })
        return .ok(versionSum)
    }
    
    internal func part2(value data: String) -> Result<Int> {
        guard var transmission: Transmission = Transmission(data: data) else {
            return .error("the transmission is not ok")
        }
        let packets = transmission.process()
        let versionSum: Int = packets.reduce(into: 0, { acc, packet in acc += packet.getValue() })
        return .ok(versionSum)
    }
    
    public static let shared = Ex16()
}
