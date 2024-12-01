import Foundation

let filePath = "input.txt"

var list1: [Int] = []
var list2: [Int] = []

do {
    let fileURL = URL(fileURLWithPath: filePath)
    let fileContents = try String(contentsOf: fileURL, encoding: .utf8)
    
    let lines = fileContents.split(separator: "\n")
    
    for line in lines {
        let columns = line.split(separator: "   ")
        
        if columns.count == 2,
           let num1 = Int(columns[0]),
           let num2 = Int(columns[1]) {
            list1.append(num1)
            list2.append(num2)
        }
    }
    
    var totalDistance = 0
    
    let arr1 = list1.sorted()
    let arr2 = list2.sorted()
    
    for i in 0..<arr1.count {
        let distance = abs(arr1[i] - arr2[i])
        totalDistance += distance
    }
    
    print(totalDistance)
    
    var similarityScore = 0
    
    for num in list1 {
        var count = 0
        
        for num1 in list2 {
            if num1 == num {
                count += 1
            }
        }
        similarityScore += num * count
    }
    
    print("Similarity: \(similarityScore)")

    
} catch {
    print("Error reading file: \(error)")
}
