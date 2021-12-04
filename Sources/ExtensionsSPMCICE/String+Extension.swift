/*
Copyright, everisSL
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.
*/


import Foundation
import UIKit

public extension String {
    
    static let dateFormat = "yyyy-MM-dd"
    
    var localized: String {
        
        return NSLocalizedString(self, comment: "")
    }
    
    func localize(tableName: String? = "Localizable",
                  bundle: Bundle = .main,
                  value: String = "",
                  comment: String = "") -> String {
        
        return NSLocalizedString(self,
                                 tableName: tableName,
                                 bundle: bundle,
                                 value: value,
                                 comment: comment)
    }
    
    var containsWhitespace: Bool {
        return(self.rangeOfCharacter(from: .whitespacesAndNewlines) != nil)
    }
    
    var isBlank: Bool {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty
    }
    
    static func localizeWithParams(string: String, stringsToReplace: [String]) -> String {
        
        var string = string
        let pattern = "%@"
        let arrayOcurrencies =  string.components(separatedBy: pattern)
        for index in 0..<arrayOcurrencies.count {
            
            if !stringsToReplace.indices.contains(index) {
                break
            }
            let range = string.range(of: pattern)
            string = string.replacingOccurrences(of: pattern, with: stringsToReplace[index], options: .literal, range: range)
        }
        return string
    }
    
    //Log functions
    func infoLog(functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
        var className = (fileName as NSString).lastPathComponent
        className = (className.replacingOccurrences(of: ".swift", with: ""))
        
        print("ℹ️ [\(className).\(functionName)] : \(self)")
    }
    func sucessLog(functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
        var className = (fileName as NSString).lastPathComponent
        className = (className.replacingOccurrences(of: ".swift", with: ""))
        
        print("✅ [\(className).\(functionName)] : \(self)")
    }
    func errorLog(functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
        var className = (fileName as NSString).lastPathComponent
        className = (className.replacingOccurrences(of: ".swift", with: ""))
        
        print("🆘 [\(className).\(functionName) ErrorLine:\(lineNumber)] : \(self)")
    }
    
    func createDate(format: String = dateFormat) -> Date? {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = format
        let dateString = dateFormatter.date(from: self)
        
        return dateString
    }
    
    func substringWithRegularExpression (regularExpression: String) -> String {
        
        var subString: String? = ""
        
        do {
            
            let regex = try NSRegularExpression(pattern: regularExpression, options: [])
            let nsString = self as NSString
            
            let results = regex.matches(in: self, options: [], range: NSRange(location: 0, length: nsString.length))
            subString = results.map { nsString.substring(with: $0.range) }.first
            
            if subString == nil {
                
                subString = self
                
            }
            
        } catch let error as NSError {
            
            subString = self
            print(error)
            
        }
        
        return subString!
    }
    
    func base64Encoded() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
    
    func base64Decoded() -> String? {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    var length: Int {
        return self.count
    }
    
    func toBool() -> Bool? {
        switch self {
        case "True", "true", "yes", "1", "Sí", "Si":
            return true
        case "False", "false", "no", "0", "No":
            return false
        default:
            return nil
        }
    }
    
    subscript (index: Int) -> String {
        return self[index ..< index + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (range: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, range.lowerBound)),
                                            upper: min(length, max(0, range.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
    func htmlAttributedString() -> NSAttributedString? {
        guard let data = self.data(using: String.Encoding.utf16, allowLossyConversion: false) else { return nil }
        guard let html = try? NSMutableAttributedString(
            data: data,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil) else { return nil }
        return html
    }
    
    func moneyAttributedString(normalFont: UIFont? = UIFont(name: "Geomanist-WZ-Light", size: 15), smallFont: UIFont? = UIFont(name: "Geomanist-WZ-Light", size: 12.5)) -> NSAttributedString? {
        let decimalIndex = self.firstIndex(of: ",") ?? self.endIndex
        let decimalPart = self[decimalIndex...]
        let normalAttributes = [NSAttributedString.Key.font: normalFont]
        let smallAttributes = [NSAttributedString.Key.font: smallFont]
        
        let attributedString = NSMutableAttributedString(string: self, attributes: normalAttributes as [NSAttributedString.Key: Any])
            
        attributedString.addAttributes(smallAttributes as [NSAttributedString.Key: Any], range: NSRange(location: decimalPart.startIndex.utf16Offset(in: self), length: decimalPart.count))
        return attributedString
    }
    
    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    
    func onlyContainsSpace() -> Bool {
        
        return (self.length > 0) &&
            (self.trimmingCharacters(in: .whitespacesAndNewlines).length == 0)
    }
}

extension StringProtocol where Self: RangeReplaceableCollection {
    
    mutating func insert(separator: Self, every nsymbols: Int) {
        for index in indices.reversed() where index != startIndex &&
            distance(from: startIndex, to: index) % nsymbols == 0 {
                insert(contentsOf: separator, at: index)
        }
    }
    
    func inserting(separator: Self, every nsymbols: Int) -> Self {
        var string = self
        string.insert(separator: separator, every: nsymbols)
        return string
    }
}
