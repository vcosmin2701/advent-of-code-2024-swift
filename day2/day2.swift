import Foundation

class FileParser {
    var filePath: String

    init(filePath: String) {
        self.filePath = filePath
    }

    func parseFile() -> [[Int]]? {
        do {
            let fileURL = URL(fileURLWithPath: filePath)
            let fileContents = try String(contentsOf: fileURL, encoding: .utf8)

            var accumulator: [[Int]] = []

            let lines = fileContents.split(separator: "\n")
            for line in lines {
                let numbers = line.split(separator: " ")
                    .compactMap { Int($0) }

                if !numbers.isEmpty {
                    accumulator.append(numbers)
                }
            }
            return accumulator
        } catch {
            print("Error reading file: \(error)")
            return nil
        }
    }
}

class BusinessLogic {

    func checkLevel(list1: [Int]) -> String {
        var isIncreasing = true
        var isDecreasing = true

        for i in 0..<list1.count - 1 {
            let num1 = list1[i]
            let num2 = list1[i + 1]

            let difference = abs(num1 - num2)
            
            if difference < 1 || difference > 3 {
                return "Unsafe"
            }

            if difference > 0 {
                isDecreasing = false
            } else if difference < 0 {
                isIncreasing = false
            }
        }

        if !isIncreasing && !isDecreasing {
            return "Unsafe"
        }

        return "Safe"
    }
}

func main() {
    let filePath: String = "input.txt"

    let fileParser = FileParser(filePath: filePath)

    guard let arrays = fileParser.parseFile() else {
        print("Failed to parse file")
        return
    }

    let businessLogic = BusinessLogic()
    var safeReports = 0
    var unsafeReports = 0

    for report in arrays {
        let result = businessLogic.checkLevel(list1: report)
        if result == "Safe" {
            safeReports += 1
        } else {
            unsafeReports += 1
        }
    }

    print("Safe reports: \(safeReports)")
    print("Unsafe reports: \(unsafeReports)")
}

main()
