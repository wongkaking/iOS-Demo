import UIKit

class ExpandViewController: UIViewController {

    let models: [CheckBoxModel] = [CheckBoxModel(text: "iPhone 11", isChecked: false),
                                   CheckBoxModel(text: "iPhone 11 Max", isChecked: false),
                                   CheckBoxModel(text: "iPhone 11 Max Pro", isChecked: false),
                                   CheckBoxModel(text: "iPhone X Max Pro", isChecked: false)]

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableView.register(TableViewCell_checkbox.self, forCellReuseIdentifier: "TableViewCell_checkbox")
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
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell_checkbox", for: indexPath) as? TableViewCell_checkbox else { return UITableViewCell() }
        cell.setupCell(model: models[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension ExpandViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = TableViewCell_checkbox()
        let row = models[indexPath.row]
        row.isChecked = !row.isChecked
        cell.isChecked = row.isChecked
        tableView.performBatchUpdates({
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }, completion: nil)
    }
}
