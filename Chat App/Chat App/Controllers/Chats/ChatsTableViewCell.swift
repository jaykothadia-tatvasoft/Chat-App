//
//  ChatsTableViewCell.swift
//  Chat App
//
//  Created by MAC108 on 16/03/22.
//

import UIKit

class ChatsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!
    
    static let identifier = "ChatsTableViewCell"
    static let nib = UINib(nibName: "ChatsTableViewCell", bundle: nil)
    
    var user: UserModel? {
        didSet {
            guard let firstName = user?.firstName, let lastName = user?.lastName else { return }
            self.nameLbl.text = "\(firstName) \(lastName)"
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
