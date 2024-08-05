//
//  UIView+Extension.swift
//  ProfileAssignmentUITests
//
//  Created by Muhammad Bilal Shakoor on 8/5/24.
//

import Foundation
import UIKit

extension UIView {
    func roundCorners(cornerRadius: Double = 0.0, borderWidth: CGFloat = 0.0, borderColor: UIColor = .clear, clipToBounds: Bool = true) {
        self.layer.cornerRadius = CGFloat(cornerRadius)
        self.clipsToBounds = clipToBounds
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
    
    func roundCorners(_ corners: CACornerMask, radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        self.layer.maskedCorners = corners
        self.layer.cornerRadius = radius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        
    }
    func addCornerSpecificRadius(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11, *) {
            var cornerMask = CACornerMask()
            if(corners.contains(.topLeft)){
                cornerMask.insert(.layerMinXMinYCorner)
            }
            if(corners.contains(.topRight)){
                cornerMask.insert(.layerMaxXMinYCorner)
            }
            if(corners.contains(.bottomLeft)){
                cornerMask.insert(.layerMinXMaxYCorner)
            }
            if(corners.contains(.bottomRight)){
                cornerMask.insert(.layerMaxXMaxYCorner)
            }
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = cornerMask
        }else{
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
       }
    
    func dropShadow(radius: CGFloat, color: UIColor, opacity: Float, offset: CGSize = .zero, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func roundTop(radius: CGFloat = 7) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
    }
    
    func roundBottom(radius: CGFloat = 7) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
    }
    
    
    func addShadowAndCornerRadius(cornerRadius: CGFloat = 0) {
        let roundCorners = cornerRadius == 0 ? self.frame.size.width/2 : cornerRadius
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: roundCorners).cgPath
        shadowLayer.fillColor = UIColor.white.cgColor
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        shadowLayer.shadowOpacity = 0.2
        shadowLayer.shadowRadius = 3
        self.layer.insertSublayer(shadowLayer, at: 0)
    }
    
    func addShadowAndRadiustoButton(cornerRadius: CGFloat, opacity: Float = 0.1) {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
        self.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = 7
    }
    
    /**
    Fade out a view with a duration 1.0 & Curve Ease In Animation
    
    - parameter duration: custom animation duration
    */
    func fadeInWithAnimation() {
        // Move our fade out code from earlier
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0 // Instead of a specific instance of, say, birdTypeLabel, we simply set [thisInstance] (ie, self)'s alpha
        }, completion: nil)
    }
    
    /**
    Fade out a view with a duration 1.0 & Curve Ease Out Animation
    
    - parameter duration: custom animation duration
    */
    func fadeOutWithAnimation() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.alpha = 0.0
        }, completion: nil)
    }
    
    // there can be other views between `subview` and `self`
    func getConvertedFrame(fromSubview subview: UIView) -> CGRect? {
        // check if `subview` is a subview of self
        guard subview.isDescendant(of: self) else {
            return nil
        }
        var frame = subview.frame
        if subview.superview == nil {
            return frame
        }
        var superview = subview.superview
        while superview != self {
            frame = superview!.convert(frame, to: superview!.superview)
            if superview!.superview == nil {
                break
            } else {
                superview = superview!.superview
            }
        }
        return superview!.convert(frame, to: self)
    }
    
    var fullScreenAnimationDuration: TimeInterval {
        return 0.15
    }

    func minimizeToFrame(_ frame: CGRect) {
        UIView.animate(withDuration: fullScreenAnimationDuration) {
            self.transform = .identity
            self.frame = frame
        }
    }
    
