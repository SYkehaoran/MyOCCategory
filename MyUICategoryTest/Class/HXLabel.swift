//
//  HXLabel.swift
//  HXFundManager
//
//  Created by 柯浩然 on 2019/7/29.
//  Copyright © 2019 China Asset Management Co., Ltd. All rights reserved.
//

import UIKit

class HXLabel: UILabel {

   @objc var contentInset = UIEdgeInsets.zero
    
    override var intrinsicContentSize: CGSize {
    
        var size = super.intrinsicContentSize
        size.width = size.width + contentInset.left + contentInset.right
        size.height = size.height + contentInset.top + contentInset.bottom
        return size
    }
    
}
