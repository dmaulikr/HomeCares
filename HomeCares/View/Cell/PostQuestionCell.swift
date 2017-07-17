//
//  PostQuestionCell.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/10/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import UIKit
import Material

class PostQuestionCell: UITableViewCell {

   // MARK: Property
    
    @IBOutlet weak var messageTextField: TextField!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var allowButton: UIButton!
    
    internal weak var delegate: PostQuestionCellDelegate?
    
    // MARK: Internal method
    
    internal func configure() {
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
    
    @IBAction func postQuestionAction(_ sender: Any) {
        if messageTextField.text!.isEmpty { return }
        let question = Question()
        question.created = "\(Date())"
        question.updated = "\(Date())"
        question.content = messageTextField.text!
        question.allowEveryOneAnswer = allowButton.isSelected
        if let personId = UserDefaults.personId {
            question.personId = personId
        }
        question.questionReplies = []
        question.questionThanks = []
        messageTextField.text = ""
        delegate?.didSelectPostQuestion(question: question)
    }
    
    @IBAction func allowReplyAction(_ sender: Any) {
        allowButton.isSelected = !allowButton.isSelected
    }
    
    
    

}

protocol  PostQuestionCellDelegate: class {
    func didSelectPostQuestion(question: Question)
}
