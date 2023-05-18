//
//  CarrefourTests.swift
//  CarrefourTests
//
//  Created by exactaworks on 15/05/23.
//

import XCTest
@testable import Carrefour

class UserDetailsViewModelTests: XCTestCase {
    
    func testInitializationWithUser() {
        let user = User(login: "bruno", id: 123, node_id: "node123", avatar_url: "https://example.com/avatar.jpg", gravatar_id: "gravatar123", url: "https://example.com/user", html_url: "https://example.com/user/profile", followers_url: "https://example.com/user/followers", following_url: "https://example.com/user/following", gists_url: "https://example.com/user/gists", starred_url: "https://example.com/user/starred", subscriptions_url: "https://example.com/user/subscriptions", organizations_url: "https://example.com/user/orgs", repos_url: "https://example.com/user/repos", events_url: "https://example.com/user/events", received_events_url: "https://example.com/user/received_events", type: "User", site_admin: false, name: "Bruno", bio: "Olá, sou o Bruno", followers: 100, following: 50)
        let viewModel = UserDetailsViewModel(user: user)
        
        XCTAssertEqual(viewModel.nameText, "Bruno")
        XCTAssertEqual(viewModel.avatar, "https://example.com/avatar.jpg")
        XCTAssertEqual(viewModel.followers, 100)
        XCTAssertEqual(viewModel.following, 50)
        XCTAssertNotNil(viewModel.bioText)
        XCTAssertEqual(viewModel.bioText?.string, "Bio: Olá, sou o Bruno")
        XCTAssertEqual(viewModel.login, "bruno")
    }
    
    func testInitializationWithNilUser() {
        let viewModel = UserDetailsViewModel(user: User(login: nil, id: nil, node_id: nil, avatar_url: nil, gravatar_id: nil, url: nil, html_url: nil, followers_url: nil, following_url: nil, gists_url: nil, starred_url: nil, subscriptions_url: nil, organizations_url: nil, repos_url: nil, events_url: nil, received_events_url: nil, type: nil, site_admin: nil, name: nil, bio: nil, followers: nil, following: nil))
        
        XCTAssertEqual(viewModel.nameText, "")
        XCTAssertNil(viewModel.avatar)
        XCTAssertEqual(viewModel.followers, 0)
        XCTAssertEqual(viewModel.following, 0)
        XCTAssertNil(viewModel.bioText)
        XCTAssertNil(viewModel.login)
    }
    
//MARK: Injetar a camada de Networking para testar o download das imagens
    
//    func testLoadImageWithValidURL() {
//        let expectation = XCTestExpectation(description: "LoadImage completion called")
//        let user = User(login: "Bruno", id: 123, node_id: "node123", avatar_url: "https://example.com/avatar.jpg", gravatar_id: "gravatar123", url: "https://example.com/user", html_url: "https://example.com/user/profile", followers_url: "https://example.com/user/followers", following_url: "https://example.com/user/following", gists_url: "https://example.com/user/gists", starred_url: "https://example.com/user/starred", subscriptions_url: "https://example.com/user/subscriptions", organizations_url: "https://example.com/user/orgs", repos_url: "https://example.com/user/repos", events_url: "https://example.com/user/events", received_events_url: "https://example.com/user/received_events", type: "User", site_admin: false, name: "Bruno", bio: "Olá, sou o Bruno", followers: 100, following: 50)
//        let viewModel = UserDetailsViewModel(user: user)
//
//        viewModel.loadImage { image in
//            XCTAssertNotNil(image)
//            expectation.fulfill()
//        }
//
//        wait(for: [expectation], timeout: 5.0)
//    }
}
