//
//  UIViewController+Route.swift
//  HiddenTreasure
//
//  Created by Karim Ebrahem on 2/1/20.
//  Copyright © 2020 Karim Ebrahem. All rights reserved.
//

import UIKit
import Foundation

extension UIViewController: NavigationRoute {
    public func navigateTo(_ route: Route) {
        switch route.defaultStyle {
            
        case let .modal(modalPresentationStyle):
            let destination = route.destination
            destination.modalPresentationStyle = modalPresentationStyle
            present(destination, animated: true, completion: nil)
            
        case .push:
            let destination = route.destination
            self.navigationController?.pushViewController(destination, animated: true)
        case .inPlace:
//            self.navigationController?.popViewController(animated: false)
//            let destination = route.destination
//            self.navigationController?.pushViewController(destination, animated: false)
            let destination = route.destination
            var vcArray = self.navigationController?.viewControllers
            vcArray?.removeLast()
            vcArray?.append(destination)
            self.navigationController?.setViewControllers(vcArray!, animated: false)
        case .popToView(vc: let vc):
            for controller in self.navigationController!.viewControllers as Array {
                if controller.isKind(of: vc) {
                    self.navigationController!.popToViewController(controller, animated: true)
                    break
                }
            }
        }
    }
}
