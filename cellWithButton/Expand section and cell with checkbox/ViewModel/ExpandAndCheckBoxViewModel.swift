import Foundation
import UIKit

protocol ExpandAndCheckBoxViewModelDelegate: class {
    func reloadTableViewSection(_ section: Int)
}

public class ExpandAndCheckBoxViewModel: NSObject, UITableViewDataSource, UITableViewDelegate {

    weak var delegate: ExpandAndCheckBoxViewModelDelegate?

    let models: [CheckBoxSection] = [CheckBoxSection(expand: true, section: "iPhone",
                                                     rows: [CheckBoxRow(text: "iPhone 11", isChecked: false),
                                                            CheckBoxRow(text: "iPhone 11 Max", isChecked: false),
                                                            CheckBoxRow(text: "iPhone 11 Max Pro", isChecked: false),
                                                            CheckBoxRow(text: "iPhone X Max Pro", isChecked: false)]),
                                     CheckBoxSection(expand: true, section: "Mac",
                                                     rows: [CheckBoxRow(text: "MacBook Air", isChecked: false),
                                                            CheckBoxRow(text: "MacBook", isChecked: false),
                                                            CheckBoxRow(text: "MacBook Pro", isChecked: false)])]

    init(delegate: ExpandAndCheckBoxViewModelDelegate) {
        super.init()
        self.delegate = delegate
    }
    
    func changeState(indexPath: IndexPath) -> Bool {
        let model = models[indexPath.section]
        let row = model.rows[indexPath.row]
        row.isChecked = !row.isChecked
        return row.isChecked
    }
    
    func changeExpand(section: Int) {
        models[section].expand = !models[section].expand
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewCell_checkbox = tableView.dequeueReusableCell(for: indexPath)
        let section = models[indexPath.section]
        let row = section.rows[indexPath.row]
        cell.setupCell(model: row)
        return cell
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].expand ? models[section].rows.count : 0
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ExpandHeader") as? ExpandHeader else { return nil }
        let model = models[section]
        header.setHeaderTitle(model.section,
                              delegate: self,
                              section: section,
                              isExpand: model.expand)
        return header
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = TableViewCell_checkbox()
        cell.isChecked = changeState(indexPath: indexPath)
        tableView.performBatchUpdates({
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }, completion: nil)
    }
}

extension ExpandAndCheckBoxViewModel: ExpandHeaderDelegate {
    func didTapSection(header: ExpandHeader, section: Int) {
        changeExpand(section: section)
        delegate?.reloadTableViewSection(section)
    }
}
