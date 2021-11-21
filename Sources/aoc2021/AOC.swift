import ArgumentParser
import Darwin

enum AppResult {
    case ok
    case err(String)
}

@main
struct App: ParsableCommand {
    @Argument(help: "The exercise to run.")
    var exercise: String?
    
    @Flag(help: "Prints the list of available exercises.")
    var printExercises = false
    
    @Option(name: [.customShort("i"), .long], help: "Path of the input file")
    var inputFile: String?
   
    static func checkIfExerciseExists(exercise registered: String) -> Bool {
        return Exercises.shared.isRegistered(registered)
    }
    
    mutating func run() throws {
        // Such a shame that compile time arbitrary code
        // is not a priority in Swift... :/
        _ = Ex01.shared
        
        if (printExercises) {
            let availableExercises = Exercises.shared.registered();
            print("Available exercises:")
            for exercise in availableExercises {
                print("* \(exercise)")
            }
            return
        }
        
        if !(App.checkIfExerciseExists(exercise: exercise!)) {
            print("The exercise does not exists")
            return
        }
        
        func getInputFile(exerciseName: String, inputFile: String?) -> String {
            return inputFile ?? "Inputs/\(exerciseName).txt"
        }
        
        let file = getInputFile(exerciseName: exercise!, inputFile: inputFile)
        
        switch exercise {
            // TODO: Find a solution in order to register the name of the exercise *and* the exercise itself
        case "01":
            print("Solution of part1: \(Ex01.shared.part1(from: file))")
            print("Solution of part2: \(Ex01.shared.part2(from: file))")
        default:
            print("Exercise not found, should not happen")
        }
        
        return
    }
}
