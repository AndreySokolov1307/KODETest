//
//  Autolayout+PropertyWrapper.swift
//  KODETest
//
//  Created by Андрей Соколов on 09.03.2024.
//

import UIKit
@propertyWrapper
struct UseAutolayout<T: UIView> {
    
    var wrappedValue:T {
        didSet {
            wrappedValue.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        wrappedValue.translatesAutoresizingMaskIntoConstraints = false
    }
}
