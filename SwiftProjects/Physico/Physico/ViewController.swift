//
//  ViewController.swift
//  Physico
//
//  Created by Lyndon Michael Bibera on 6/1/15.
//  Copyright (c) 2015 Hack of All Codes. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIDynamicAnimatorDelegate {
    
    @IBOutlet weak var gameView: UIView!
    
    private let numberOfBlocks = 10
    
    private var dropItBehavior = DropItBehavior()
    
    private var dropSize: CGSize {
        get {
            var size = gameView.bounds.size.width / CGFloat(numberOfBlocks)
            return CGSize(width: size, height: size)
        }
    }
    
    private lazy var animator: UIDynamicAnimator = {
        var lazyDynamicAnimator = UIDynamicAnimator(referenceView: self.gameView)
        lazyDynamicAnimator.delegate = self
        return lazyDynamicAnimator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        animator.addBehavior(dropItBehavior)
    }

    @IBAction func tap(sender: UITapGestureRecognizer) {
        addBlock()
    }
    
    func addBlock() {
        var frame = CGRect(origin: CGPointZero, size: dropSize)
        frame.origin.x = CGFloat.random(numberOfBlocks) * dropSize.width
        
        var dropView = UIView(frame: frame)
        dropView.backgroundColor = UIColor.random
        
        dropItBehavior.addDrop(dropView)
    }
    
    func dynamicAnimatorDidPause(animator: UIDynamicAnimator) {
        removeCompletedRow()
    }
    
    //magical code from Paul Hegarty
    func removeCompletedRow() {
        var dropsToRemove = [UIView]()
        var dropFrame = CGRect(x: 0, y: gameView.frame.maxY, width: dropSize.width, height: dropSize.height)
        
        do {
            
            dropFrame.origin.x = 0
            dropFrame.origin.y -= dropSize.height
            
            var dropsFound = [UIView]()
            var rowIsComplete = true
            
            for _ in 0 ..< numberOfBlocks {
                var hitPoint = CGPoint(x: dropFrame.midX, y:dropFrame.midY)
                //UIView.hitTest
                //thanks for this awesome method
                //hits the topmost view on that coordinate
                if let hitView = gameView.hitTest(hitPoint, withEvent: nil) {
                    if hitView.superview == gameView {
                        dropsFound.append(hitView)
                    } else {
                        rowIsComplete = false
                    }
                }
                dropFrame.origin.x += dropSize.width
            }
            
            println("row complete? \(rowIsComplete)")
            if rowIsComplete {
                dropsToRemove += dropsFound //the awesomeness of swift (adding list to an existing list)
            }
            
        
        } while dropsToRemove.count == 0 && dropFrame.origin.y > 0
        
        for drop in dropsToRemove {
            dropItBehavior.removeDrop(drop)
        }
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
