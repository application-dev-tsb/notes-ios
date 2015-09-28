# Application
The app delegate performs several crucial roles:
* It contains your app’s startup code.
* It responds to key changes in the state of your app. Specifically, it responds to both temporary interruptions and to changes in the execution state of your app, such as when your app transitions from the foreground to the background.
* It responds to notifications originating from outside the app, such as remote notifications (also known as push notifications), low-memory warnings, download completion notifications, and more.
* It determines whether state preservation and restoration should occur and assists in the preservation and restoration process as needed.
* It responds to events that target the app itself and are not specific to your app’s views or view controllers.
* You can use it to store your app’s central data objects or any content that does not have an owning view controller.

## Launch Time Tasks
* Look at the launch options dictionary to determine why your app was launched
* Determine whether state restoration should proceed
* Register for any remote notifications your app supports
* Open a URL that was sent to your app
* Provide the root window object for your app. Technically, the app delegate provided by Xcode already implements the window property, so you do not have to do anything special here unless you want to customize your app’s window.

## Responding to Notifications and Events
* When a remote notification arrives
* When a local notification fire
* When the user taps a custom action in the alert for a remote or local notification’s
* For apps that want to initiate background downloads
* For apps that use the NSURLSession class to perform background downloads
* low-memory condition
* significant change in time
* user locks the device (protected files)

## Managing State Transition
![State Transition Diagram](https://developer.apple.com/library/prerelease/ios/documentation/UIKit/Reference/UIApplicationDelegate_Protocol/Art/high_level_flow_2x.png)

**Source:**
* [Apple Developers: UIApplicationDelegate](https://developer.apple.com/library/prerelease/ios/documentation/UIKit/Reference/UIApplicationDelegate_Protocol/) 
