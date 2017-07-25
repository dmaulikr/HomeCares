//
//  UITableView+Extension.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/4/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import Foundation
import SpringIndicator

extension UITableView {
    
    public func clearSeparator() {
        tableFooterView = UIView()
    }
}

import UIKit
import SpringIndicator

extension UITableView {
    
    public var springIndicator: SpringIndicator {
        let springIndicator = SpringIndicator(frame: CGRect(x: 0, y: 0, width: 20.0, height: 20.0))
        springIndicator.setupDefault()
        return springIndicator
    }
    
    
    public func updateIndicatorFrame() {
        if let headerView = tableHeaderView,
            let springIndicator = headerView.subviews.first as? SpringIndicator {
            
            headerView.frame = CGRect(x: 0, y: 0, width: frame.width, height: 60.0)
            springIndicator.center = headerView.center
        }
        if let footerView = tableFooterView,
            let springIndicator = footerView.subviews.first as? SpringIndicator {
            
            footerView.frame = CGRect(x: 0, y: 0, width: frame.width, height: 60.0)
            springIndicator.center = footerView.center
        }
    }
    
    public func startHeaderLoading() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60.0))
        let springIndicator = self.springIndicator
        springIndicator.startAnimation()
        springIndicator.center = headerView.center
        headerView.addSubview(springIndicator)
        tableHeaderView = headerView
    }
    
    public func stopHeaderLoading(isAwaiting: Bool = true) {
        if let springIndicator = tableHeaderView?.subviews.first as? SpringIndicator {
            springIndicator.stopAnimation(isAwaiting) { [weak self] _ in
                guard let sSelf = self else { return }
                UIView.animate(withDuration: 0.5, animations: {
                    sSelf.tableHeaderView = nil
                }, completion: nil)
            }
        }
    }
    
    public func startFooterLoading() {
        tableFooterView?.isHidden = false
        if let springIndicator = tableFooterView?.subviews.first as? SpringIndicator {
            springIndicator.startAnimation()
        } else {
            let footerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60.0))
            let springIndicator = self.springIndicator
            springIndicator.center = footerView.center
            springIndicator.startAnimation()
            footerView.addSubview(springIndicator)
            
            tableFooterView = footerView
        }
    }
    
    public func stopFooterLoading(isAwaiting: Bool = true) {
        if let springIndicator = tableFooterView?.subviews.first as? SpringIndicator {
            springIndicator.stopAnimation(isAwaiting) {  [weak self] _ in
                guard let sSelf = self else { return }
                
                sSelf.tableFooterView?.isHidden = true
            }
        }
    }
}

extension SpringIndicator {
    
    public func setupDefault() {
        var colorIndex = 0
        
        lineColor = UIColor.refresh[colorIndex]
        lineWidth = 2
        rotateDuration = 1
        strokeDuration = 0.5
        intervalAnimationsHandler = { [weak self] (indicator) in
            guard let _ = self else { return }
            
            colorIndex += 1
            if colorIndex >= UIColor.refresh.count {
                colorIndex = 0
            }
            indicator.lineColor = UIColor.refresh[colorIndex]
        }
    }
    
}


