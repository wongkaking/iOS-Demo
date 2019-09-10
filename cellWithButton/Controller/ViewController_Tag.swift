import UIKit

class ViewController_Tag: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView(frame: UIScreen.main.bounds)
    var contentArray = ["Tag_1", "Tag_2", "Tag_3", "Tag_4", "Tag_5"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.register(TableViewCell_tag.self, forCellReuseIdentifier: "TableViewCell_tag")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        navigationItem.title = "Tag"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell_tag", for: indexPath) as? TableViewCell_tag else { return UITableViewCell() }
        cell.setupCell(self.contentArray[indexPath.row])
        cell.button.tag = indexPath.row
        cell.button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc func didTapButton(_ button: UIButton){
        let row = button.tag
        let vc = SecViewController()
        vc.textLabel.text = contentArray[row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
