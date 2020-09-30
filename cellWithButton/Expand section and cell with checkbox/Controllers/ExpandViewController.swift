import UIKit

class ExpandViewController: UIViewController {
    
    private lazy var viewModel = ExpandAndCheckBoxViewModel(delegate: self)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableView.register(TableViewCell_checkbox.self)
        tableView.register(ExpandHeader.self)
        tableView.tableFooterView = UIView()
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
    }
}

extension ExpandViewController: ExpandAndCheckBoxViewModelDelegate {
    func reloadTableViewSection(_ section: Int) {
        tableView.reloadSections([section], with: .automatic)
    }
}
