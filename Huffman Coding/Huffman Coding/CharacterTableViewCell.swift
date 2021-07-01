//
//  CharacterTableViewCell.swift
//  
//
//  Created by Manuel Pleš on 13/05/2020.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    @IBOutlet weak var characterLabel: UILabel!
    @IBOutlet weak var characterFrequencyLabel: UILabel!
    @IBOutlet weak var characterCodeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
