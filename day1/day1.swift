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
    
    print("List 1: \(list1)")
    print("List 2: \(list2)")
} catch {
    print("Error reading file: \(error)")
}
