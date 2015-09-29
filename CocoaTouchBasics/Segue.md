# Segue
A segue defines a transition between two view controllers in your app’s storyboard file
![Segue Diagram](https://developer.apple.com/library/prerelease/ios/featuredarticles/ViewControllerPGforiPhoneOS/Art/segue_defined_2x.png)

## Displaying a View Controller
![Segue](https://developer.apple.com/library/prerelease/ios/featuredarticles/ViewControllerPGforiPhoneOS/Art/VCPG_displaying-view-controller-using-segue_9-4_2x.png)
* **shouldPerformSegueWithIdentifier:sender:** - decide if a segue should show
* **prepareForSegue:sender:** - opportunity to set the data for the new ViewController

## Unwind Segue
* Choose the view controller that should appear onscreen at the end of an unwind segue.
* Define an unwind action method on the view controller you chose.
```swift
@IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue)
```
```objectivec
- (IBAction)myUnwindAction:(UIStoryboardSegue*)unwindSegue
```
* Navigate to the view controller that initiates the unwind action.
* Control-click the button (or other object) that should initiate the unwind segue. This element should be in the view controller you want to dismiss.
* Drag to the Exit object at the top of the view controller scene.image: 
![Unwind Segue](https://developer.apple.com/library/prerelease/ios/featuredarticles/ViewControllerPGforiPhoneOS/Art/segue_unwind_linking_2x.png)
* Select your unwind action method from the relationship panel.

[Demo: Unwind Segue](/SwiftProjects/SegueDemo)

## Programatic Invokation
```objectivec
- (void)orientationChanged:(NSNotification *)notification {
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    if (UIDeviceOrientationIsLandscape(deviceOrientation) &&
             !isShowingLandscapeView) {
        [self performSegueWithIdentifier:@"DisplayAlternateView" sender:self];
        isShowingLandscapeView = YES;
    }
// Remainder of example omitted.
}
```

**Sources:**
* [Apple Developers: Using Segue](https://developer.apple.com/library/prerelease/ios/featuredarticles/ViewControllerPGforiPhoneOS/UsingSegues.html)
