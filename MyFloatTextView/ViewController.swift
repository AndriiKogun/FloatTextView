//
//  ViewController.swift
//  MyFloatTextView
//
//  Created by Andrii on 2/1/18.
//  Copyright © 2018 Andrii. All rights reserved.
//

import UIKit

let key = Notification.Name("Keeeeeeeeeeey")

class ViewController: UIViewController {
    
    var headerView: UIView!
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView()
        tableView.frame = self.view.bounds
        
        view.addSubview(tableView)
        
        headerView = UINib(nibName: "HeaderView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! HeaderView
        
        NotificationCenter.default.addObserver(self, selector: #selector(sizeHeaderToFit), name: key, object: nil)
        
        tableView.tableHeaderView = headerView
//        tableView.tableHeaderView?.addSubview(headerView)
//
//        headerView.translatesAutoresizingMaskIntoConstraints = false
//        headerView.topAnchor.constraint(equalTo: (tableView.tableHeaderView?.topAnchor)!).isActive = true
//        headerView.leftAnchor.constraint(equalTo: (tableView.tableHeaderView?.leftAnchor)!).isActive = true
//        headerView.bottomAnchor.constraint(equalTo: (tableView.tableHeaderView?.bottomAnchor)!).isActive = true
//        headerView.rightAnchor.constraint(equalTo: (tableView.tableHeaderView?.rightAnchor)!).isActive = true
    }
    
    @objc private func sizeHeaderToFit() {
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        
        let height = headerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        var frame = headerView.frame
        frame.size.height = height
        headerView.frame = frame
        tableView.tableHeaderView = headerView
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sizeHeaderToFit()
//        updateTableViewHeaderViewHeight();
    }
    
    func resetTableViewHeaderView() {
     
        UIView.beginAnimations("tableHeaderView", context: nil)
        tableView.tableHeaderView = tableView.tableHeaderView;

        UIView.commitAnimations()
    }
    
    
     @objc func updateTableViewHeaderViewHeight()  {
        
        var frame = tableView.tableHeaderView?.frame
        frame?.size.height = headerView.frame.size.height
        tableView.tableHeaderView?.frame = frame!
        
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.resetTableViewHeaderView()
        }
    }
    
    
    
}

