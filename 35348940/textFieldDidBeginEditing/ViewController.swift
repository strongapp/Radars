import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textA: UITextField!
    @IBOutlet weak var textB: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        textA.delegate = self
        textB.delegate = self
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.selectAll(self)

        // Potential workaround. This has performance issues when used in a complex view.
        /*
        DispatchQueue.main.async {
            textField.selectAll(self)
        }
         */
    }
}
