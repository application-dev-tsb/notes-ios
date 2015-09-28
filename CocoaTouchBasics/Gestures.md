# Gestures
The UIKit framework provides predefined gesture recognizers that detect common gestures:
* UITapGestureRecognizer
* UIPinchGestureRecognizer
* UIPanGestureRecognizer
* UISwipeGestureRecognizer
* UIRotationGestureRecognizer
* UILongPressGestureRecognizer

## Discrete and Continuous Gestures
* A discrete gesture, such as a tap, occurs once
* A continuous gesture, such as pinching, takes place over a period of time

## Responding to Events with Gesture Recognizers
There are three things you do to add a built-in gesture recognizer to your app:
* Create and configure a gesture recognizer instance.
This step includes assigning a target, action, and sometimes assigning gesture-specific attributes (such as the numberOfTapsRequired).
* Attach the gesture recognizer to a view.
* Implement the action method that handles the gesture.


**Source:**
* [Apple Developers: Gesture Recognizers](https://developer.apple.com/library/prerelease/watchos/documentation/EventHandling/Conceptual/EventHandlingiPhoneOS/GestureRecognizer_basics/GestureRecognizer_basics.html#//apple_ref/doc/uid/TP40009541-CH2-SW2)
