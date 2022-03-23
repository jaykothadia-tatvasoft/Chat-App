//
//  DateTableViewCell.swift
//  Chat App
//
//  Created by MAC108 on 22/03/22.
//

import UIKit

class DateTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var dateView: UIView!
    @IBOutlet weak var dateLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.dateView.layer.cornerRadius = self.dateView.frame.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
