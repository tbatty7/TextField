@testable import TextField
import XCTest

final class ViewControllerTests: XCTestCase {

    func test_outlets_shouldBeConnected() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController: ViewController = storyboard.instantiateViewController(identifier: String(describing: ViewController.self))
        viewController.loadViewIfNeeded()
        XCTAssertNotNil(viewController.userNameField, "username field")
        XCTAssertNotNil(viewController.passwordField, "password field")
        XCTAssertEqual(String(describing: ViewController.self), "ViewController")
    }
    
    func test_usernameField_attributesShouldBeSet() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController: ViewController = storyboard.instantiateViewController(identifier: String(describing: ViewController.self))
        viewController.loadViewIfNeeded()
        
        let textField = viewController.userNameField!
        
        XCTAssertEqual(textField.textContentType, .username, "text field content type")
        XCTAssertEqual(textField.autocorrectionType, .no, "text field autocorrection type")
        XCTAssertEqual(textField.returnKeyType, .next, "text field return key type")
    }
}
