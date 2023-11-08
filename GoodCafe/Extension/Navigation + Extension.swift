//
//  Navigation + Extension.swift
//  GoodCafe
//
//  Created by Daniil Klimenko on 08.11.2023.
//

import SwiftUI

extension UINavigationController {
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backButtonDisplayMode = .minimal
        navigationBar.tintColor = .white
    }
}
