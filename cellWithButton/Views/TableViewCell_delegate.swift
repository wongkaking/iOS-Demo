import UIKit

protocol TableViewCellDelegate: class {
    func didTapButton(_ content: String)
}

class TableViewCell_delegate: UITableViewCell {

    lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.titleLabel?.textColor = .white
        return button
    }()

    weak var delegate: TableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        selectionStyle = .none
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
        selectionStyle = .none
    }

    func setupUI() {

        contentView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false

        button.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0).isActive = true
        button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0).isActive = true

        button.addTarget(self, action: #selector(tapButton(_:)), for: .touchUpInside)
    }

    func setupCell(content: String, delegate: TableViewCellDelegate) {
        button.setTitle("\(content)", for: .normal)
        self.delegate = delegate
    }

    @objc func tapButton(_ button: UIButton) {
        delegate?.didTapButton(button.titleLabel?.text ?? "")
    }
}
