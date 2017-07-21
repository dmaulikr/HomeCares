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
  
    @IBOutlet weak var editIconButton: UIButton!
    
    internal var question: QuestionReply!
    internal var indexPath: IndexPath!
    internal var isExpand = false
    internal weak var delegate: QuestionReplyCellDelegate?
    
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
        thankButton.isSelected = isUserThank(question: question)
        if let personId = UserDefaults.personId {
            editButton.isHidden = !(question.personId == personId)
            editIconButton.isHidden = !(question.personId == personId)
        }
    }
    
    internal func isUserThank(question: QuestionReply) -> Bool {
        if let userId = UserDefaults.personId {
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
        guard let personId = UserDefaults.personId else { return }
        
        for questionReplyThank in question.questionReplyThanks {
            if questionReplyThank.personId == personId {
                delegate?.didUnthankReplyQuestion(question: questionReplyThank, indexPath: indexPath)
                return
            }
        }
        
        let questionReplyThank = QuestionReplyThank()
        questionReplyThank.personId = personId
        questionReplyThank.created = "\(Date())"
        questionReplyThank.updated = "\(Date())"
        questionReplyThank.questionReplyId = question.questionReplyId
        delegate?.didThankReplyQuestion(question: questionReplyThank, indexPath: indexPath)
    }
    
    @IBAction func editAction(_ sender: Any) {
        delegate?.didEditReplyQuestion(question: question, indexPath: indexPath)
    }
}

protocol QuestionReplyCellDelegate: class {
    func didThankReplyQuestion(question: QuestionReplyThank, indexPath: IndexPath)
    func didUnthankReplyQuestion(question: QuestionReplyThank, indexPath: IndexPath)
    func didEditReplyQuestion(question: QuestionReply, indexPath: IndexPath)
}
