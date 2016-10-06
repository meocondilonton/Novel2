//
//  ChapterTableViewCell.swift
//  FreeNovelOnline
//
//  Created by long nguyen on 9/9/16.
//  Copyright © 2016 long nguyen. All rights reserved.
//

import UIKit

class ChapterTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var lblContent: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    func setCellSelect(isSelect:Bool){
        if isSelect == true {
            self.bgView.backgroundColor = textWhiteBlurColor
        }else{
            self.bgView.backgroundColor = UIColor.clearColor()
        }
    }
    
    func updateData(item:Item?) {
      self.lblContent.text = item?.itemName ?? ""
    }

}
