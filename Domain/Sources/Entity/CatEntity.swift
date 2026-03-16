//
//  CatEntity.swift
//  Domain
//
//  Created by 김호성 on 2025.03.03.
//

import Foundation
import CoreGraphics

public struct CatEntity: Codable, Hashable, Sendable, Identifiable {
    public let id: String
    public let imageUrl: URL?
    public let size: CGSize
    public let species: String
    public let features: String
    public let wikipedia: URL?
    
    public init(id: String, imageUrl: URL?, size: CGSize, species: String, features: String, wikipedia: URL?) {
        self.id = id
        self.imageUrl = imageUrl
        self.size = size
        self.species = species
        self.features = features
        self.wikipedia = wikipedia
    }
}
