import UIKit

class ViewController_Delegate: UIViewController, UITableViewDataSource, UITableViewDelegate, TableViewCellDelegate {

    let tableView = UITableView(frame: UIScreen.main.bounds)
    var contentArray = ["Delegate_1", "Delegate_2", "Delegate_3", "Delegate_4", "Delegate_5"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.register(TableViewCell_delegate.self, forCellReuseIdentifier: "TableViewCell_delegate")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        navigationItem.title = "Delegate"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell_delegate", for: indexPath) as? TableViewCell_delegate else { return UITableViewCell() }
        cell.setupCell(content: contentArray[indexPath.row], delegate: self)
        return cell
    }

    func didTapButton(_ content: String) {
        let vc = SecViewController()
        vc.textLabel.text = "\(content)"
        navigationController?.pushViewController(vc, animated: true)
    }
}

