import Foundation

// Parse the input data from the file
func parseInput(filePath: String) -> [[Int]] {
    do {
        let fileURL = URL(fileURLWithPath: filePath)
        let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
        
        return fileContents.split(separator: "\n").compactMap { line in
            line.split(separator: " ").compactMap { Int($0) }
        }
    } catch {
        fatalError("Failed to read file: \(error)")
    }
}

func isAllIncreasing(levels: [Int]) -> Bool {
    for i in 0..<levels.count - 1 {
        let diff = levels[i + 1] - levels[i]
        if diff < 1 || diff > 3 {
            return false
        }
    }
    return true
}

func isAllDecreasing(levels: [Int]) -> Bool {
    for i in 0..<levels.count - 1 {
        let diff = levels[i] - levels[i + 1]
        if diff < 1 || diff > 3 {
            return false
        }
    }
    return true
}

func countSafeReports(reports: [[Int]]) -> Int {
    return reports.reduce(0) { count, report in
        if isAllIncreasing(levels: report) || isAllDecreasing(levels: report) {
            return count + 1
        }
        return count
    }
}

func main() {
    let filePath = "input.txt"
    let reports = parseInput(filePath: filePath)
    let safeCount = countSafeReports(reports: reports)
    
    print("Safe count: \(safeCount)")
}

main()
