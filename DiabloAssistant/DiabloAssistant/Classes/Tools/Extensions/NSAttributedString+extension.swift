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
    static func getSkillDescriptionAttributedText(skillName: String?, skillLevel: Int, htmlString: String?) -> NSAttributedString {
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
extension NSAttributedString{
    static func getItemDescriptionAttributedText(details: SCEquipmentItemDetails?,withoutTitle: Bool = false)->NSAttributedString{
        guard let details = details,
              let colorName = details.color else{
            return NSAttributedString(string: "")
        }
        let nextRow = NSMutableAttributedString(string: "\n\n")
        nextRow.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 5)], range: NSRange(location: 0, length: nextRow.length))
        
        let itemDescription = NSMutableAttributedString(string: "")
        var color = UIColor.white
        switch colorName {
        case "blue":
            color = SCItemBlue
        case "white":
            color = UIColor.white
        case "yellow":
            color = SCItemYellow
        case "orange":
            color = SCItemOrange
        case "green":
            color = SCItemGreen
        default:
            break
        }
        if !withoutTitle{
            setDescription(nextRow: nextRow,text: details.name,color: color, font: UIFont(name: "Exocet", size: 18)!, parentAttrString: itemDescription)
        }
        
        setDescription(nextRow: nextRow,text: details.typeName,color: color, parentAttrString: itemDescription)
        if (details.dps?.count ?? 0) > 0{
            setDescription(nextRow: nextRow,text: details.dps,color: UIColor.white,font: UIFont.boldSystemFont(ofSize: 20), parentAttrString: itemDescription)
            setDescription(nextRow: nextRow,text: "Damage Per Second",color: UIColor.darkGray, parentAttrString: itemDescription)
            setDamageHtmlDescription(nextRow: nextRow,text: details.damageHtml, color: UIColor.darkGray, parentAttrString: itemDescription)
        }
        if (details.armorHtml?.count ?? 0) > 0{
            setDescription(nextRow: nextRow,text: details.armorHtml,color: UIColor.white,font: UIFont.boldSystemFont(ofSize: 20), parentAttrString: itemDescription)
            setDescription(nextRow: nextRow,text: "Armor",color: UIColor.darkGray, parentAttrString: itemDescription)
        }
        if (details.attributes?.primary?.count ?? 0) > 0{
            setDescription(nextRow: nextRow,text: "Primary", color: UIColor.white,font:  UIFont.boldSystemFont(ofSize: 14), parentAttrString: itemDescription)
            for attribute in details.attributes?.primary ?? []{
                setAttributeDescription(nextRow: nextRow,text: attribute.textHtml, parentAttrString: itemDescription)
            }
        }
        if (details.attributes?.secondary?.count ?? 0) > 0{
            setDescription(nextRow: nextRow,text: "Secondary", color: UIColor.white,font:  UIFont.boldSystemFont(ofSize: 14) ,parentAttrString: itemDescription)
            for attribute in details.attributes?.secondary ?? []{
                setAttributeDescription(nextRow: nextRow,text: attribute.textHtml, parentAttrString: itemDescription)
            }
        }
        if (details.attributes?.other?.count ?? 0) > 0{
            setDescription(nextRow: nextRow,text: "Other", color: UIColor.white,font:  UIFont.boldSystemFont(ofSize: 14), parentAttrString: itemDescription)
            for attribute in details.attributes?.other ?? []{
                setAttributeDescription(nextRow: nextRow, text: attribute.textHtml, color: SCItemBlue, parentAttrString: itemDescription)
            }
        }
        if ((details.randomAffixes?.count ?? 0) > 0){
            for affixes in details.randomAffixes ?? []{
                if (affixes.oneOf?.count ?? 0) > 0{
                    setDescription(nextRow: nextRow,text: "One of \(affixes.oneOf!.count) Magic Properties (varies)", color: UIColor.white, font: UIFont.boldSystemFont(ofSize: 14), parentAttrString: itemDescription)
                }
                for arrtribute in affixes.oneOf ?? []{
                    setAttributeDescription(nextRow: nextRow, text: arrtribute.textHtml, color: SCItemBlue, parentAttrString: itemDescription)
                }
            }
        }
        if (details.setNameHtml?.count ?? 0) > 0{
            setAttributeDescription(nextRow: nextRow,text: details.setNameHtml, color: color, font: UIFont.boldSystemFont(ofSize: 14), parentAttrString: itemDescription)
        }
        if (details.setDescriptionHtml?.count ?? 0) > 0{
            setAttributeDescription(nextRow: nextRow,text: details.setDescriptionHtml, color: color, parentAttrString: itemDescription)
        }
        if details.accountBound > 0{
            setDescription(nextRow: nextRow,text: "Account Bound\nUnique Equipped", color: SCButtonTitleColor, parentAttrString: itemDescription)
        }
        return itemDescription
    }
    private static func setDescription(nextRow: NSAttributedString,text: String?,color: UIColor, font: UIFont = UIFont.systemFont(ofSize: 14), parentAttrString: NSMutableAttributedString){

        let attrString = NSMutableAttributedString(string: "\(text ?? "")")
        attrString.addAttributes([
            NSAttributedString.Key.font : font,
            NSAttributedString.Key.foregroundColor: color
            ], range: NSRange(location: 0, length: attrString.length))
        parentAttrString.append(attrString)
        if attrString.length > 0{
            parentAttrString.append(nextRow)
        }
    }
    
    private static func setDamageHtmlDescription(nextRow: NSAttributedString,text: String?, color: UIColor, font: UIFont = UIFont.boldSystemFont(ofSize: 13),parentAttrString: NSMutableAttributedString){
        let des = text ?? ""
        let digits = Style("p").font(font).foregroundColor(.white)
        let details = Style("span").font(font).foregroundColor(color)
        let all = Style.font(font).foregroundColor(color)
        parentAttrString.append(des.style(tags: [digits,details]).styleAll(all).attributedString)
        if des.count > 0{
            parentAttrString.append(nextRow)
        }
    }
    
    private static func setAttributeDescription(nextRow: NSAttributedString,text: String?, color: UIColor = SCItemBlue, font: UIFont = UIFont.systemFont(ofSize: 13),parentAttrString: NSMutableAttributedString){
        let des = text ?? ""
        let details = Style("span").font(font).foregroundColor(color)
        let all = Style.font(font).foregroundColor(color)
        parentAttrString.append(des.style(tags: [details]).styleAll(all).attributedString)
        if des.count > 0{
            parentAttrString.append(nextRow)
        }
    }
}
extension NSAttributedString{
    static func getHeroItemDescription(details: SCProfileEquipmentItem?)->NSAttributedString{
        guard let details = details,
            let colorName = details.displayColor else{
                return NSAttributedString(string: "")
        }
        let nextRow = NSMutableAttributedString(string: "\n\n")
        nextRow.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 5)], range: NSRange(location: 0, length: nextRow.length))
        
        let itemDescription = NSMutableAttributedString(string: "")
        var color = UIColor.white
        switch colorName {
        case "blue":
            color = SCItemBlue
        case "white":
            color = UIColor.white
        case "yellow":
            color = SCItemYellow
        case "orange":
            color = SCItemOrange
        case "green":
            color = SCItemGreen
        default:
            break
        }
        
        setDescription(nextRow: nextRow,text: details.typeName,color: color, parentAttrString: itemDescription)
        setDescription(nextRow: nextRow,text: details.slots,color: UIColor.darkGray, parentAttrString: itemDescription)
        
        if (details.dps?.count ?? 0) > 0{
            setDescription(nextRow: nextRow,text: details.dps,color: UIColor.white,font: UIFont.boldSystemFont(ofSize: 20), parentAttrString: itemDescription)
            setDescription(nextRow: nextRow,text: "Damage Per Second",color: UIColor.darkGray, parentAttrString: itemDescription)
            setDamageHtmlDescription(nextRow: nextRow,text: details.damage, color: UIColor.darkGray, parentAttrString: itemDescription)
        }
        if details.armor > 0{
            setDescription(nextRow: nextRow,text: "\(details.armor)",color: UIColor.white,font: UIFont.boldSystemFont(ofSize: 20), parentAttrString: itemDescription)
            setDescription(nextRow: nextRow,text: "Armor",color: UIColor.darkGray, parentAttrString: itemDescription)
        }
        if (details.attributesHtml?.primary?.count ?? 0) > 0{
            setDescription(nextRow: nextRow,text: "Primary", color: UIColor.white,font:  UIFont.boldSystemFont(ofSize: 14), parentAttrString: itemDescription)
            for attribute in details.attributesHtml?.primary ?? []{
                setAttributeDescription(nextRow: nextRow,text: attribute, parentAttrString: itemDescription)
            }
        }
        if (details.attributesHtml?.secondary?.count ?? 0) > 0{
            setDescription(nextRow: nextRow,text: "Secondary", color: UIColor.white,font:  UIFont.boldSystemFont(ofSize: 14) ,parentAttrString: itemDescription)
            for attribute in details.attributesHtml?.secondary ?? []{
                setAttributeDescription(nextRow: nextRow,text: attribute, parentAttrString: itemDescription)
            }
        }
        if (details.attributesHtml?.other?.count ?? 0) > 0{
            setDescription(nextRow: nextRow,text: "Other", color: UIColor.white,font:  UIFont.boldSystemFont(ofSize: 14), parentAttrString: itemDescription)
            for attribute in details.attributesHtml?.other ?? []{
                setAttributeDescription(nextRow: nextRow, text: attribute, color: SCItemBlue, parentAttrString: itemDescription)
            }
        }
        if (details.gems?.count ?? 0) > 0{
            for gem in details.gems ?? []{
                let gemColor = gem.isJewel == 1 ? SCItemOrange : SCItemYellow
                for attribute in gem.attributes ?? []{
                    setAttributeDescription(nextRow: nextRow, text: attribute, color: gemColor, font: UIFont.boldSystemFont(ofSize: 13), parentAttrString: itemDescription)
                }
            }
        }
        
        if details.transmog != nil{
            setDescription(nextRow: nextRow,text: "Transmogrification:", color: SCItemBlue,font:  UIFont.boldSystemFont(ofSize: 14), parentAttrString: itemDescription)
            setAttributeDescription(nextRow: nextRow, text: details.transmog?.name, color: UIColor.white,font: UIFont.boldSystemFont(ofSize: 13), parentAttrString: itemDescription)
        }
        
        if details.set != nil {
            setAttributeDescription(nextRow: nextRow,text: details.set?.name, color: color, font: UIFont.boldSystemFont(ofSize: 14), parentAttrString: itemDescription)
            setAttributeDescription(nextRow: nextRow,text: details.set?.descriptionHtml, color: color, parentAttrString: itemDescription)
        }
       
        if details.accountBound > 0{
            setDescription(nextRow: nextRow,text: "Required level: \(details.requiredLevel)\nAccount Bound\nUnique Equipped", color: SCButtonTitleColor, parentAttrString: itemDescription)
        }
        return itemDescription
    }
}
