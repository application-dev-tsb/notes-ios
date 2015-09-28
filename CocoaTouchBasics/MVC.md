# Model-View-Controller
The Model-View-Controller (MVC) design pattern assigns objects in an application one of three roles: model, view, or controller. The pattern defines not only the roles objects play in the application, it defines the way objects communicate with each other. Each of the three types of objects is separated from the others by abstract boundaries and communicates with objects of the other types across those boundaries. The collection of objects of a certain MVC type in an application is sometimes referred to as a layer—for example, model layer.
![MVC Diagram](https://developer.apple.com/library/ios/documentation/General/Conceptual/DevPedia-CocoaCore/Art/model_view_controller.jpg)

## Model
* encapsulate data
* define logic and computation to manipulate and process data
* can have a to-one and to-many relationship with other objects

## View
* represents and object that users can see
* knows how to draw itself
* can respond to user action

## Controller

