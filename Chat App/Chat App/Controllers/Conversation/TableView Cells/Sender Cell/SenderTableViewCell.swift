//
//  SenderTableViewCell.swift
//  Chat App
//
//  Created by MAC108 on 21/03/22.
//

import UIKit

class SenderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var timeLbl: UILabel!
    
    
    static let nib = UINib(nibName: "SenderTableViewCell", bundle: nil)
    static let identifier = "SenderTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.messageView.layer.cornerRadius = self.messageView.frame.height / 4
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
     
}
