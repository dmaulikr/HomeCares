//
//  QuestionAnswerViewController.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/4/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import UIKit

class QuestionAnswerViewController: UIViewController {
    
    // MARK: Property
    
    @IBOutlet weak var tableView: UITableView!
    internal var indexExpandable = 0
    internal var isExpanded = false
    internal var homeCareService = HomeCaresService()
    internal var questions = [Question]()
    internal var moreComment = [Int]()
    internal var expands = [Bool]()
    
    // MARK: Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getQuestions() 
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        getQuestions() 
    }
    
    // MARK: Internal method
    
    internal func prepareUI() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    internal func getQuestions() {
        tableView.startHeaderLoading()
        homeCareService.getQuestions { [weak self] (response) in
            guard let sSelf = self else { return }
            
            if let hasData = response.data {
                sSelf.questions = hasData
                sSelf.moreComment = hasData.map({_ in 0})
                sSelf.expands = hasData.map({_ in false})
            }
            sSelf.tableView.stopHeaderLoading()
            sSelf.tableView.reloadData()
        }
    }

}

// MARK: UITableViewDataSource implementation

extension QuestionAnswerViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return questions.count + 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 1 + moreComment[section - 1]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostQuestionCell", for: indexPath) as! PostQuestionCell
            cell.delegate = self
            cell.configure()
             return cell
        }
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath) as! QuestionCell
            cell.delegate = self
            cell.isExpand = expands[indexPath.section - 1]
            cell.configure(question: questions[indexPath.section - 1], indexPath: indexPath)
            return cell
        }
        if indexPath.row == moreComment[indexPath.section - 1] && questions[indexPath.section - 1].allowEveryOneAnswer {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostQuestionReplyCell", for: indexPath) as! PostQuestionReplyCell
            cell.delegate = self
            cell.configure(question: questions[indexPath.section - 1], indexPath: indexPath)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionReplyCell", for: indexPath) as! QuestionReplyCell
        cell.configure(question: questions[indexPath.section - 1].questionReplies[indexPath.row - 1], indexPath: indexPath)
        cell.delegate = self
        return cell
    }
}

// MARK: ServiceMenuCellDelegate implementation

extension QuestionAnswerViewController: UITableViewDelegate {
   
}

// MARK: QuestionCellDelegate implementation

extension QuestionAnswerViewController: QuestionCellDelegate {
    
    func didSelectedThank(question: QuestionThank, indexPath: IndexPath) {

        homeCareService.addQuestionThank(question: question) { [weak self] (response) in
            
            guard let sSelf = self else { return }
            
            if let hasData = response.data {
                sSelf.questions[indexPath.section - 1].questionThanks.append(hasData)
            }
            sSelf.tableView.reloadData()
        }
    }
    
    func didUnselectThank(question: QuestionThank, indexPath: IndexPath) {
        homeCareService.deleteQuestionThank(question: question, handler: { [weak self] (response) in
            guard let sSelf = self else { return }
        
            if let hasData = response.data {
                if let indexQuestionThank = sSelf.questions[indexPath.section - 1].questionThanks.index(where: { $0.questionThankId == hasData.questionThankId }) {
                    sSelf.questions[indexPath.section - 1].questionThanks.remove(at: indexQuestionThank)
                }
            }
            sSelf.tableView.reloadData()
        })
    }
    
    func didSeeMoreComment(question: Question, indexPath: IndexPath) {
        
        expands[indexPath.section - 1] = !expands[indexPath.section - 1]
        
        if expands[indexPath.section - 1] {
            if question.allowEveryOneAnswer {
                moreComment[indexPath.section - 1] = question.questionReplies.count + 1
            } else {
                moreComment[indexPath.section - 1] = question.questionReplies.count
            }
        } else {
            moreComment[indexPath.section - 1] = 0
        }
        tableView.reloadSections(IndexSet(indexPath), with: .none)

        let indexScroll = IndexPath(row: moreComment[indexPath.section - 1], section: indexPath.section)
        
        tableView.scrollToRow(at: indexScroll, at: .bottom, animated: true)
    }
}

