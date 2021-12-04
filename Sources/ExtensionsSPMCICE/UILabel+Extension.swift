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

open class LabelStyle {
    
    public let text: String
    public let style: [NSAttributedString.Key: Any]
    
    public init(text: String, style:[NSAttributedString.Key: Any]) {
        self.text = text
        self.style = style
    }
}

public extension UILabel {
    
    @IBInspectable private var xibLocKey: String? {
        get { return nil }
        set(key) {
            text = key?.localized
        }
    }
    
    // Method to highlight specific strings
    func highlightSubstring(string: String, font: UIFont, color: UIColor) {
        
        let range = (self.text! as NSString).range(of: string)
        let attributedSecondLabel = NSMutableAttributedString(string: self.text!)
        attributedSecondLabel.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        attributedSecondLabel.addAttribute(NSAttributedString.Key.font, value: font, range: range)
        self.attributedText = attributedSecondLabel
        
    }
    
    func styles(_ styles: [LabelStyle]) {
        
        guard let mainText = styles.first?.text,
              let mainAttributed = styles.first?.style else { return }
        
        let attributes = NSMutableAttributedString(string: mainText, attributes: mainAttributed)
        
        for style in styles {
            
            let styledRange = (attributes.string as NSString).range(of: style.text)
            
            attributes.setAttributes(style.style as [NSAttributedString.Key: Any], range: styledRange)
        }
        
        self.attributedText = attributes
    }
}
