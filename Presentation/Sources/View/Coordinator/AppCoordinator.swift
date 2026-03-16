//
//  File.swift
//  Presentation
//
//  Created by 김호성 on 2025.12.05.
//

import Foundation

public final class AppCoordinator: ObservableObject {
    
    @Published public var root: Destination
    @Published public var path: [Destination] = []
    
    public init(root: Destination) {
        self.root = root
    }
    
    func push(to destination: Destination) {
        path.append(destination)
    }
    
    func pop() {
        _ = path.popLast()
    }
    
    func popToRoot() {
        path.removeAll()
    }
    
    func replaceRoot(to root: Destination) {
        self.root = root
        path.removeAll()
    }
}
