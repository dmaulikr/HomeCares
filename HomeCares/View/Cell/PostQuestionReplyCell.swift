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
    internal var isEditQuestion = false
    internal var questionEdit: QuestionReply!
    
    // MARK: Internal method
    
    internal func configure(question: Question, indexPath: IndexPath) {
       
        self.question = question
        self.indexPath = indexPath
        messageTextField.text = ""
        isEditQuestion = false
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
    
        if isEditQuestion {
            questionEdit.content = messageTextField.text!
            questionEdit.updated = "\(Date())"
            delegate?.didPostEditQuestionReply(question: questionEdit, indexPath: indexPath)
            print("Post edit q")
        } else {
            let question = QuestionReply()
            question.updated = "\(Date())"
            question.content = messageTextField.text!
            if let personId = UserDefaults.personId {
                question.personId = personId
            }
            question.questionReplyThanks = []
            question.questionId = self.question.questionId
            question.created = "\(Date())"
            delegate?.didPostQuestionReply(question: question, indexPath: indexPath)
            print("Post reply q")
        }
        messageTextField.text = ""
    }
}

protocol PostQuestionReplyCellDelegate: class {
    func didPostQuestionReply(question: QuestionReply, indexPath: IndexPath)
    func didPostEditQuestionReply(question: QuestionReply, indexPath: IndexPath)
}
