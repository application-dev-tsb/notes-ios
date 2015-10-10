# Auto Layout and Layout Constraints
```objectivec
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 30.0f, 30.0f)];
    self.v1 = view;
    
    view.translatesAutoresizingMaskIntoConstraints = NO; //rect is ignored, constraints take over the size
    
    view.backgroundColor = [UIColor greenColor];
    
    [self.view addSubview:view];
    
    //frame = 0 0 ; 0 80
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view(==80)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view)]];
    
    //
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view)]];
}
```
[Demo Project: Apple Autolayout](/SwiftProjects/autolayoutcookbook)

## Intrinsic Size
**UIView.instrinsicContentSize** describes the minimum space needed to express the full view with squeezing or clipping the data (ie: UILabel.title, or image size of image in UIImageView)

**Source:**

* [Apple Developer: About Auto Layout and Layout Constraints](https://developer.apple.com/library/ios/recipes/xcode_help-IB_auto_layout/chapters/UnderstandingAutolayout.html)
* [Visual Format Language](http://commandshift.co.uk/blog/2013/01/31/visual-format-language-for-autolayout/)
