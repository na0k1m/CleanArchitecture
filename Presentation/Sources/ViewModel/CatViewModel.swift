//
//  CatViewModel.swift
//  Presentation
//
//  Created by 김나영 on 3/6/26.
//

import Combine
import Foundation

import Domain

public protocol CatViewModelInput {
    func adoptCats(count: Int)
}

public protocol CatViewModelOutput {
    var cats: CurrentValueSubject<[CatEntity], Never> { get }
}

public typealias CatViewModel = CatViewModelInput & CatViewModelOutput

public class DefaultCatViewModel: CatViewModel {
    public var cats: CurrentValueSubject<[CatEntity], Never> = .init([])
    
    private let catUseCase: CatUseCase
    private var cancellables: Set<AnyCancellable> = []
    
    public init(catUseCase: CatUseCase) {
        self.catUseCase = catUseCase
    }
    
    public func adoptCats(count: Int) {
        return catUseCase.fetchCats(count: count)
            .sink(receiveCompletion: { result in
                print(result)
            }, receiveValue: { [weak self] catEntities in
                self?.cats.value.append(contentsOf: catEntities)
            })
            .store(in: &cancellables)
    }
}
