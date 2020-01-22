import UIKit

class RootViewController: UIViewController {

    private let model = ["cell with button", "expand and check box", "cell with textField"]

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Root"
        view.addSubview(tableView)
    }
}

extension RootViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = model[indexPath.row]
        return cell
    }
}

extension RootViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var viewController: UIViewController?
        switch indexPath.row {
        case 0: viewController = CellWithButtonTableViewController()
        case 1: viewController = ExpandViewController()
        case 2: viewController = CellWithTextFieldTableViewController()
        default: break
        }
        if let viewController = viewController {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
