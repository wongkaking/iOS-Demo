import UIKit

class ExpandViewController: UIViewController {

    let models: [CheckBoxSection] = [CheckBoxSection(expand: true, section: "iPhone", rows: [CheckBoxRow(text: "iPhone 11", isChecked: false),
                                                                                             CheckBoxRow(text: "iPhone 11 Max", isChecked: false),
                                                                                             CheckBoxRow(text: "iPhone 11 Max Pro", isChecked: false),
                                                                                             CheckBoxRow(text: "iPhone X Max Pro", isChecked: false)]),
                                     CheckBoxSection(expand: true, section: "Mac", rows: [CheckBoxRow(text: "MacBook Air", isChecked: false),
                                                     CheckBoxRow(text: "MacBook", isChecked: false),
                                                     CheckBoxRow(text: "MacBook Pro", isChecked: false)])]


    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableView.register(TableViewCell_checkbox.self, forCellReuseIdentifier: "TableViewCell_checkbox")
        tableView.register(ExpandHeader.self, forHeaderFooterViewReuseIdentifier: "ExpandHeader")
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
        return models[section].expand ? models[section].rows.count : 0
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell_checkbox", for: indexPath) as? TableViewCell_checkbox else { return UITableViewCell() }
        let section = models[indexPath.section]
        let row = section.rows[indexPath.row]
        cell.setupCell(model: row)
        return cell
    }
}

extension ExpandViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = TableViewCell_checkbox()
        let model = models[indexPath.section]
        let row = model.rows[indexPath.row]
        row.isChecked = !row.isChecked
        cell.isChecked = row.isChecked
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
        let model = models[section]
        header.setHeaderTitle(model.section)
        header.section = section
        header.delegate = self
        header.isExpand = model.expand
        return header
    }
}

extension ExpandViewController: ExpandHeaderDelegate {
    func didTapSection(header: ExpandHeader, section: Int) {
        models[section].expand = !models[section].expand
        tableView.reloadSections([section], with: .automatic)
    }
}
