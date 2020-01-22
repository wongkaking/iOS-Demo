import UIKit
import SnapKit

protocol TableViewCell_textFieldDelegate: class {
    func tableViewCell(_ cell: TableViewCell_textField, inputTextFieldDidChange index: Int, text: String?)
}

class TableViewCell_textField: UITableViewCell {

    weak var delegate: TableViewCell_textFieldDelegate?
    private var index = 0

    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.delegate = self
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        return textField
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        selectionStyle = .none
        contentView.addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
    }

    func setup(index: Int, model: ArrayModel, delegate: TableViewCell_textFieldDelegate) {
        self.index = index
        textField.text = model.text
        self.delegate = delegate
    }
}

extension TableViewCell_textField: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        delegate?.tableViewCell(self, inputTextFieldDidChange: index, text: textField.text)
    }
}
