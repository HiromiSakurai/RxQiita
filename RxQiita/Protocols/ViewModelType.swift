//
//  ViewModelType.swift
//  RxQiita
//
//  Created by 櫻井寛海 on 2018/08/21.
//  Copyright © 2018 Hiromi Sakurai. All rights reserved.
//

import Foundation

protocol ViewModelInputs {}

protocol ViewModelOutputs {}

protocol ViewModelType {
    associatedtype Inputs: ViewModelInputs
    associatedtype Outputs: ViewModelOutputs
    var outputs: Outputs! { get }
    init(inputs: ViewModelInputs)
}
