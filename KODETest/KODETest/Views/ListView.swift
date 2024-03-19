import UIKit

class ListView: UIView {
    
    @UseAutolayout var tableView = UITableView(frame: .zero, style: .plain)
    @UseAutolayout var scopeBar = ScopeBar()
    @UseAutolayout private var lineView: UIView = .style {
        $0.backgroundColor = Constants.colors.lightGrey
    }
    @UseAutolayout var errorView = ErrorView()
    let refreshControl = UIRefreshControl()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        backgroundColor = Constants.colors.white
        addSubview(tableView)
        addSubview(scopeBar)
        addSubview(lineView)
        addSubview(errorView)
        tableView.refreshControl = refreshControl
        errorView.isHidden = true
        
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        tableView.backgroundView = EmptySearchView()
        tableView.sectionHeaderTopPadding = Constants.layout.sectionHeaderTopPadding

        NSLayoutConstraint.activate([
            scopeBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.layout.scopeBarTop),
            scopeBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scopeBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scopeBar.heightAnchor.constraint(equalToConstant: Constants.layout.scopeBarHeight),
            
            lineView.bottomAnchor.constraint(equalTo: scopeBar.bottomAnchor),
            lineView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: Constants.layout.lineViewHeihgt),
            
            tableView.topAnchor.constraint(equalTo: lineView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            errorView.topAnchor.constraint(equalTo: topAnchor),
            errorView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
