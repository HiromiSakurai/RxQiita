//
//  Container.swift
//  RxQiita
//
//  Created by 櫻井寛海 on 2018/07/27.
//  Copyright © 2018 Hiromi Sakurai. All rights reserved.
//

import Foundation
import Swinject

var resolver: Resolver {
    return assembler.resolver
}

private let assembler = Assembler([ViewModelAssembly(),
                                   ViewModelAssembly(),
                                   UsecaseAssembly()])
