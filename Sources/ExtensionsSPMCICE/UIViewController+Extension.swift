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

public enum Storyboards: String {
    case main = "Main"
    var storyboard: UIStoryboard {
        return UIStoryboard(name: rawValue, bundle: nil)
    }
}

public extension UIViewController {
     
    class func loadFromNib<T: UIViewController>() -> T {
        return T(nibName: String(describing: self), bundle: nil)
    }
    
    class func controller(from storyboards: Storyboards) -> Self? {
        return controller(in: storyboards.storyboard, identifier: nameOfClass)
    }
    
    class func controller(in storyboard: UIStoryboard, identifier: String) -> Self? {
        return instantiateControllerInStoryboard(storyboard, identifier: identifier)
    }
    
    fileprivate class func instantiateControllerInStoryboard<T: UIViewController>(_ storyboard: UIStoryboard, identifier: String) -> T? {
        if let storyboard = storyboard.instantiateViewController(withIdentifier: identifier) as? T {
            return storyboard
        }
        
        return nil
    }
    
    static func topViewController() -> UIViewController? {
        return topViewController(withRoot: UIApplication.shared.windows.first?.rootViewController)
    }
    
    static func topViewController(withRoot root: UIViewController?) -> UIViewController? {
        if let newRoot = (root as? UITabBarController)?.selectedViewController {
            return topViewController(withRoot: newRoot)
        }
        
        if let newRoot = (root as? UINavigationController)?.visibleViewController {
            return topViewController(withRoot: newRoot)
        }
        
        if let newRoot = root?.presentedViewController {
            return topViewController(withRoot: newRoot)
        }
        
        return root
    }
}
