# View 

## View Hierarchies and and Subview Management

## View Drawing Cycle
The UIView class uses an on-demand drawing model for presenting content. When a view first appears on the screen, the system asks it to draw its content

[Implementing your Drawing Code](https://developer.apple.com/library/ios/documentation/WindowsViews/Conceptual/ViewPG_iPhoneOS/CreatingViews/CreatingViews.html#//apple_ref/doc/uid/TP40009503-CH5-SW3)

## Content Modes
Each view has a content mode that controls how the view recycles its content in response to changes in the view’s geometry and whether it recycles its content at all

![ContentMode Diagram](https://developer.apple.com/library/ios/documentation/WindowsViews/Conceptual/ViewPG_iPhoneOS/Art/scale_aspect.jpg)

## Stretchable Views
You can designate a portion of a view as stretchable so that when the size of the view changes only the content in the stretchable portion is affected

## View Geometry and Coordinate System

## Frame, Bounds, and Center Properties
A view object tracks its size and location using its frame, bounds, and center properties:
* The frame property contains the frame rectangle, which specifies the size and location of the view in its superview’s coordinate system
* The bounds property contains the bounds rectangle, which specifies the size of the view (and its content origin) in the view’s own local coordinate system
* The center property contains the known center point of the view in the superview’s coordinate system
* By default, a view’s frame is not clipped to its superview’s frame. Thus, any subviews that lie outside of their superview’s frame are rendered in their entirety, you can change this behavior, though, by setting the superview’s **clipsToBounds** property to **YES**
* Regardless of whether or not subviews are clipped visually, touch events always respect the bounds rectangle of the target view’s superview

**Sources:**
* [Apple Developer: View Programming Guide](https://developer.apple.com/library/ios/documentation/WindowsViews/Conceptual/ViewPG_iPhoneOS/WindowsandViews/WindowsandViews.html)
