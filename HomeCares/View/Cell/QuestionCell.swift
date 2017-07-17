//
//  QuestionCell.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/10/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import UIKit

class QuestionCell: UITableViewCell {

    // MARK: Property
    
    @IBOutlet weak var avartaImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var thankLabel: UILabel!
    @IBOutlet weak var thankButton: UIButton!
    @IBOutlet weak var moreCommentButton: UIButton!
    @IBOutlet weak var commentButtonHeight: NSLayoutConstraint!
    
    internal weak var delegate: QuestionCellDelegate?
    internal var question: Question!
    internal var indexPath: IndexPath!
    internal var isExpand = false
    
    
    // MARK: Internal method
    
    internal func configure(question: Question, indexPath: IndexPath) {
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
        var old = ""
        if let date = DateHelper.shared.date(from: question.userPerson.birthDay, format: .yyyy_MM_dd_T_HH_mm_ss_Z) {
            old = "\(date.age) tuổi"
        }

        var gender = ""
        switch question.userPerson.gender! {
        case .male:
            gender = "Nam"
        case .female:
            gender = "Nữ"
        default :
            gender = "Khác"
        }
        timeLabel.text = question.created.timeInterval + " . "
            + gender + " . "
            + old + " . "
            + question.userPerson.address
        thankLabel.text = "\(question.questionThanks.count) cảm ơn."
        moreCommentButton.isHidden = false
        commentButtonHeight.constant = 15.0
        if question.questionReplies.count == 0 {
            if question.allowEveryOneAnswer {
                moreCommentButton.setTitle("Trả lời", for: .normal)
            } else {
                moreCommentButton.isHidden = true
                commentButtonHeight.constant = 0.0
            }
            if isExpand {
                moreCommentButton.setTitle("Ẩn bình luận", for: .normal)
            } else {
                moreCommentButton.setTitle("Trả lời", for: .normal)
            }
        } else {
            if isExpand {
                moreCommentButton.setTitle("Ẩn bình luận", for: .normal)
            } else {
                moreCommentButton.setTitle("Xem bình luận (\(question.questionReplies.count))", for: .normal)
            }

        }
        
        if isUserThank(question: question) {
            thankButton.tintColor = UIColor.primary
        } else {
            thankButton.tintColor = UIColor.darkGray
        }
        
        thankButton.isSelected = isUserThank(question: question)
        
    }
    
    internal func isUserThank(question: Question) -> Bool {
        if let userId = UserDefaults.personId {
            for q in question.questionThanks {
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
        
        for questionThank in question.questionThanks {
            if questionThank.personId == personId  {
                delegate?.didUnselectThank(question: questionThank, indexPath: indexPath)
                return
            }
        }
        let questionThank = QuestionThank()
        questionThank.created = "\(Date())"
        questionThank.updated = "\(Date())"
        questionThank.personId = personId
        questionThank.questionId = question.questionId
        delegate?.didSelectedThank(question: questionThank, indexPath: indexPath)
    }
    
    @IBAction func moreCommentAction(_ sender: Any) {
        delegate?.didSeeMoreComment(question: question, indexPath: indexPath)
    }
}

protocol QuestionCellDelegate: class {
    func didSelectedThank(question: QuestionThank, indexPath: IndexPath)
    func didUnselectThank(question: QuestionThank, indexPath: IndexPath)
    func didSeeMoreComment(question: Question, indexPath: IndexPath)
}
