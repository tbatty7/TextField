import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet private(set) var userNameField: UITextField!
    @IBOutlet private(set) var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    deinit {
        print("deinit View Controller")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField === userNameField {
            return !string.contains(" ")
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === userNameField {
            passwordField.becomeFirstResponder()
        }
        else {
            guard let username = userNameField.text,
                  let password = passwordField.text else {
                      return false
                  }
            passwordField.resignFirstResponder()
            performLogin(username: username, password: password)
        }
        
        return false
    }

    private func performLogin(username: String, password: String) {
        print("Username: \(username)  Password: \(password)")
    }
}

