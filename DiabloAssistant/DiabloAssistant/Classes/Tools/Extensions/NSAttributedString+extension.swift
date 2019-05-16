//
//  NSAttributedString+extension.swift
//  SinaWeibo
//
//  Created by Stephen Cao on 9/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

extension NSAttributedString{
    
    /// calculate label height accroding to label size
    ///
    /// - Parameter size: label size
    /// - Returns: label height
    func getTextHeight(size: CGSize)->CGFloat{
        return boundingRect(
            with: size,
            options:
            [NSStringDrawingOptions.usesLineFragmentOrigin],
            context: nil).height
    }
}
