import UIKit

class ExpandViewController: UIViewController {
    
    private let viewModel = ExpandAndCheckBoxViewModel()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableView.register(TableViewCell_checkbox.self)
        tableView.register(ExpandHeader.self)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
    }
}

extension ExpandViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCountForRows(section: section)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getCountForSections()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewCell_checkbox = tableView.dequeueReusableCell(for: indexPath)
        let section = viewModel.models[indexPath.section]
        let row = section.rows[indexPath.row]
        cell.setupCell(model: row)
        return cell
    }
}

extension ExpandViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = TableViewCell_checkbox()
        cell.isChecked = viewModel.changeState(indexPath: indexPath)
        tableView.performBatchUpdates({
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }, completion: nil)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ExpandHeader") as? ExpandHeader else { return nil }
        let model = viewModel.models[section]
        header.setHeaderTitle(model.section,
                              delegate: self,
                              section: section,
                              isExpand: model.expand)
        return header
    }
}

extension ExpandViewController: ExpandHeaderDelegate {
    func didTapSection(header: ExpandHeader, section: Int) {
        viewModel.changeExpand(section: section)
        tableView.reloadSections([section], with: .automatic)
    }
}
