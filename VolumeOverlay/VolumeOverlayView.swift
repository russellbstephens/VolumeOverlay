//  Copyright © 2017 russellbstephens. All rights reserved.

import UIKit

class VolumeOverlayView: UIView {
    let volumeProgress = UIProgressView()
    
    init(style: Style) {
        super.init(frame: .zero)
        
        volumeProgress.progress = 0.0
        volumeProgress.translatesAutoresizingMaskIntoConstraints = false
        addSubview(volumeProgress)
        let volumeCenterYConstraint = NSLayoutConstraint(item: volumeProgress, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        let volumeLeftConstraint = NSLayoutConstraint(item: volumeProgress, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: style.margins)
        let volumeRightConstraint = NSLayoutConstraint(item: volumeProgress, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -style.margins)
        let volumeHeightConstraint = NSLayoutConstraint(item: volumeProgress, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 2)
        let heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: style.height)
        NSLayoutConstraint.activate([volumeCenterYConstraint, volumeLeftConstraint, volumeRightConstraint, volumeHeightConstraint, heightConstraint])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