// MARK: PostQuestionCellDelegate implementation

extension QuestionAnswerViewController: PostQuestionCellDelegate {
    
    func didSelectPostQuestion(question: Question) {
        homeCareService.postQuestion(question: question) { [weak self] (response) in
            guard let sSelf = self else {return}
            
            if let hasData = response.data {
                sSelf.questions.insert(hasData, at: 0)
                sSelf.moreComment.insert(0, at: 0)
                sSelf.expands.insert(false, at: 0)
            }
            sSelf.tableView.reloadData()
        }
    }
}

extension QuestionAnswerViewController: PostQuestionReplyCellDelegate {
    
    func didPostQuestionReply(question: QuestionReply, indexPath: IndexPath) {
        homeCareService.postReplyQuestion(question: question) {[weak self] (response) in
            guard let sSelf = self else {return}
            
            if let hasData = response.data {
                sSelf.questions[indexPath.section - 1].questionReplies.insert(hasData, at: sSelf.questions[indexPath.section - 1].questionReplies.count)
                sSelf.moreComment[indexPath.section - 1] =  sSelf.moreComment[indexPath.section - 1] + 1
            }
            sSelf.tableView.reloadData()
        }
    }
    
    func didPostEditQuestionReply(question: QuestionReply, indexPath: IndexPath) {
        homeCareService.updateReplyQuestion(question: question) {[weak self] (response) in
            guard let sSelf = self else {return}
            
            if let hasData = response.data {
                sSelf.questions[indexPath.section - 1].questionReplies.insert(hasData, at: sSelf.questions[indexPath.section - 1].questionReplies.count)
                sSelf.moreComment[indexPath.section - 1] =  sSelf.moreComment[indexPath.section - 1] + 1
            }
            sSelf.tableView.reloadData()
        }
    }
}

extension QuestionAnswerViewController: QuestionReplyCellDelegate {
    
    func didEditReplyQuestion(question: QuestionReply, indexPath: IndexPath) {
        questions[indexPath.section - 1].questionReplies.remove(at: indexPath.row - 1)
        moreComment[indexPath.section - 1] =  moreComment[indexPath.section - 1] - 1
        tableView.reloadData()
        let newIndexPath = IndexPath(row: moreComment[indexPath.section - 1], section: indexPath.section)
        if let cell = tableView.cellForRow(at: newIndexPath) as? PostQuestionReplyCell {
            cell.messageTextField.text = question.content
            cell.isEditQuestion = true
            cell.questionEdit = question
        }
        
    }
    
    func didUnthankReplyQuestion(question: QuestionReplyThank, indexPath: IndexPath) {
        homeCareService.deleteQuestionReplyThank(question: question) { [weak self] (response) in
            guard let sSelf = self else {return }
            
            if let hasData = response.data {
                if let indexQuestionReplyThank = sSelf.questions[indexPath.section - 1].questionReplies[indexPath.row - 1].questionReplyThanks.index(where: {$0.questionReplyThankId == hasData.questionReplyThankId}) {
                    sSelf.questions[indexPath.section - 1].questionReplies[indexPath.row - 1].questionReplyThanks.remove(at: indexQuestionReplyThank)
                }
            }
            sSelf.tableView.reloadData()
        }
    }
    
    func didThankReplyQuestion(question: QuestionReplyThank, indexPath: IndexPath) {
        homeCareService.addQuestionReplyThank(question: question) { [weak self] (response) in
            guard let sSelf = self else {return}
            
            if let hasData = response.data {
                sSelf.questions[indexPath.section - 1].questionReplies[indexPath.row - 1].questionReplyThanks.append(hasData)
            }
            sSelf.tableView.reloadData()
        }
    }
}


