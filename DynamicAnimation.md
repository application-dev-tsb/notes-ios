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
