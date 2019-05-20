//
//  NSAttributedString+extension.swift
//  SinaWeibo
//
//  Created by Stephen Cao on 9/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

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

extension NSAttributedString {
    public convenience init?(HTMLString html: String, font: UIFont? = nil) throws {
        let options : [NSAttributedString.DocumentReadingOptionKey : Any] =
            [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
             NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue]
        
        guard let data = html.data(using: .utf8, allowLossyConversion: true) else {
            throw NSError(domain: "Parse Error", code: 0, userInfo: nil)
        }
        
        if let font = font {
            guard let attr = try? NSMutableAttributedString(data: data, options: options, documentAttributes: nil) else {
                throw NSError(domain: "Parse Error", code: 0, userInfo: nil)
            }
            var attrs = attr.attributes(at: 0, effectiveRange: nil)
            attrs[NSAttributedString.Key.font] = font
            attr.setAttributes(attrs, range: NSRange(location: 0, length: attr.length))
            self.init(attributedString: attr)
        } else {
            try? self.init(data: data, options: options, documentAttributes: nil)
        }
    }
}
