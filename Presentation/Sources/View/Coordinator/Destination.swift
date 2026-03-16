//
//  File.swift
//  Presentation
//
//  Created by 김호성 on 2025.12.05.
//

import Foundation

import Domain

public enum Destination: Hashable {
    case catList
    case catDetail(CatEntity)
}
