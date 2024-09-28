import UIKit

//Reverse String
extension String {
    func reverseMyString() -> String{
        var newString = ""
        for str in self{
            newString.insert(str, at: newString.startIndex)
        }
        return newString
    }
}


let myString = "All that we see or seem is but a dream within a dream.".reverseMyString()
print(myString)
