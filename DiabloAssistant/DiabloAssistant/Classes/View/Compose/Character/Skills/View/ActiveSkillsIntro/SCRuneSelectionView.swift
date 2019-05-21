//
//  SCRuneSelectionView.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 20/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

protocol SCRuneSelectionViewDelegate: NSObjectProtocol {
    func didSelectedRuneItem(view: SCRuneSelectionView, tag: Int)
}
class SCRuneSelectionView: UIView {
    
    weak var delegate: SCRuneSelectionViewDelegate?
   
    /// set up rune View according to the selection of active skills
    ///
    /// - Parameter index: the index of active skill
    func setupRuneView(runes: [SCRunes]?){
        // clear all previous subView
        clearRuneViewSubviews()
        guard let runes = runes else{
            return
        }
        let width: CGFloat = 40
        let horizontalMargin: CGFloat = 5
        let itemCount = CGFloat(runes.count)
        let leftMargin = (bounds.width - width * itemCount - horizontalMargin * (itemCount - 1)) / 2
        let y = (bounds.height - width) / 2
        for (index,rune) in runes.enumerated(){
            let runeItem = SCActiveSkillRuneView.runeView()
            var x = leftMargin + width * CGFloat(index)
            x += index > 0 ? horizontalMargin * CGFloat(index) : 0
            runeItem.frame = CGRect(x: x, y: y, width: width, height: width)
            
            runeItem.runeButton.setBackgroundImage(UIImage(named: "rune\(rune.type?.uppercased() ?? "")"), for: [])
            runeItem.runeButton.tag = index
            runeItem.delegate = self
            addSubview(runeItem)
        }
    }
    
    func clearRuneViewSubviews(){
        for v in subviews{
            v.removeFromSuperview()
        }
    }
}
extension SCRuneSelectionView: SCActiveSkillRuneViewDelegate{
    func didClickRune(view: SCActiveSkillRuneView, tag: Int) {
        for runeItem in subviews as! [SCActiveSkillRuneView]{
            runeItem.cancelSelection()
        }
        (subviews[tag] as! SCActiveSkillRuneView).didSelected()
        delegate?.didSelectedRuneItem(view: self, tag: tag)
    }
}
