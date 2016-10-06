
//
//  DetailInfoStoryTableViewCell.swift
//  FreeNovelOnline
//
//  Created by long nguyen on 9/5/16.
//  Copyright © 2016 long nguyen. All rights reserved.
//

import UIKit

class DetailInfoStoryTableViewCell: UITableViewCell {

    @IBOutlet weak var lblContent: UIVerticalAlignLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
    }
    
    func updateData(str:String?){
         self.lblContent.text = str ?? ""
        self.lblContent.verticalAlignment = .VerticalAlignmentTop
     
       
         
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
