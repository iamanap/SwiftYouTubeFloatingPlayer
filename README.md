# YouTubePlayerSwift

A Swift floating/draggable player like YouTube that remains on top of all screens until it's removed.
Based on [PlayerView](https://github.com/davidlondono/PlayerView) and [DraggableYoutubeFloatingVideo](https://github.com/vizllx/DraggableYoutubeFloatingVideo).

## Requirements

Currently YTF view is only supported on applications supporting only portrait orientations. To implement that you must put this in your AppDelegate:
```swift
func application(application: UIApplication, supportedInterfaceOrientationsForWindow window: UIWindow?) -> UIInterfaceOrientationMask {
    return UIInterfaceOrientationMask.Portrait
}
```

## Installation
Copy Classes and Resources folders to your project.

## Usage

Adopt YTFProtocol on all ViewControllers you'll interact with YTF view:
```swift
class ViewController: UIViewController, YTFProtocol
```

Pass a NSURL or [NSURL], customize the tableView on YTF view adopting delegate and dataSource in your ViewController before passing them as parameters and, if wanted, also provide a nib for cell customization:
```swift
initYTF(urls, tableCellNibName: "MyCell", delegate: self, dataSource: self)
```
or
```swift
initYTF(urls, tableCellNibName: nil, delegate: self, dataSource: self)
```

Show YTF view passing a ViewCtroller:
```swift
showYTFView(self)
```

Remove YTF view:
```swift
finishYTFView()
```

## Author

hanappaula, apso0101@gmail.com

## License

SwiftYouTubeFloatingPlayer is available under the MIT license. See the LICENSE file for more info.
