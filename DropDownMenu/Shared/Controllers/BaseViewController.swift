import UIKit
import SafariServices

public class BaseViewController: UIViewController {

    var hideNavigationBarOnAppear = false

    public private(set) var isViewVisible = false

    // MARK: Public Instance Methods

    public func bindViewModel() {
    }

    // MARK: Overridden UIViewController Methods

    public override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        bindViewModel()
    }

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if !isViewVisible {
            isViewVisible = true
        }
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //
        // Force view to load before mucking with any subviews:
        //
        if #available(iOS 9.0, *) {
            loadViewIfNeeded()
        } else {
            guard
                view != nil
                else { return }
        }
        navigationController?.navigationBar.isHidden = hideNavigationBarOnAppear
    }

    override public func viewWillDisappear(_ animated: Bool) {
        if isViewVisible {
            isViewVisible = false
        }

        super.viewWillDisappear(animated)
    }
    
    fileprivate func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showAlertDialog(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func showAlertDialogAndDismiss(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.cancel,handler: {_ in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }

    func openUrl(url: String) {
        if let url = URL(string: url) {
            if #available(iOS 11.0, *) {
                let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = true

                let vc = SFSafariViewController(url: url, configuration: config)
                present(vc, animated: true)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}
