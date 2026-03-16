//
//  Untitled.swift
//  Domain
//
//  Created by 김나영 on 3/6/26.
//

import Combine
import Foundation

import Entity
import Repository

public protocol CatUseCase {
    func fetchCats(count: Int) -> AnyPublisher<[CatEntity], Error>
}

public class DefaultCatUseCase: CatUseCase {
    private let catRepository: CatRepository
    
    public init(catRepository: CatRepository) {
        self.catRepository = catRepository
    }
    
    public func fetchCats(count: Int) -> AnyPublisher<[CatEntity], Error> {
        return catRepository.fetchCats(count: count)
    }
}
