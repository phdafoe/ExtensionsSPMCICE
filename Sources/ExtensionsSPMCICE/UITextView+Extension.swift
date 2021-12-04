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
import UIKit

open class TextStyled {
    
    public let text: String?
    public let style: [NSAttributedString.Key: Any]?
    public let link: String?
    
    public init(text: String, style: [NSAttributedString.Key: Any], link: String){
        self.text = text
        self.style = style
        self.link = link
    }
}

public extension UITextView {
    
    func styles(main: String,
                mainAttributed: [NSAttributedString.Key: Any],
                styles: [TextStyled]) {
        
        let attributes = NSMutableAttributedString(string: main, attributes: mainAttributed)
        
        for currentStyle in styles {
            guard let text = currentStyle.text,
                  let style = currentStyle.style else {
                self.attributedText = attributes
                return
            }
            
            let styledRange = (attributes.string as NSString).range(of: text)
            
            attributes.setAttributes(style as [NSAttributedString.Key: Any], range: styledRange)
            
            if let link = currentStyle.link {
                
                attributes.addAttribute(.link, value: link, range: styledRange)
                self.linkTextAttributes = style
            }
        }
        
        self.attributedText = attributes
    }
}
