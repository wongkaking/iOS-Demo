import UIKit
import SnapKit

class TableViewCell_checkbox: UITableViewCell {

    private let checkBoxWidth: CGFloat = 20.0

    private let topicLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    let checkBoxButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "lightCheckboxOff"), for: .normal)
        button.setImage(UIImage(named: "lightCheckboxOn"), for: .selected)
        button.isUserInteractionEnabled = false
        return button
    }()

    public var isChecked: Bool = false {
        didSet {
            checkBoxButton.isSelected = isChecked
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        [topicLabel, checkBoxButton].forEach {
            contentView.addSubview($0)
        }

        checkBoxButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(checkBoxWidth)
            make.leading.equalToSuperview().inset(24)
            make.centerY.equalToSuperview()
        }

        topicLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(checkBoxButton.snp.trailing).offset(8)
            make.trailing.greaterThanOrEqualToSuperview().inset(24)
            make.centerY.equalTo(checkBoxButton)
        }
    }

    private func updateTextColor() {
        topicLabel.textColor = checkBoxButton.isSelected ? .selectedColor : .black
    }

    func setupCell(model: CheckBoxRow) {
        topicLabel.text = model.text
        checkBoxButton.isSelected = model.isChecked
        updateTextColor()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        topicLabel.text = nil
        checkBoxButton.setImage(UIImage(named: "lightCheckboxOff"), for: .normal)
        checkBoxButton.setImage(UIImage(named: "lightCheckboxOn"), for: .selected)
    }
}
