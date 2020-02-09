//
//  MoveTableViewCell.swift
//  PokedexApp
//
//  Created by Tiago Moreno on 9/02/20.
//  Copyright © 2020 Tiago Moreno. All rights reserved.
//

import UIKit

class MoveTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var moveType: UIImageView!
    @IBOutlet weak var moveName: UILabel!
    private var _move: Move?
    
    var move: Move? {
        get {
            return _move
        }
        set(newValue) {
            _move = newValue
            if let moveObj = _move {
                //Move name
                moveName.text = moveObj.name.capitalizingFirstLetter()
                //Move image
                moveType.image = UIImage(named: moveObj.type.assetImage)
            }
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
