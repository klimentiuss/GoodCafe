//
//  AuthentificationTests.swift
//  GoodCafe
//
//  Created by Daniil Klimenko on 06.11.2023.
//

import XCTest
import Firebase
@testable import AuthentificationManager

final class AuthentificationTests: XCTestCase {
    var authManager: AuthentificationManager!

        override func setUp() {
            super.setUp()
            FirebaseApp.configure()
            authManager = AuthentificationManager()
        }

        override func tearDown() {
            authManager = nil
            super.tearDown()
        }

        func testSignInSuccess() {
            let expectation = XCTestExpectation(description: "Sign in success")
            authManager.signIn(email: "test@example.com", password: "password") { error in
                XCTAssertNil(error)
                XCTAssertNotNil(authManager.userSession)
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 5.0)
        }

        func testCreateUserSuccess() {
            let expectation = XCTestExpectation(description: "Create user success")
            authManager.createUser(withEmail: "test@example.com", password: "password", fullname: "Test User") { error in
                XCTAssertNil(error)
                XCTAssertNotNil(authManager.userSession)
                XCTAssertNotNil(authManager.currentuser)
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 5.0)
        }

        func testSignOutSuccess() {
            let expectation = XCTestExpectation(description: "Sign out success")
            authManager.signOut()
            XCTAssertNil(authManager.userSession)
            XCTAssertNil(authManager.currentuser)
            expectation.fulfill()
            wait(for: [expectation], timeout: 5.0)
        }

        func testFetchUserSuccess() {
            let expectation = XCTestExpectation(description: "Fetch user success")
            authManager.fetchUser() { error in
                XCTAssertNil(error)
                XCTAssertNotNil(authManager.currentuser)
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 5.0)
        }

}
