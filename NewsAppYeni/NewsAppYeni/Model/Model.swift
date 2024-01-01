//
//  Model.swift
//  NewsAppYeni
//
//  Created by Ebru Barış on 1.01.2024.
//

import Foundation

struct Model : Decodable {
    var title : String?
    var description : String?
    var urlToImage : String?
}

struct NewResponse : Decodable {
    var articles : [Model]
}
