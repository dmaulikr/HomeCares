//
//  QuestionReplyCell.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/10/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import UIKit

class QuestionReplyCell: UITableViewCell {

    // MARK: Property
    
    @IBOutlet weak var avartaImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var thankLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var thankButton: UIButton!
    
    internal var question: QuestionReply!
    internal var indexPath: IndexPath!
    internal var isExpand = false
    
    // MARK: Internal method
    
    internal func configure(question: QuestionReply, indexPath: IndexPath) {
        self.question = question
        self.indexPath = indexPath
        avartaImageView.layer.cornerRadius = 20
        if let url = URL(string: question.userPerson.avatar) {
            avartaImageView.af_setImage(
                withURL         : url,
                placeholderImage: "ic_user_default".image,
                imageTransition : .crossDissolve(0.2),
                completion: { (response) in
                    if let _  = response.result.error {
                        self.avartaImageView.image = "ic_user_default".image
                    }
            })
        } else {
            self.avartaImageView.image = "ic_user_default".image
        }
        nameLabel.text = question.userPerson.firstName +  question.userPerson.middleName + question.userPerson.lastName
        contentLabel.text = question.content
        thankLabel.text = "\(question.questionReplyThanks.count) cảm ơn."
       timeLabel.text = question.created.timeInterval
        if isUserThank(question: question) {
            thankButton.tintColor = UIColor.primary
        } else {
            thankButton.tintColor = UIColor.darkGray
        }
    }
    
    internal func isUserThank(question: QuestionReply) -> Bool {
        if let userId = UserDefaults.userId {
            for q in question.questionReplyThanks {
                if q.personId == userId {
                    return true
                }
            }
        }
        return false
    }

    
    // MARK: Action
    
    @IBAction func thankAction(_ sender: Any) {
        
    }
    
    @IBAction func editAction(_ sender: Any) {
    }
}
