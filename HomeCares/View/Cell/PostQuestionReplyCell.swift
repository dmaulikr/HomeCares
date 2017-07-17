//
//  PostQuestionReplyCell.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/11/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import Foundation
import UIKit
import Material

class PostQuestionReplyCell: UITableViewCell {
    
    // MARK: Property
    
    @IBOutlet weak var messageTextField: TextField!
    @IBOutlet weak var avatarImageView: UIImageView!
    internal weak var delegate: PostQuestionReplyCellDelegate?
    internal var question: Question!
    internal var indexPath: IndexPath!
    
    // MARK: Internal method
    
    internal func configure(question: Question, indexPath: IndexPath) {
        self.question = question
        self.indexPath = indexPath
        if let avatar =  UserDefaults.avatar, let url = URL(string: avatar) {
            avatarImageView.af_setImage(
                withURL         : url,
                placeholderImage: "ic_user_default".image,
                imageTransition : .crossDissolve(0.2),
                completion: { (response) in
                    if let _  = response.result.error {
                        self.avatarImageView.image = "ic_user_default".image
                    }
            })
        } else {
            avatarImageView.image = "ic_user_default".image
        }
    }
    
    // MARK: Action

    @IBAction func postQuestionAction(_ sender: UIButton) {
        if messageTextField.text!.isEmpty { return }
        let question = QuestionReply()
        question.created = "\(Date())"
        question.updated = "\(Date())"
        question.content = messageTextField.text!
        if let personId = UserDefaults.personId {
            question.personId = personId
        }
        question.questionReplyThanks = []
        question.questionId = self.question.questionId
         messageTextField.text = ""
        delegate?.didPostQuestionReply(question: question, indexPath: indexPath)
    }
}

protocol PostQuestionReplyCellDelegate: class {
    func didPostQuestionReply(question: QuestionReply, indexPath: IndexPath)
}
