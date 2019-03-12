//
//  PostModel.swift
//  laborator2
//
//  Created by Adrian Popovici on 12/03/2019.
//  Copyright © 2019 laborator. All rights reserved.
//

import Foundation

struct PostModel: Codable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
}
