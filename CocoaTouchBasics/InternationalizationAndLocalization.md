# Internationalization and Localization
Localization is the process of translating your app into multiple languages.


```objectivec
//source code:
//looks for the key "Change" from the Localizable.strings file
NSString *myString = NSLocalizedString(@"Change", "The title of the button when it is changed");
```
```int8
//Base.lproj
"Change" = "Change";

//es.lproj:
"Change" = "Cambiar";
```


[Demo: Internationalization](/ObjectiveCProjects/I8Loc8Demo)



**Resources:**
* [NSHipster: Localized Strings](http://nshipster.com/nslocalizedstring/)
* [Apple: Internationalization and Localization](https://developer.apple.com/library/ios/documentation/MacOSX/Conceptual/BPInternational/Introduction/Introduction.html#//apple_ref/doc/uid/10000171i)
