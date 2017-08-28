# VolumeOverlay

![VolumeOverlay: Drop-in Replacement Volume Overlay for iOS](https://github.com/russellbstephens/VolumeOverlay/blob/master/imgs/style_full.png)

## Usage

Add the following in `didFinishLaunchingWithOptions` in the AppDelegate
```
VolumeOverlay.shared.load()
```

### Customization

#### Colors

```
VolumeOverlay.shared.backgroundColor = .white
VolumeOverlay.shared.trackTintColor = .grey
VolumeOverlay.shared.progressTintColor = .black
```

#### Style

```
VolumeOverlay.shared.load(style: .thin)
```
