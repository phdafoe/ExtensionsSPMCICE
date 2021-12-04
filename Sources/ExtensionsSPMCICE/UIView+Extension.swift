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

public extension UIView {
    
    static func doLeftViewSlideTransition(view1: UIView, view2: UIView, distance: CGFloat = 500, time: Double = 0.3) {
        let initialRect = view1.frame
        view2.frame = CGRect(x: view1.frame.origin.x + distance, y: view1.frame.origin.y, width: view1.frame.size.width, height: view1.frame.size.height)
        view2.isHidden = false
        
        UIView.animate(withDuration: time, delay: 0, options: .curveEaseInOut, animations: {
            view1.frame = CGRect(x: view1.frame.origin.x - distance, y: view1.frame.origin.y, width: view1.frame.size.width, height: view1.frame.size.height)
            view2.frame = initialRect
        }, completion: { _ in
            view1.frame = initialRect
            view1.isHidden = true
        })
    }
    
    static func doRightViewSlideTransition(view1: UIView, view2: UIView, distance: CGFloat = 500, time: Double = 0.3) {
        let initialRect = view1.frame
        view2.frame = CGRect(x: view1.frame.origin.x - distance, y: view1.frame.origin.y, width: view1.frame.size.width, height: view1.frame.size.height)
        view2.isHidden = false
        
        UIView.animate(withDuration: time, delay: 0, options: .curveEaseInOut, animations: {
            view1.frame = CGRect(x: view1.frame.origin.x + distance, y: view1.frame.origin.y, width: view1.frame.size.width, height: view1.frame.size.height)
            view2.frame = initialRect
        }, completion: { _ in
            view1.frame = initialRect
            view1.isHidden = true
        })
    }
    
    func addSubviewWithConstraints(_ insets: UIEdgeInsets, subView: UIView) {
        
        self.addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraint(NSLayoutConstraint(item: subView,
                                              attribute: .top,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .top,
                                              multiplier: 1.0,
                                              constant: insets.top))
        
        self.addConstraint(NSLayoutConstraint(item: subView,
                                              attribute: .trailing,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .trailing,
                                              multiplier: 1.0,
                                              constant: insets.right))
        
        self.addConstraint(NSLayoutConstraint(item: subView,
                                              attribute: .bottom,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .bottom,
                                              multiplier: 1.0,
                                              constant: insets.bottom))
        
        self.addConstraint(NSLayoutConstraint(item: subView,
                                              attribute: .leading,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .leading,
                                              multiplier: 1.0,
                                              constant: insets.left))
        
        subView.layoutIfNeeded()
    }
    
    func addSubviewWithConstraintsWithoutBottom(_ insets: UIEdgeInsets, subView: UIView) {
        
        self.addSubview(subView)
        subView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addConstraint(NSLayoutConstraint(item: subView,
                                              attribute: .top,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .top,
                                              multiplier: 1.0,
                                              constant: insets.top))
        
        self.addConstraint(NSLayoutConstraint(item: subView,
                                              attribute: .trailing,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .trailing,
                                              multiplier: 1.0,
                                              constant: insets.right))
                
        self.addConstraint(NSLayoutConstraint(item: subView,
                                              attribute: .leading,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .leading,
                                              multiplier: 1.0,
                                              constant: insets.left))
        
        subView.layoutIfNeeded()
    }
    
    func createImage() -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let img: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return img!
    }
    
    func createImage(deg degrees: CGFloat) -> UIImage {
        
        var image = self.createImage()
        image = self.imageRotatedByDegrees(oldImage: image, deg: degrees)
        
        return image
    }
    
    func imageRotatedByDegrees(oldImage: UIImage, deg degrees: CGFloat) -> UIImage {
        
        //Calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox: UIView = UIView(frame: CGRect(x: 0, y: 0, width: oldImage.size.width, height: oldImage.size.height))
        let trans: CGAffineTransform = CGAffineTransform(rotationAngle: degrees * CGFloat.pi / 180)
        rotatedViewBox.transform = trans
        let rotatedSize: CGSize = rotatedViewBox.frame.size
        //Create the bitmap context
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap: CGContext = UIGraphicsGetCurrentContext()!
        //Move the origin to the middle of the image so we will rotate and scale around the center.
        bitmap.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
        //Rotate the image context
        bitmap.rotate(by: (degrees * CGFloat.pi / 180))
        //Now, draw the rotated/scaled image into the context
        bitmap.scaleBy(x: 1.0, y: -1.0)
        bitmap.draw(oldImage.cgImage!, in: CGRect(x: -oldImage.size.width / 2, y: -oldImage.size.height / 2, width: oldImage.size.width, height: oldImage.size.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func searchScroll(view: UIView) -> UIScrollView? {
        
        if view.superview == nil {
            
            return nil
            
        } else if (view.superview?.isKind(of: UIScrollView.self))! {
            
            if let view = view.superview as? UIScrollView {
                return (view)
            } else {
                return nil
            }
            
        } else {
            
            return self.searchScroll(view: view.superview!)
        }
    }
    
    class func createComponentFromXIB<T: UIView>(viewType: T.Type) -> T? {
        if let component: T = Bundle.main.loadNibNamed(String(describing: viewType), owner: nil, options: nil)?.first as? T {
            component.translatesAutoresizingMaskIntoConstraints = false
            return component
        }
        
        return nil
    }
    
    func applyGradient(colours: [UIColor]) {
        self.applyGradient(colours: colours, locations: nil)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    // Método que devuelve la constraint pedida por parámetro de una vista
    func findConstraint(layoutAttribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint? {
        if let constraints = superview?.constraints {
            for constraint in constraints where itemMatch(constraint: constraint, layoutAttribute: layoutAttribute) {
                return constraint
            }
        }
        return nil
    }
    
    func itemMatch(constraint: NSLayoutConstraint, layoutAttribute: NSLayoutConstraint.Attribute) -> Bool {
        if let firstItem = constraint.firstItem as? UIView, let secondItem = constraint.secondItem as? UIView {
            let firstItemMatch = firstItem == self && constraint.firstAttribute == layoutAttribute
            let secondItemMatch = secondItem == self && constraint.secondAttribute == layoutAttribute
            return firstItemMatch || secondItemMatch
        }
        return false
    }
    
    func roundedByDefault(radious: CGFloat = 6) {
        self.layer.cornerRadius = radious
        self.clipsToBounds = true
    }
}
