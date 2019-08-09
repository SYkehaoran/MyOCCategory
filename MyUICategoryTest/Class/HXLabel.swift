//
//  HXLabel.swift
//  HXFundManager
//
//  Created by 柯浩然 on 2019/7/29.
//

/// 获取UIEdgeInsets在水平方向上的值
func UIEdgeInsetsGetHorizontalValue(insets:UIEdgeInsets) -> CGFloat {
    return insets.left + insets.right;
}

/// 获取UIEdgeInsets在垂直方向上的值
func UIEdgeInsetsGetVerticalValue(insets:UIEdgeInsets)->CGFloat {
    return insets.top + insets.bottom;
}
import UIKit

class HXLabel: UILabel {
    
    @objc var contentInset = UIEdgeInsets.zero
    
    override var intrinsicContentSize: CGSize {
        
        var preferredMaxLayoutWidth = self.preferredMaxLayoutWidth
        if preferredMaxLayoutWidth <= 0 {
            preferredMaxLayoutWidth = CGFloat.greatestFiniteMagnitude
        }
        
        return sizeThatFits(CGSize(width: preferredMaxLayoutWidth, height: CGFloat.greatestFiniteMagnitude))
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var size = super.sizeThatFits(CGSize(width: size.width - UIEdgeInsetsGetHorizontalValue(insets: contentInset), height: size.height - UIEdgeInsetsGetVerticalValue(insets: contentInset)))
        size.width += UIEdgeInsetsGetHorizontalValue(insets: self.contentInset)
        size.height += UIEdgeInsetsGetVerticalValue(insets: self.contentInset)
        return size;
    }
}
