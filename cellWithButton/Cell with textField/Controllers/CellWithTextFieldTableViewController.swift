import UIKit

class CellWithTextFieldTableViewController: UITableViewController {

    private let count = 100
    private var array = [ArrayModel(index: 0, text: nil),
                         ArrayModel(index: 1, text: nil),
                         ArrayModel(index: 2, text: nil),
                         ArrayModel(index: 3, text: nil),
                         ArrayModel(index: 4, text: nil),
                         ArrayModel(index: 5, text: nil),
                         ArrayModel(index: 6, text: nil),
                         ArrayModel(index: 7, text: nil),
                         ArrayModel(index: 8, text: nil),
                         ArrayModel(index: 9, text: nil),
                         ArrayModel(index: 10, text: nil),
                         ArrayModel(index: 11, text: nil),
                         ArrayModel(index: 12, text: nil),
                         ArrayModel(index: 13, text: nil)]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        navigationItem.title = "CellWithTextField"
    }

    private func setupTableView() {
        tableView.register(TableViewCell_textField.self)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewCell_textField = tableView.dequeueReusableCell(for: indexPath)
        cell.setup(index: indexPath.row, model: array[indexPath.row], delegate: self)
        return cell
    }
}

extension CellWithTextFieldTableViewController: TableViewCell_textFieldDelegate {
    func tableViewCell(_ cell: TableViewCell_textField, inputTextFieldDidChange index: Int, text: String?) {
        guard let text = text else { return }
        if array.count > index {
            array[index].text = text
        }
    }
}

struct ArrayModel {
    var index: Int
    var text: String?
}
