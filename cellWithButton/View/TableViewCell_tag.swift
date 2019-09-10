import UIKit

class TableViewCell_tag: UITableViewCell {

    lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.titleLabel?.textColor = .white
        return button
    }()
    
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
        
        button.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0).isActive = true
        button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0).isActive = true
    }
    
    func setupCell(_ content: String) {
        button.setTitle("\(content)", for: .normal)
    }

}
