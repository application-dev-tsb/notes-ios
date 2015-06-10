//
//  DropItBehavior.swift
//  Physico
//
//  Created by Lyndon Michael Bibera on 6/1/15.
//  Copyright (c) 2015 Hack of All Codes. All rights reserved.
//

import UIKit

class DropItBehavior: UIDynamicBehavior {
   
    private let gravity = UIGravityBehavior()
    
    private lazy var collider: UICollisionBehavior = {
        let lazyCollider = UICollisionBehavior()
        lazyCollider.translatesReferenceBoundsIntoBoundary = true
        return lazyCollider
    }()
    
    private lazy var dropBehavior: UIDynamicItemBehavior = {
       let lazyDropItBehavior = UIDynamicItemBehavior()
        lazyDropItBehavior.allowsRotation = false
        lazyDropItBehavior.elasticity = 0.8
        return lazyDropItBehavior
    }()

    override init() {
        super.init()
        addChildBehavior(gravity)
        addChildBehavior(collider)
        addChildBehavior(dropBehavior)
    }
    
    func addDrop(drop: UIView) {
        dynamicAnimator?.referenceView?.addSubview(drop)
        gravity.addItem(drop)
        collider.addItem(drop)
        dropBehavior.addItem(drop)
    }
    
    func removeDrop(drop: UIView) {
        gravity.removeItem(drop)
        collider.removeItem(drop)
        dropBehavior.removeItem(drop)
        drop.removeFromSuperview()
    }
    
}
