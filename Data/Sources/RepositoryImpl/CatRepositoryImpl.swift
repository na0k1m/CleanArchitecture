//
//  Untitled.swift
//  Data
//
//  Created by 김나영 on 3/6/26.
//

import Combine
import Foundation

import Domain

import Networking

public class DefaultCatRepository: CatRepository {
    
    private let catService: CatService
    
    public init(catService: CatService) {
        self.catService = catService
    }
    
    public func fetchCats(count: Int) -> AnyPublisher<[CatEntity], Error> {
        return catService.fetchCats(count: count)
            .map({ $0.map(\.catEntity) })
            .mapError({ $0 as Error })
            .eraseToAnyPublisher()
    }
}
