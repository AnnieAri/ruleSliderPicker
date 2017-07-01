//
//  UIView+ar_Extention.swift
//  Fit
//
//  Created by Ari on 2017/6/30.
//  Copyright © 2017年 com.Ari.fit. All rights reserved.
//

import UIKit
// MARK: - 坐标拓展
extension UIView {
    var ar_x: CGFloat {
        return self.frame.origin.x
    }
    
    var ar_y: CGFloat {
        return self.frame.origin.y
    }
    
    var ar_width: CGFloat {
        return self.frame.size.width
    }
    
    var ar_height: CGFloat {
        return self.frame.size.height
    }
    
    var ar_size: CGSize {
        return self.frame.size
    }
    
    var ar_centerX: CGFloat {
        return self.center.x
    }
    
    var ar_centerY: CGFloat {
        return self.center.y
    }
}
