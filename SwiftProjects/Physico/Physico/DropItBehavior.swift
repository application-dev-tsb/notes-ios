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
    
    override init() {
        super.init()
        addChildBehavior(gravity)
        addChildBehavior(collider)
    }
    
    func addDrop(drop: UIView) {
        gravity.addItem(drop)
        collider.addItem(drop)
    }
    
}
