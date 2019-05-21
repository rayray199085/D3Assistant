//
//  NSAttributedString+extension.swift
//  SinaWeibo
//
//  Created by Stephen Cao on 9/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit
import Atributika

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
    /// Transform html string to attributed string for textView
    ///
    /// - Parameters:
    ///   - skillName: skill name
    ///   - skillLevel: required level
    ///   - htmlString: description html
    /// - Returns: attributed string for showing description
    static func getDescriptionAttributedText(skillName: String?, skillLevel: Int, htmlString: String?) -> NSAttributedString {
        let skillDescription = NSMutableAttributedString(string: "\(skillName ?? "")\n")
        skillDescription.addAttributes(
            [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15),
             NSAttributedString.Key.foregroundColor: SCButtonTitleColor], range: NSRange(location: 0, length: skillDescription.length))
        
        let des = htmlString ?? ""
        let digits = Style("span").font(.boldSystemFont(ofSize: 13)).foregroundColor(.green)
        let all = Style.font(.systemFont(ofSize: 13)).foregroundColor(SCButtonTitleColor)
        skillDescription.append(des.style(tags: [digits]).styleAll(all).attributedString)
        
        let requiredLevel = NSMutableAttributedString(string: "\nRequired level: \(skillLevel)")
        requiredLevel.addAttributes(
            [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 13),
             NSAttributedString.Key.foregroundColor: UIColor.purple], range: NSRange(location: 0, length: requiredLevel.length))
        skillDescription.append(requiredLevel)
        return skillDescription
    }
}
