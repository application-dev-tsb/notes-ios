# Alert Controller
```objectivec
UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"New" message:@"Create a new todo item" preferredStyle:UIAlertControllerStyleAlert];
    
[alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
    textField.placeholder = @"Group...";
}];
    
[alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
    textField.placeholder = @"Task...";
}];
    
UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
  ...insert action here...
}];
    
UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
[alertController addAction:defaultAction];
[alertController addAction:cancelAction];
    
[self presentViewController:alertController animated:YES completion:nil];
```

**Sources:**
* [NSHipster: Alert Controller](http://nshipster.com/uialertcontroller/)
* [Apple Developer: UIAlertController](https://developer.apple.com/library/prerelease/ios/documentation/UIKit/Reference/UIAlertController_class/index.html#//apple_ref/occ/cl/UIAlertController)
