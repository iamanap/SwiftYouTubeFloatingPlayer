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
## Screen Cast
[SwiftYouTubeFloatingPlayer](https://youtu.be/AdOxohhO_Pc)


## Installation
Copy Classes and Resources folders to your project.

## Usage

Pass a NSURL or [NSURL], customize the tableView on YTF view adopting delegate and dataSource in your ViewController before passing them as parameters and also provide a nib for cell customization:
```swift
YTFPlayer.initYTF(urls, tableCellNibName: "MyCell", delegate: self, dataSource: self)
```

Show YTF view passing a ViewController:
```swift
YTFPlayer.showYTFView(self)
```

Remove YTF view animated(true) or not(false):
```swift
YTFPlayer.finishYTFView(true)
```

## Author

hanappaula, apso0101@gmail.com

## License

SwiftYouTubeFloatingPlayer is available under the MIT license. See the LICENSE file for more info.
