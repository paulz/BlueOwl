//
//  DependencyInjection.swift
//  BlueOwl
//
//  Created by Paul Zabelin on 10/1/18.
//  Copyright © 2018 Paul Zabelin. All rights reserved.
//

import SwinjectStoryboard
import SwiftOwl

extension SwinjectStoryboard {
    public static func setup() {
        defaultContainer.register(Model.self) { _ in
            return Model()
        }
        defaultContainer.storyboardInitCompleted(ViewController.self) { r, c in
            c.model = r.resolve(Model.self)
        }
    }
}
