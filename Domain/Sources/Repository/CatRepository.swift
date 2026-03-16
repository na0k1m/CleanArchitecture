//
//  CatRepository.swift
//  Domain
//
//  Created by 김나영 on 3/6/26.
//

import Combine
import Foundation

import Entity

public protocol CatRepository {
    func fetchCats(count: Int) -> AnyPublisher<[CatEntity], Error>
}
