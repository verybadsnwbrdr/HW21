//
//  ShowAlertProtocol+Extension.swift
//  HW21
//
//  Created by Anton on 12.11.2022.
//

import UIKit
import Alamofire

protocol ShowAlertProtocol {
    func showAlert(error: AFError?)
}

extension ShowAlertProtocol {
    func showAlert(error: AFError?) {
        guard let error = error else { return }
        let alertMessage = error.localizedDescription
        let alert = UIAlertController(title: "Что-то пошло не так",
                                      message: alertMessage,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { event in
            
        }))
        if let self = self as? UIViewController {
            self.present(alert, animated: true)
        }
    }
}
