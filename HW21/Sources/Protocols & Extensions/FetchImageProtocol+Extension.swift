//
//  UIViewController + Extension.swift
//  HW21
//
//  Created by Anton on 10.11.2022.
//

import UIKit
import Alamofire

protocol FetchImageProtocol {
    func fetchCharacterImage(from imageData: Image,
                             complition: @escaping (AFDataResponse<Data>) -> ())
}

extension FetchImageProtocol {
    func fetchCharacterImage(from imageData: Image,
                             complition: @escaping (AFDataResponse<Data>) -> ()) {
        let endPoint = imageData.path + "." + imageData.extensionOfImage
        guard !imageData.path.contains("image_not_available") else { return }
        let request = AF.request(endPoint)
        request.responseData(completionHandler: complition)
    }
}

