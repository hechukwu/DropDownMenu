import UIKit

class PopoverViewController: BaseViewController, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!

    public var presentationStyle: PresentationalStyleModel?
    public var dataSource = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        registerNib()
    }

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        switch presentationStyle {
        case .none?: return .none
        case .automatic: return .automatic
        case .currentContext: return .currentContext
        case .custom: return .custom
        case .formSheet: return .formSheet
        case .fullScreen: return .fullScreen
        case .overCurrentContext: return .overCurrentContext
        case .overFullScreen: return .overFullScreen
        case .pageSheet: return .pageSheet
        case .popover: return .popover
        default: return .none
        }
    }

    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        popoverPresentationController.containerView?.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: false, completion: nil)
    }
    
    private func registerNib() {
        tableView.register(UINib(nibName: R.nib.popoverCell.name, bundle: nil), forCellReuseIdentifier: R.reuseIdentifier.popoverCell.identifier)
    }

}

extension PopoverViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.popoverCell.identifier) as? PopoverCell else { return UITableViewCell() }
        let dataItem = dataSource[indexPath.row]
        cell.configureCell(with: dataItem)
        return cell
    }
}
