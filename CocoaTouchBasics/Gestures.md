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
```objectivec
// Respond to a swipe gesture
- (IBAction)showGestureForSwipeRecognizer:(UISwipeGestureRecognizer *)recognizer {
       // Get the location of the gesture
       CGPoint location = [recognizer locationInView:self.view];
 
       // Display an image view at that location
       [self drawImageForGestureRecognizer:recognizer atPoint:location];
 
       // If gesture is a left swipe, specify an end location
       // to the left of the current location
       if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
            location.x -= 220.0;
       } else {
            location.x += 220.0;
       }
 
       // Animate the image view in the direction of the swipe as it fades out
       [UIView animateWithDuration:0.5 animations:^{
            self.imageView.alpha = 0.0;
            self.imageView.center = location;
       }];
}
```
* A continuous gesture, such as pinching, takes place over a period of time
```objectivec
// Respond to a rotation gesture
- (IBAction)showGestureForRotationRecognizer:(UIRotationGestureRecognizer *)recognizer {
       // Get the location of the gesture
       CGPoint location = [recognizer locationInView:self.view];
 
       // Set the rotation angle of the image view to
       // match the rotation of the gesture
       CGAffineTransform transform = CGAffineTransformMakeRotation([recognizer rotation]);
       self.imageView.transform = transform;
 
       // Display an image view at that location
       [self drawImageForGestureRecognizer:recognizer atPoint:location];
 
      // If the gesture has ended or is canceled, begin the animation
      // back to horizontal and fade out
      if (([recognizer state] == UIGestureRecognizerStateEnded) || ([recognizer state] == UIGestureRecognizerStateCancelled)) {
           [UIView animateWithDuration:0.5 animations:^{
                self.imageView.alpha = 0.0;
                self.imageView.transform = CGAffineTransformIdentity;
           }];
      }
 
}
```

## Responding to Events with Gesture Recognizers
There are three things you do to add a built-in gesture recognizer to your app:
* Create and configure a gesture recognizer instance.
This step includes assigning a target, action, and sometimes assigning gesture-specific attributes (such as the numberOfTapsRequired).
* Attach the gesture recognizer to a view.
```objectivec
- (void)viewDidLoad {
     [super viewDidLoad];
 
     // Create and initialize a tap gesture
     UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
          initWithTarget:self action:@selector(respondToTapGesture:)];
 
     // Specify that the gesture must be a single tap
     tapRecognizer.numberOfTapsRequired = 1;
 
     // Add the tap gesture recognizer to the view
     [self.view addGestureRecognizer:tapRecognizer];
 
     // Do any additional setup after loading the view, typically from a nib
}
```
* Implement the action method that handles the gesture.

## Interacting with Other Gesture Recognizers
A view can have more than one gesture recognizer attached to it. When a view has multiple gesture recognizers attached to it, you may want to alter how the competing gesture recognizers receive and analyze touch events:
* Declaring a Specific Order for Two Gesture Recognizers
* Preventing Gesture Recognizers from Analyzing Touches
* Permitting Simultaneous Gesture Recognition

**Source:**
* [Apple Developers: Gesture Recognizers](https://developer.apple.com/library/prerelease/watchos/documentation/EventHandling/Conceptual/EventHandlingiPhoneOS/GestureRecognizer_basics/GestureRecognizer_basics.html#//apple_ref/doc/uid/TP40009541-CH2-SW2)