//    class func viewFromNibClassName<T: UIView>(_ nibClassName: T.Type,viewIndex: Int = 0) -> T {
//        return viewFromNibName(classNameForNib(nibClassName), bundle: Bundle(for: nibClassName), viewIndex: viewIndex) as! T
//    }
    
    class func viewFromNibName(_ name: String, bundle: Bundle = Bundle.main, viewIndex: Int = 0) -> UIView? {
        
        let views = bundle.loadNibNamed(name, owner: nil, options: nil) as? [UIView]
        
        if views?.count ?? 0 > viewIndex {
            return views?[viewIndex]
        } else {
            return views?.first
        }
    }
    
    // MARK: - Easy Frames
    
    var frameX: CGFloat { get {return frame.origin.x} set { frame.origin.x = newValue} }
    var frameY: CGFloat { get {return frame.origin.y} set { frame.origin.y = newValue} }
    var frameWidth: CGFloat { get {return frame.width} set { frame.size.width = newValue} }
    var frameHeight: CGFloat { get {return frame.height} set {frame.size.height = newValue} }

    
    // MARK: - Cornar Radius
    
    func setCornarRadius(_ cornarRadius: CGFloat, cornars: UIRectCorner, strokeColor: UIColor?) {
        
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: cornars, cornerRadii: CGSize(width: cornarRadius, height: cornarRadius))
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        if (strokeColor != nil) { maskLayer.strokeColor = strokeColor?.cgColor}
        maskLayer.path = maskPath.cgPath
        
        // Set the newly created shape layer as the mask for the image view's layer
        layer.mask = maskLayer
        
    }
    
    // MARK: - Utility
    
    func removeAllSubviews() {
        self.subviews.forEach{ $0.removeFromSuperview() }
    }
    
    @discardableResult func addTapGestureRecognizer(target: Any?, action: Selector?, cancelsTouchesInView: Bool = true) -> UITapGestureRecognizer {
        
        isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: target, action: action)
        tapGestureRecognizer.cancelsTouchesInView = cancelsTouchesInView
        addGestureRecognizer(tapGestureRecognizer)
        return tapGestureRecognizer
    }
    
    @discardableResult func addLongPressGestureRecognizer(target: Any?, action: Selector?, minimumPressDuration: CFTimeInterval = 1.0) -> UILongPressGestureRecognizer {
        
        isUserInteractionEnabled = true
        let longPressGesture = UILongPressGestureRecognizer(target: target, action: action)
        longPressGesture.minimumPressDuration = minimumPressDuration
        addGestureRecognizer(longPressGesture)
        return longPressGesture
    }

    public var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            var r = self.frame
            r.size.width = newValue
            self.frame = r
        }
    }

    public var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            var r = self.frame
            r.size.height = newValue
            self.frame = r
        }
    }

    /**
     Fade in a view with a duration
     
     - parameter duration: custom animation duration
     */
    func fadeIn(_ duration: TimeInterval = 1.0, alpha: CGFloat = 0.0) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = alpha
        })
    }
    
    /**
     Fade out a view with a duration
     
     - parameter duration: custom animation duration
     */
    func fadeOut(_ duration: TimeInterval = 1.0, alpha: CGFloat = 1.0) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = alpha
        })
    }
    
    func fadeIn(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }) {
        self.alpha = 0.0

        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.isHidden = false
            self.alpha = 1.0
        }, completion: completion)
    }

    func fadeOut(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in }) {
        self.alpha = 1.0

        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.isHidden = true
            self.alpha = 0.0
        }, completion: completion)
    }
    
    /**
     get screenShot of view as image
    
     */
    
    func asImage() -> UIImage {
        
        let renderer = UIGraphicsImageRenderer(bounds: self.bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
    
    @discardableResult
    func constrain(constraints: (UIView) -> [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        let constraints = constraints(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
    
    @discardableResult
    func constrainToEdges(_ inset: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        return constrain {[
            $0.topAnchor.constraint(equalTo: $0.superview!.topAnchor, constant: inset.top),
            $0.leadingAnchor.constraint(equalTo: $0.superview!.leadingAnchor, constant: inset.left),
            $0.bottomAnchor.constraint(equalTo: $0.superview!.bottomAnchor, constant: inset.bottom),
            $0.trailingAnchor.constraint(equalTo: $0.superview!.trailingAnchor, constant: inset.right)
        ]}
    }
    
    func constraint(id: String) -> NSLayoutConstraint? {
        let cc = self.allConstraints()
        for c in cc { if c.identifier == id { return c } }
        //print("someone forgot to label constraint \(id)") //heh!
        return nil
    }
    
    func allConstraints() -> [NSLayoutConstraint] {
         var views = [self]
         var view = self
         while let superview = view.superview {
             views.append(superview)
             view = superview
         }
         return views.flatMap({ $0.constraints }).filter { c in
             return c.firstItem as? UIView == self ||
                 c.secondItem as? UIView == self
         }
     }
}



extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
}


