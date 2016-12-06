//
//  ImageShadowView.swift
//  DreamProductLister
//
//  Created by Venkateswara on 24/11/16.
//  Copyright © 2016 Sindhu. All rights reserved.
//

import UIKit

private var materialKey = false
extension UIView {

    @IBInspectable var materialDesign : Bool {
        get {
            return materialKey
        }
        set {
            materialKey = newValue
            
            if materialKey {
                self.layer.shadowColor = UIColor.lightGray.cgColor
                self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                self.layer.shadowOpacity = 0.5
                self.layer.shadowRadius = 3.0
                self.layer.cornerRadius = 3.0
                self.layer.masksToBounds = false
        
            }
        }
    }
}
