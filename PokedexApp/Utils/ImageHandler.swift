//
//  ImageHandler.swift
//  PokedexApp
//
//  Created by Tiago Moreno on 8/02/20.
//  Copyright © 2020 Tiago Moreno. All rights reserved.
//

import Foundation
class ImageHandler {
    func getDataOfImage(from url: URL?, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        if url != nil {
            URLSession.shared.dataTask(with: url!, completionHandler: completion).resume()
        }
    }
}
