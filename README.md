# SimpleZhihuDaily
A simple Zhihu daily reader app.

* Third-part libraries used in this app are:
  * [Alamofire](https://github.com/Alamofire/Alamofire)
  * [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)
  * [Kingfisher](https://github.com/onevcat/Kingfisher)
  * [Realm](https://realm.io/)
Managed by Carthage.

## Why Cathage
Since **Swift Package Manager**(in future will use **SPM** abbreviation) is still not ready yet, I really don't have much choice except CocoaPods, so why not CocoaPods?
Carthage is not perfect, the biggest con for me is that you can't brower the source of third-part libraries easily, but the libraries managed by Carthage are not gonna build every time you build your project, and considering all those [Swift build performance issues](https://medium.com/@RobertGummesson/regarding-swift-build-time-optimizations-fc92cdd91e31#.43ddf9po4), it becomes my only choose.

## Core Data vs. Realm
I'm using **Core Data** in one of my production apps, there are things that I like about it, also things I absolutely hate. From my experience, *Core Data* is not designed for Client-Server architecture, like most of the modern apps are. This app is not gonna be a huge project, rely heavilly on local database, I've been curious about **Reaml** for a while(btw, their blog is awesome), I'll try it in this project.
