import Foundation

final class CheckBoxRow {
    let text: String
    var isChecked: Bool

    init(text: String, isChecked: Bool) {
        self.text = text
        self.isChecked = isChecked
    }
}

final class CheckBoxSection {
    var expand: Bool
    let section: String
    let rows: [CheckBoxRow]

    init(expand: Bool, section: String, rows: [CheckBoxRow]) {
        self.expand = expand
        self.section = section
        self.rows = rows
    }
}
