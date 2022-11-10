//
//  UIViewController + Extension.swift
//  HW21
//
//  Created by Anton on 10.11.2022.
//

import UIKit

protocol FetchImageProtocol {
    func fetchCharacterImage(from imageData: Image, complitionOnMainThread: @escaping (Data) -> ())
}

extension FetchImageProtocol {
    func fetchCharacterImage(from imageData: Image, complitionOnMainThread: @escaping (Data) -> ()) {
        let endPoint = imageData.path + "." + imageData.extensionOfImage
        guard !imageData.path.contains("image_not_available"),
              let imageURL = URL(string: endPoint) else { return }
        
        DispatchQueue.global(qos: .utility).async {
            do {
                let responseData = try Data(contentsOf: imageURL)
                DispatchQueue.main.async {
                    complitionOnMainThread(responseData)
                }
            } catch let error {
                print("Error - \(error)")
            }
        }
    }
}
