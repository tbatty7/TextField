@testable import TextField
import XCTest

final class ViewControllerTests: XCTestCase {
    
    func test_outlets_shouldBeConnected() throws {
        let viewController: ViewController = setUpViewController()
        
        XCTAssertNotNil(viewController.userNameField, "username field")
        XCTAssertNotNil(viewController.passwordField, "password field")
        XCTAssertEqual(String(describing: ViewController.self), "ViewController")
    }
    
    func test_usernameField_attributesShouldBeSet() {
        let viewController: ViewController = setUpViewController()
        
        let textField = viewController.userNameField!
        
        XCTAssertEqual(textField.textContentType, .username, "text field content type")
        XCTAssertEqual(textField.autocorrectionType, .no, "text field autocorrection type")
        XCTAssertEqual(textField.returnKeyType, .next, "text field return key type")
    }
    
    func test_passwordField_attributesShouldBeSet() {
        let viewController: ViewController = setUpViewController()
        
        let textField = viewController.passwordField!
        
        XCTAssertEqual(textField.textContentType, .password, "text field content type")
        XCTAssertEqual(textField.returnKeyType, .go, "text field return key type")
        XCTAssertTrue(textField.isSecureTextEntry, "text field isSecureTextEntry")
    }
    
    func test_textFieldDelegates_shouldBeConnected() {
        let viewController = setUpViewController()
        
        XCTAssertNotNil(viewController.userNameField.delegate, "username Field")
        XCTAssertNotNil(viewController.passwordField.delegate, "password Field")
    }
    
    func test_shouldChangeCharacters_usernameWithSpaces_shouldPreventChange() {
        let viewController = setUpViewController()
        let allowChange = shouldChangeCharacters(in: viewController.userNameField, replacement: "a b")
        
        XCTAssertEqual(allowChange, false)
    }
    
    func test_shouldChangeCharacters_usernameWithoutSpaces_shouldAllowChange() {
        let viewController = setUpViewController()
        let allowChange = shouldChangeCharacters(in: viewController.userNameField, replacement: "abc")
        
        XCTAssertEqual(allowChange, true)
    }
    
    func test_shouldChangeCharacters_passwordWithSpaces_shouldAllowChange() {
        let viewController = setUpViewController()
        let allowChange = shouldChangeCharacters(in: viewController.passwordField, replacement: "a b")
        
        XCTAssertEqual(allowChange, true)
    }
    
    func test_shouldChangeCharacters_passwordWithoutSpaces_shouldAllowChange() {
        let viewController = setUpViewController()
        let allowChange = shouldChangeCharacters(in: viewController.passwordField, replacement: "abc")
        
        XCTAssertEqual(allowChange, true)
    }
        
    func test_shouldReturn_withPassword_shouldPerformLogin() {
        let viewController = setUpViewController()
        viewController.userNameField.text = "username"
        viewController.passwordField.text = "password"
        
        shouldReturn(in: viewController.passwordField)
        
        #warning("We could use a spy to test this if we wanted to")
    }
    
    func test_shouldReturn_WithUsername_shouldMoveInputFocusToPassword() {
        let viewController = setUpViewController()
        putInViewHeirarchy(viewController)
        
        shouldReturn(in: viewController.userNameField)
        
        XCTAssertTrue(viewController.passwordField.isFirstResponder)
    }
    
    func test_shouldReturn_withPassword_shouldDismissKeyboard() {
        let viewController = setUpViewController()
        putInViewHeirarchy(viewController)
        viewController.passwordField.becomeFirstResponder()
        XCTAssertTrue(viewController.passwordField.isFirstResponder, "precondition")
        
        shouldReturn(in: viewController.passwordField)
        
        XCTAssertFalse(viewController.passwordField.isFirstResponder)
    }
    
    private func setUpViewController() -> ViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController: ViewController = storyboard.instantiateViewController(identifier: String(describing: ViewController.self))
        viewController.loadViewIfNeeded()
        
        return viewController
    }
    
    private func shouldChangeCharacters(in textfield: UITextField, range: NSRange = NSRange(), replacement: String) -> Bool? {
        textfield.delegate?.textField?(textfield, shouldChangeCharactersIn: range, replacementString: replacement)
    }
    
    @discardableResult private func shouldReturn(in textField: UITextField) -> Bool? {
        textField.delegate?.textFieldShouldReturn?(textField)
    }
    
    func putInViewHeirarchy(_ viewController: UIViewController) {
        let window = UIWindow()
        window.addSubview(viewController.view)
    }
}
