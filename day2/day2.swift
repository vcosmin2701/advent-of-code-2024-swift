import Foundation

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

func isSafe(levels: [Int], dampen: Bool) -> Bool {
    if isAllIncreasing(levels: levels) || isAllDecreasing(levels: levels) {
        return true
    }
    if dampen {
        for i in levels.indices {
            var modifiedLevels = levels
            modifiedLevels.remove(at: i)
            if isAllIncreasing(levels: modifiedLevels) || isAllDecreasing(levels: modifiedLevels) {
                return true
            }
        }
    }
    return false
}

func countSafeReports(reports: [[Int]], dampen: Bool) -> Int {
    return reports.reduce(0) { count, report in
        if isSafe(levels: report, dampen: dampen) {
            return count + 1
        }
        return count
    }
}

func main() {
    let filePath = "input.txt"
    let reports = parseInput(filePath: filePath)
    let safeCountPart1 = countSafeReports(reports: reports, dampen: false)
    print("Part 1: \(safeCountPart1)")
    let safeCountPart2 = countSafeReports(reports: reports, dampen: true)
    print("Part 2: \(safeCountPart2)")
}

main()
