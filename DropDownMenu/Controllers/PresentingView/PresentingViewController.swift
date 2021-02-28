import UIKit

public class PresentingViewController: BaseViewController {

    public func show(view: UIView) {
        let vc = PopoverViewController(nib: R.nib.popoverViewController)
        vc.preferredContentSize = CGSize(width: UIScreen.main.bounds.width - 40, height: 245)
        vc.modalPresentationStyle = .popover
        vc.popoverPresentationController?.delegate = vc
        vc.popoverPresentationController?.permittedArrowDirections = .init()
        vc.popoverPresentationController?.sourceView = view
        vc.popoverPresentationController?.sourceRect = view.bounds
        present(vc, animated: true)
    }
}
