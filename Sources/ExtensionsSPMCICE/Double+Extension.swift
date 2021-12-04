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

public extension Double {
    
    func formatCurrency(showSign: Bool = false, currencySymbol: String? = nil, numberOfDecimales: Int = 0) -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = numberOfDecimales
        
        if let currencySymbol = currencySymbol {
            
            formatter.currencySymbol = currencySymbol
            formatter.numberStyle = .currency
        }
        
        formatter.locale = Locale(identifier: Locale.current.identifier)
        let result = formatter.string(from: self as NSNumber)
        
        if showSign && self >= 0 {
            
            return "+".appending(result!)
        }
        
        return result!
    }
    
    func round(numberOfDecimales: Int) -> String {
        return self.formatCurrency(showSign: false, currencySymbol: nil, numberOfDecimales: numberOfDecimales)
    }
    
    func moneyFormattedString() -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = "."
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.groupingSize = 3
        numberFormatter.decimalSeparator = ","
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.minimumIntegerDigits = 1
        numberFormatter.positiveSuffix = "€"
        numberFormatter.negativeSuffix = "€"
        return numberFormatter.string(for: self as NSNumber)
    }
    
    func percentFormattedString() -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.usesGroupingSeparator = false
        numberFormatter.groupingSize = 3
        numberFormatter.decimalSeparator = ","
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.minimumIntegerDigits = 1
        numberFormatter.positiveSuffix = "%"
        numberFormatter.negativeSuffix = "%"
        return numberFormatter.string(for: self as NSNumber)
    }
}
