import Foundation

class ExpandAndCheckBoxViewModel {
    
    let models: [CheckBoxSection] = [CheckBoxSection(expand: true, section: "iPhone",
                                                     rows: [CheckBoxRow(text: "iPhone 11", isChecked: false),
                                                            CheckBoxRow(text: "iPhone 11 Max", isChecked: false),
                                                            CheckBoxRow(text: "iPhone 11 Max Pro", isChecked: false),
                                                            CheckBoxRow(text: "iPhone X Max Pro", isChecked: false)]),
                                     CheckBoxSection(expand: true, section: "Mac",
                                                     rows: [CheckBoxRow(text: "MacBook Air", isChecked: false),
                                                            CheckBoxRow(text: "MacBook", isChecked: false),
                                                            CheckBoxRow(text: "MacBook Pro", isChecked: false)])]
    
    func changeState(indexPath: IndexPath) -> Bool {
        let model = models[indexPath.section]
        let row = model.rows[indexPath.row]
        return !row.isChecked
    }
}
