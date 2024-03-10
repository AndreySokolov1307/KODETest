//
//  ListView.swift
//  KODETest
//
//  Created by Андрей Соколов on 09.03.2024.
//

import UIKit

class ListView: UIView {
    
    @UseAutolayout var tableView = UITableView(frame: .zero, style: .plain)
    @UseAutolayout var scopeBar = ScopeBar()
    @UseAutolayout private var lineView: UIView = .style {
        $0.backgroundColor = Constants.colors.lightGrey
    }
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        backgroundColor = .systemGray6
        addSubview(tableView)
        addSubview(scopeBar)
        addSubview(lineView)
        tableView.backgroundColor = .systemCyan
        
        NSLayoutConstraint.activate([
            
            scopeBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.layout.scopeBarTop),
            scopeBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            scopeBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            scopeBar.heightAnchor.constraint(equalToConstant: Constants.layout.scopeBarHeight),
            
            lineView.bottomAnchor.constraint(equalTo: scopeBar.bottomAnchor),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: Constants.layout.lineViewHeihgt),
            
            tableView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: Constants.layout.tableViewTop),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
