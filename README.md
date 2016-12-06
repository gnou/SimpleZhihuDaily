# Simple ZhihuDaily
一个简单的[**知乎日报**](http://daily.zhihu.com)阅读器。

* 用到的第三方库包括：
  * [Alamofire](https://github.com/Alamofire/Alamofire)
  * [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)
  * [Kingfisher](https://github.com/onevcat/Kingfisher)
  * [Realm](https://realm.io/)

使用 [Carthage](https://github.com/Carthage/Carthage) 管理。

## 为什么是 Cathage

考虑到 **Swift Package Manager** 依然处于beta状态, 除了 *Carthage* 之外我能选的就只有 **CocoaPods** 了。
*Carthage* 和 *CocoaPods* 两者各有优缺。在我看来 *Carthage* 最大的缺点是不能像 *CocoaPods* 那样方便的查看第三方库的代码实现，但不用每次都把第三方库的代码都编一遍这个好处就让我下定决心要用它了。
就像它的名字那样，**Swift** 到现在还在飞速发展，每年都是一个新的样子，我们享受各种新东西的同时，各种bug也一直没断过，最近困扰我的最大问题就是 *Swift* 的[编译时间问题](https://medium.com/@RobertGummesson/regarding-swift-build-time-optimizations-fc92cdd91e31#.43ddf9po4)了，原本只需要一分钟的工程，现在竟然需要5分钟，简直不能忍，所以不用每次都编译第三方库的 *Carthage* 就成为了我最喜欢的包管理工具。

## Core Data vs. Realm
因为公司的某个app大量使用了 **Core Data**，接手那个项目以来我没少用它，*Core Data* 当然有我喜欢的地方，比如 [NSFetchedResultsController](https://developer.apple.com/reference/coredata/nsfetchedresultscontroller)，但也有不少我痛恨不已的地方。其实在我看来，*Core Data* 最大的问题是它根本不是为 *Client-Server*架构准备的。
这个项目里的数据库其实就是一种*Cache*，没必要使用*Core Data*这种重量级的框架。
我对**Realm**一直很好奇(不得不提的是，他们的[Blog](https://realm.io/news/)简直太好了)，所以正好趁这个机会试试看。
