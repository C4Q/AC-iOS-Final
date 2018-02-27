//
//  MainFeedView.swift
//  AC-iOS-Final
//
//  Created by Richard Crichlow on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import SnapKit

class MainFeedView: UIView {

    lazy var tableView: UITableView = {
        let tv = UITableView()
        //create and register a cell
        tv.register(CustomTableViewCell.self, forCellReuseIdentifier: "PostCell")
        tv.backgroundColor = .clear
        tv.isHidden = false
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = UIColor(red: 0.298, green: 0.278, blue: 0.247, alpha: 1.00)
        setupViews()
    }
    
    private func setupViews() {
        
        self.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.safeAreaLayoutGuide.snp.edges)
        }
    }

}
