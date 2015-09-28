# Application
The app delegate performs several crucial roles:
* It contains your app’s startup code.
* It responds to key changes in the state of your app. Specifically, it responds to both temporary interruptions and to changes in the execution state of your app, such as when your app transitions from the foreground to the background.
* It responds to notifications originating from outside the app, such as remote notifications (also known as push notifications), low-memory warnings, download completion notifications, and more.
* It determines whether state preservation and restoration should occur and assists in the preservation and restoration process as needed.
* It responds to events that target the app itself and are not specific to your app’s views or view controllers.
* You can use it to store your app’s central data objects or any content that does not have an owning view controller.