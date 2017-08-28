# VolumeOverlay [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

![VolumeOverlay: Drop-in Replacement Volume Overlay for iOS](https://github.com/russellbstephens/VolumeOverlay/blob/master/imgs/style_full.png)

## Installation

### Carthage

You can install [Carthage](https://github.com/Carthage/Carthage) with [Homebrew](http://brew.sh/) using the following command:

```bash
brew update
brew install carthage
```
To integrate VolumeOverlay into your Xcode project using Carthage, specify it in your `Cartfile` where `"x.x.x"` is the current release:

```ogdl
github "russellbstephens/VolumeOverlay" "x.x.x"
```

## Usage

Add the following in `didFinishLaunchingWithOptions` in the AppDelegate
```swift
VolumeOverlay.shared.load()
```

### Customization

#### Colors

```swift
VolumeOverlay.shared.backgroundColor = .white
VolumeOverlay.shared.trackTintColor = .grey
VolumeOverlay.shared.progressTintColor = .black
```

#### Style

```swift
VolumeOverlay.shared.load(style: .thin)
```
