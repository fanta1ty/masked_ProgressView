# maskedProgressView
## maskedProgressView
A custom progress view that lets the user easily present a progress view with masked image containing an alpha chanle (i.e PNG images). The progress view can be animated, can be customized foreground and background colors during animation.

## Usage
maskedProgressView can be setup by programmatically:
```objc
let maskedImage = UIImage(named: "image.png")!
let maskedProgressView = maskedProgressView(withFrame:progressViewRect, maskingImage: maskedImage)
progressView.addSubview(maskedProgressView)
```

maskedProgressView exposed the following methods that let the user customize color, progress and animation timing:
```objc
- func setProgress(_ progress: CGFLoat, animated: Bool)
- func setProgress(_ progress: CGFloat)
- func setBackColor(_ color: UIColor)
- func setFrontColor(_ color: UIColor)
- func setAnimationTime(_ time: CGFloat)
```

## Requirement
'maskedProgressView' requires iOS 8.x or greater.

## License
Usage is provided under the [MIT License](http://opensource.org/licenses/mit-license.php).  See LICENSE for the full details.
