//
//  ViewController.swift
//  Physico
//
//  Created by Lyndon Michael Bibera on 6/1/15.
//  Copyright (c) 2015 Hack of All Codes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var gameView: UIView!
    
    private let numberOfBlocks = 10
    
    private let gravity = UIGravityBehavior()
    
    private lazy var collider: UICollisionBehavior = {
        let lazyCollider = UICollisionBehavior()
        lazyCollider.translatesReferenceBoundsIntoBoundary = true
        return lazyCollider
    }()
    
    private lazy var animator: UIDynamicAnimator = {
        return UIDynamicAnimator(referenceView: self.gameView)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        animator.addBehavior(gravity)
        animator.addBehavior(collider)
    }

    @IBAction func tap(sender: UITapGestureRecognizer) {
        addBlock()
    }
    
    func addBlock() {
        var size = gameView.bounds.size.width / CGFloat(numberOfBlocks)
        var dropSize = CGSize(width: size, height: size)
        var frame = CGRect(origin: CGPointZero, size: dropSize)
        frame.origin.x = CGFloat.random(numberOfBlocks) * dropSize.width
        
        var dropView = UIView(frame: frame)
        dropView.backgroundColor = UIColor.random
        
        gameView.addSubview(dropView)
        
        gravity.addItem(dropView)
        collider.addItem(dropView)
    }

}

private extension CGFloat {
    static func random(max: Int) -> CGFloat {
        return CGFloat(arc4random() % UInt32(max))
    }
}

private extension UIColor {
    class var random: UIColor {
        switch arc4random()%5 {
        case 0: return UIColor.greenColor()
        case 1: return UIColor.blueColor()
        case 2: return UIColor.orangeColor()
        case 3: return UIColor.redColor()
        case 4: return UIColor.purpleColor()
        default: return UIColor.blackColor()
        }
    }
}
