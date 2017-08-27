//  Copyright © 2017 Russell Stephens. All rights reserved.

import Foundation

public enum Style {
    case full
    case thin
    
    var height: CGFloat {
        switch self {
        case .full: return 20
        case .thin: return 2
        }
    }
    
    var margins: CGFloat {
        switch self {
        case .full: return 10
        case .thin: return 0
        }
    }
}
