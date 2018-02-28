//
//  FeedView.swift
//  AC-iOS-Final
//
//  Created by Masai Young on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import SnapKit

final class FeedView: UIView {
    
    lazy var tableView: UITableView = {
       let tv = UITableView()
        tv.register(FeedCell.self, forCellReuseIdentifier: "FeedCell")
        tv.separatorStyle = .none
        tv.estimatedRowHeight = 100
        tv.rowHeight = UITableViewAutomaticDimension
        tv.backgroundColor = .white
        tv.allowsSelection = false
        tv.layoutEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return tv
    }()
    
    //Required Initializers
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setViews()
    }
    
    //Constraining Objects using SnapKit
    func setViews(){
        prepareTableView()
    }
    
    private func prepareTableView() {
        addSubview(tableView)
        tableView.snp.makeConstraints{ make in
            make.top.equalTo(snp.top)
            make.left.equalTo(snp.left)
            make.right.equalTo(snp.right)
            make.bottom.equalTo(self.snp.bottomMargin)
        }
    }
}
