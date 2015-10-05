# Internationalization and Localization
Localization is the process of translating your app into multiple languages.


```objectivec
//source code:
//looks for the key "Change" from the Localizable.strings file
NSString *myString = NSLocalizedString(@"Change", "The title of the button when it is changed");
```
```
//file: Base.lproj/Localizable.strings
"Change" = "Change";

//file: es.lproj/Localizable.strings
"Change" = "Cambiar";
```

## Localizing the App Name
* create "InfoPlist.strings"
* make it localizable

<img src="/Images/Internationalize.png" width="200">
```
//file: Base.lproj/InfoPlist.strings
"Change" = "Change";
```
* modify value for "CFBundleDisplayName"
```
//file: es.lproj/InfoPlist.strings
"Change" = "Cambiar";
```

[Demo: Internationalization](/ObjectiveCProjects/I8Loc8Demo)



**Resources:**
* [NSHipster: Localized Strings](http://nshipster.com/nslocalizedstring/)
* [Raywenderlich: Internationalization Tutorial](http://www.raywenderlich.com/64401/internationalization-tutorial-for-ios-2014)
* [Apple: Internationalization and Localization](https://developer.apple.com/library/ios/documentation/MacOSX/Conceptual/BPInternational/Introduction/Introduction.html#//apple_ref/doc/uid/10000171i)
