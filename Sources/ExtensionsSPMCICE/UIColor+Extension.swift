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

public extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        if #available(iOS 10.0, *) {
            return UIGraphicsImageRenderer(size: size).image { rendererContext in
                self.setFill()
                rendererContext.fill(CGRect(origin: .zero, size: size))
            }
        } else {
            // Fallback on earlier versions
            let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            UIGraphicsBeginImageContextWithOptions(size, false, 0)
            self.setFill()
            UIRectFill(rect)
            let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            return image
        }
    }
 
    class var primaryColor: UIColor {
        return #colorLiteral(red: 0.2039215686, green: 0.7647058824, blue: 0.7725490196, alpha: 1)
    }
    
    class var loginBackgroundColor: UIColor {
        return #colorLiteral(red: 0.07058823529, green: 0.1215686275, blue: 0.3333333333, alpha: 1)
    }
    class var loginPlaceHolderTextFieldColor: UIColor {
        return #colorLiteral(red: 0.4470588235, green: 0.4980392157, blue: 0.6470588235, alpha: 1)
    }
    
     // MARK: CardDetailsToday
    class var cardDetailsTodayBalanceBaseLineColor: UIColor {
        return #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
    }
    
    // MARK: TopBannerAlert
    class var topBannerAlertErrorColor: UIColor {
        return #colorLiteral(red: 1, green: 0.3098039216, blue: 0.3058823529, alpha: 1)
    }
    class var topBannerAlertWarningColor: UIColor {
        return #colorLiteral(red: 0.9294117647, green: 0.6588235294, blue: 0.2823529412, alpha: 1)
    }
    class var topBannerAlertSuccessColor: UIColor {
        return #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
    }
    
    class var wizinkBlue: UIColor {
        return #colorLiteral(red: 0, green: 0.1490196078, blue: 0.4078431373, alpha: 1)
    }
    
    class var wizinkLightGrey: UIColor {
        return #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
    }
    
    class var wizinkSelectedGrey: UIColor {
        return #colorLiteral(red: 0.8823529412, green: 0.8823529412, blue: 0.8823529412, alpha: 1)
    }
    
    class var wizinkGray: UIColor {
        return #colorLiteral(red: 0.7960784314, green: 0.7960784314, blue: 0.7960784314, alpha: 1)
    }
    
    class var wizinkGreen: UIColor {
        return #colorLiteral(red: 0, green: 0.7764705882, blue: 0.7725490196, alpha: 1)
    }
    
    class var wizinkTextGrey: UIColor {
        return #colorLiteral(red: 0.3803921569, green: 0.3803921569, blue: 0.3803921569, alpha: 1)
    }
    
    class var wizinkTextDarkGrey: UIColor {
        return #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    }
    
    class var wizinkBluishGrey: UIColor {
        return #colorLiteral(red: 0.1882352941, green: 0.2274509804, blue: 0.2509803922, alpha: 1)
    }

    class var paymentMethodGrey: UIColor {
        return #colorLiteral(red: 0.9137254902, green: 0.9215686275, blue: 0.9254901961, alpha: 1)
    }

}
