# Dynamic Animation

## Steps for Adding Dynamic Animation to Views
```swift
// 1.) Create a Dynamic Animator
var animator = UIDynamicAnimator(referenceView: myView)

// 2.) Add Dynamic Behaviors
var collider = UICollisionBehavior()
collider.translatesReferenceBoundsIntoBoundary = true
animator.add(collider)

// 3.) Add Items (UIView) to Dynamic Behavior
collider.add(subView)
```

## Composite Behavior
```swift
// 1.) extend UIDynamicBehavior

// 2.) invoke addChildBehavior

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
```


Source: [Apple Inc.](https://developer.apple.com/library/prerelease/ios/documentation/UIKit/Reference/UIDynamicBehavior_Class/index.html)
