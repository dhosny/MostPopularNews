//
//  Route.swift
//  HiddenTreasure
//
//  Created by Karim Ebrahem on 2/1/20.
//  Copyright © 2020 Karim Ebrahem. All rights reserved.
//

import Foundation
import UIKit

public enum PresentingStyle {
    case modal(modalPresentationStyle: UIModalPresentationStyle = .fullScreen)
    case push
    case inPlace ///pop and present
    case popToView(vc: UIViewController.Type)
}

public protocol Route {
    var destination: UIViewController { get }
    var defaultStyle: PresentingStyle { get }
}

public protocol NavigationRoute: class {
    func navigateTo(_ route: Route)
}
