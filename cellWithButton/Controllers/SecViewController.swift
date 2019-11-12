import UIKit

class SecViewController: UIViewController {
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Second"
        view.backgroundColor = .gray

        setupUI()
    }

    func setupUI() {
        view.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

}
