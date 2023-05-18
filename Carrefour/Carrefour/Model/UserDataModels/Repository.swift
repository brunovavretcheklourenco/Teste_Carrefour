//
//  Repository.swift
//  Carrefour
//
//  Created by exactaworks on 17/05/23.
//

import Foundation

struct Repository: Codable {
    let name: String?
    let description: String?
    let htmlUrl: URL?
    let stargazersCount: Int?
    let forksCount: Int?
}
