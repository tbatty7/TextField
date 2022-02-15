@testable import TextField
import XCTest

final class ViewControllerTests: XCTestCase {
    
    private func setUpViewController() -> ViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController: ViewController = storyboard.instantiateViewController(identifier: String(describing: ViewController.self))
        viewController.loadViewIfNeeded()
        
        return viewController
    }
    
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
        let allowChange = viewController.userNameField.delegate?.textField?(viewController.userNameField, shouldChangeCharactersIn: NSRange(), replacementString: "a b")
        XCTAssertEqual(allowChange, false)
    }
    
    func test_shouldChangeCharacters_usernameWithoutSpaces_shouldAllowChange() {
        let viewController = setUpViewController()
        let allowChange = viewController.userNameField.delegate?.textField?(viewController.userNameField, shouldChangeCharactersIn: NSRange(), replacementString: "abc")
        XCTAssertEqual(allowChange, true)
    }
    
    func test_shouldChangeCharacters_passwordWithSpaces_shouldAllowChange() {
        let viewController = setUpViewController()
        let allowChange = viewController.passwordField.delegate?.textField?(viewController.passwordField, shouldChangeCharactersIn: NSRange(), replacementString: "a b")
        XCTAssertEqual(allowChange, true)
    }
    
    func test_shouldChangeCharacters_passwordWithoutSpaces_shouldAllowChange() {
        let viewController = setUpViewController()
        let allowChange = viewController.passwordField.delegate?.textField?(viewController.passwordField, shouldChangeCharactersIn: NSRange(), replacementString: "abc")
        XCTAssertEqual(allowChange, true)
    }
}


