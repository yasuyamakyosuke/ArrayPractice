import SwiftUI

var mode: [String: Int] = ["sample": 10, "value": 20]
var uhdata: Int = 0
var sampleValue: Int = 0
var data: [(Int, Int)] = [
    (1, 2),
    (3, 4),
    (5, 6),
    (7, 8),
    (9, 10),
    (11, 12),
    (2, 14),
    (11, 14),
    (14, 14),
    (21, 14),
    (15, 16),
    (17, 18),
    (19, 20)
]

func selectRandomValue() -> Int {
    var randomValue = Int.random(in: 2...20)
    
    // 偶数になるまでランダムに選び直す
    while randomValue % 2 != 0 {
        randomValue = Int.random(in: 2...20)
    }
    
    return randomValue
}

func findMinMaxValuePairs(for value: Int, in data: [(Int, Int)]) -> [(Int, Int)] {
    var minValue: Int?
    var maxValue: Int?
    
    for tuple in data {
        if tuple.1 == value {
            if let currentMinValue = minValue {
                if tuple.0 < currentMinValue {
                    minValue = tuple.0
                }
            } else {
                minValue = tuple.0
            }
            
            if let currentMaxValue = maxValue {
                if tuple.0 > currentMaxValue {
                    maxValue = tuple.0
                }
            } else {
                maxValue = tuple.0
            }
        }
    }
    
    // 最大値と最小値が同じ場合は、最大値のみを持つTupleを返す
    if let minValue = minValue, let maxValue = maxValue, minValue != maxValue {
        return [(minValue, value), (maxValue, value)]
    } else if let minValue = minValue {
        return [(minValue, value)]
    } else {
        return []
    }
}

struct ContentView: View {
    @State private var selectedValue: Int?
    @State private var minValuePairs: [(Int, Int)] = []
    
    var body: some View {
        VStack {
            Button("Select Random Value") {
                let randomValue = selectRandomValue()
                self.selectedValue = randomValue
                self.minValuePairs = findMinMaxValuePairs(for: randomValue, in: data)
            }
            .padding()
            
            if let selectedValue = selectedValue {
                Text("Selected Value: \(selectedValue)")
                    .padding()
            }
            
            if minValuePairs.isEmpty {
                Text("No matching pairs found.")
                    .padding()
            } else {
                ForEach(minValuePairs, id: \.0) { pair in
                    Text("Min/Max Value Pair: \(pair.0)/\(pair.1)")
                        .padding()
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
