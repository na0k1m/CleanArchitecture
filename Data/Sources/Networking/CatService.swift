//
//  CatService.swift
//  Data
//
//  Created by 김나영 on 3/6/26.
//

// apple basic frameworks
import Combine
import Foundation

// third party frameworks
import Moya
import CombineMoya

// layer

// target
import DTO

public protocol CatService {
    func fetchCats(count: Int) -> AnyPublisher<[CatResponseDTO], MoyaError>
}

public class DefaultCatService: CatService {
    
    private let provider = MoyaProvider<CatAPI>()
    
    public init() {}
    
    public func fetchCats(count: Int) -> AnyPublisher<[CatResponseDTO], MoyaError> {
        return provider.requestPublisher(.fetchCats(count: count))
            .map([CatResponseDTO].self)
    }
    
}
