import Foundation

class FileParser {
    var filePath: String
    
    init(filePath: String) {
        self.filePath = filePath
    }
    
    func parseFile() -> [(Int, Int)]? {
        do {
            let fileURL = URL(fileURLWithPath: filePath)
            let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
            var numberPairs: [(Int, Int)] = []
            
            let lines = fileContents.split(separator: "\n")
            for line in lines {
                let columns = line.split(separator: "   ")
                if columns.count == 2, let num1 = Int(columns[0]), let num2 = Int(columns[1]) {
                    numberPairs.append((num1, num2))
                }
            }
            return numberPairs
        } catch {
            print("Error reading file: \(error)")
            return nil
        }
    }
}

class BusinessLogic {
    var list1: [Int]
    var list2: [Int]
    
    init(list1: [Int], list2: [Int]) {
        self.list1 = list1
        self.list2 = list2
    }
    
    func calculateTotalDistance() -> Int {
        let sortedList1 = list1.sorted()
        let sortedList2 = list2.sorted()
        
        var totalDistance = 0
        for i in 0..<sortedList1.count {
            totalDistance += abs(sortedList1[i] - sortedList2[i])
        }
        return totalDistance
    }
    
    func calculateSimilarityScore() -> Int {
        var similarityScore = 0
        for num in list1 {
            let count = list2.filter { $0 == num }.count
            similarityScore += num * count
        }
        return similarityScore
    }
}


func main() {
    let filePath = "input.txt"
    
    let fileParser = FileParser(filePath: filePath)
    
    guard let numberPairs = fileParser.parseFile() else {
        print("Failed to parse file.")
        return
    }
    
    var list1: [Int] = []
    var list2: [Int] = []
    
    for pair in numberPairs {
        list1.append(pair.0)
        list2.append(pair.1)
    }
    
    let businessLogic = BusinessLogic(list1: list1, list2: list2)
    
    let totalDistance = businessLogic.calculateTotalDistance()
    let similarityScore = businessLogic.calculateSimilarityScore()
    
    print("Total Distance: \(totalDistance)")
    print("Similarity Score: \(similarityScore)")
}

main()
