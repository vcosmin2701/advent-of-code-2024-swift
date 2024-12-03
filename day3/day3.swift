import Foundation

func parseInput1(filePath: String) -> Double {
    do {
        let fileURL = URL(fileURLWithPath: filePath)
        let fileContents = try String(contentsOf: fileURL, encoding: .utf8)

        let regexPattern = "mul\\((\\d+(\\.\\d+)?),(\\d+(\\.\\d+)?)\\)"

        let regex = try NSRegularExpression(pattern: regexPattern)

        var totalSum: Double = 0

        let lines = fileContents.split(separator: "\n")

        for line in lines {
            let lineStr = String(line)

            let range = NSRange(location: 0, length: lineStr.utf16.count)
            let matches = regex.matches(in: lineStr, options: [], range: range)

            for match in matches {
                if let matchRange = Range(match.range, in: lineStr) {
                    let matchedSubstring = String(lineStr[matchRange])

                    if let number1Range = Range(match.range(at: 1), in: lineStr),
                       let number2Range = Range(match.range(at: 3), in: lineStr) {
                        let number1String = String(lineStr[number1Range])
                        let number2String = String(lineStr[number2Range])

                        if let number1 = Double(number1String), let number2 = Double(number2String) {
                            totalSum += number1 * number2
                        }
                    }
                }
            }
        }

        return totalSum

    } catch {
        fatalError("Failed to read file: \(error)")
    }
}

func processInput(filePath: String) -> Int {
    do {
        let fileURL = URL(fileURLWithPath: filePath)
        let data = try String(contentsOf: fileURL, encoding: .utf8)

        let pattern = #"(?:mul\((\d{1,3}),(\d{1,3})\))|(do\(\)|don't\(\))"#
        let regex = try NSRegularExpression(pattern: pattern)

        var currentState = true
        var total = 0

        let range = NSRange(location: 0, length: data.utf16.count)
        let matches = regex.matches(in: data, options: [], range: range)

        for match in matches {
            if let stateChangeRange = Range(match.range(at: 3), in: data) {
                let stateChange = String(data[stateChangeRange])
                switch stateChange {
                case "do()":
                    currentState = true
                case "don't()":
                    currentState = false
                default:
                    break
                }
            } else if let leftRange = Range(match.range(at: 1), in: data),
                      let rightRange = Range(match.range(at: 2), in: data),
                      currentState {
                
                if let left = Int(data[leftRange]), let right = Int(data[rightRange]) {
                    total += left * right
                }
            }
        }

        return total
    } catch {
        fatalError("Failed to read file: \(error)")
    }
}


let total = parseInput1(filePath: "input.txt")
print("Total Sum: \(total)")

let total1 = processInput(filePath: "input.txt")
print("Total Sum: \(total1)")
