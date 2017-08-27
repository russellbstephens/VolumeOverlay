//  Copyright © 2017 russellbstephens. All rights reserved.

import UIKit
import MediaPlayer

public class VolumeOverlay {
    public static var shared = VolumeOverlay()
    private let volumeWindow: UIWindow
    private static let statusBarHeight: CGFloat = 20.0

    private var overlay: VolumeOverlayView?
    private var overlayTopConstraint: NSLayoutConstraint?
    private var displayTimer: Timer?
    
    public var backgroundColor: UIColor = .white {
        didSet {
            overlay?.backgroundColor = backgroundColor
        }
    }
    
    public var trackTintColor: UIColor = .gray {
        didSet {
            overlay?.volumeProgress.trackTintColor = trackTintColor
        }
    }
    
    public var progressTintColor: UIColor = .black {
        didSet {
            overlay?.volumeProgress.progressTintColor = progressTintColor
        }
    }
    
    init() {
        volumeWindow = UIWindow(frame: .zero)
        volumeWindow.windowLevel = UIWindowLevelStatusBar
        volumeWindow.rootViewController = VolumeOverlayController()
        
        let volumeView = MPVolumeView(frame: .zero)
        volumeView.alpha = 0.01
        volumeView.showsRouteButton = false
        volumeView.isUserInteractionEnabled = false
        UIApplication.shared.windows.first?.addSubview(volumeView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(VolumeOverlay.volumeChanged(_:)), name: NSNotification.Name(rawValue: AVSystemControllerNotifications.systemVolumeDidChangeNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(VolumeOverlay.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func volumeChanged(_ notification: Notification) {
        if let volume = notification.userInfo?[AVSystemControllerNotifications.audioVolumeNotificationParameter] as? Float {
            overlay?.volumeProgress.progress = volume
            show()
        }
    }
    
    public func load(style: Style = .full) {
        let overlay = VolumeOverlayView(style: style)
        overlay.backgroundColor = backgroundColor
        overlay.volumeProgress.trackTintColor = trackTintColor
        overlay.volumeProgress.progressTintColor = progressTintColor
        overlay.translatesAutoresizingMaskIntoConstraints = false
        self.overlay = overlay
        volumeWindow.addSubview(overlay)
        let overlayLeftConstraint = NSLayoutConstraint(item: overlay, attribute: .left, relatedBy: .equal, toItem: volumeWindow, attribute: .left, multiplier: 1, constant: 0)
        let overlayRightConstraint = NSLayoutConstraint(item: overlay, attribute: .right, relatedBy: .equal, toItem: volumeWindow, attribute: .right, multiplier: 1, constant: 0)
        let overlayTopConstraint = NSLayoutConstraint(item: overlay, attribute: .top, relatedBy: .equal, toItem: volumeWindow, attribute: .top, multiplier: 1, constant: 0)
        self.overlayTopConstraint = overlayTopConstraint
        NSLayoutConstraint.activate([overlayLeftConstraint, overlayRightConstraint, overlayTopConstraint])
    }
    
    func show() {
        displayTimer?.invalidate()
        displayTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(VolumeOverlay.hide), userInfo: nil, repeats: false)
        
        volumeWindow.isHidden = false
        volumeWindow.makeKeyAndVisible()
        volumeWindow.layer.removeAllAnimations()
        overlayTopConstraint?.constant = VolumeOverlay.statusBarHeight
        UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.volumeWindow.layoutIfNeeded()
        })
    }
    
    @objc func hide() {
        volumeWindow.layer.removeAllAnimations()
        overlayTopConstraint?.constant = 0
        UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.volumeWindow.layoutIfNeeded()
        }, completion: { [weak self] _ in
            self?.volumeWindow.isHidden = true
        })
    }
    
    @objc func rotated() {
        var frame = UIScreen.main.bounds
        frame.origin.y -= VolumeOverlay.statusBarHeight
        volumeWindow.frame = frame
    }
}
