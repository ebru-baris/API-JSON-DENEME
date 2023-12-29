//
//  Model.swift
//  NewProductProject
//
//  Created by Ebru Barış on 29.12.2023.
//

import Foundation

struct Model {
    var title: String?
    var description: String?
    var price: Int?
    var thumbnail: String?
    var images: [Images]?
}

struct Images {
    var images: String?
}
