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
}
