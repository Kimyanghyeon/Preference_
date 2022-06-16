//
//  TimeLineTableViewCell.swift
//  Preference_
//
//  Created by 김양현 on 2022/06/14.
//

import UIKit

class TimeLineTableViewCell: UITableViewCell {
    
    @IBOutlet weak var S_image: UIImageView!
    @IBOutlet weak var s_nickname: UILabel!
    @IBOutlet weak var s_time: UILabel!
    @IBOutlet weak var s_loc: UILabel!
    @IBOutlet weak var s_text: UILabel!
    @IBOutlet weak var sub: UILabel!
    @IBOutlet weak var tag1: UILabel!
    @IBOutlet weak var tag2: UILabel!
    @IBOutlet weak var tag3: UILabel!
    @IBOutlet weak var w_time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }//end of awakwFromNid

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }//end of setSelect

}//end of class
