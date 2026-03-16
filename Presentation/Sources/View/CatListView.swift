//
//  SwiftUIView.swift
//  Presentation
//
//  Created by 김호성 on 2025.11.27.
//

import SwiftUI

import Kingfisher

import Domain

import ViewModel

public struct CatListView: View {
    @EnvironmentObject private var appCoordinator: AppCoordinator
    
    // 1. ViewModel 인터페이스 유지
    private var catViewModel: CatViewModel
    
    // 2. Combine 스트림의 데이터를 SwiftUI가 관찰할 수 있는 상태로 변환
    @State private var adoptedCats: [CatEntity] = []
    @State private var inputCount: Int? = nil
    
    public init(catViewModel: CatViewModel) {
        self.catViewModel = catViewModel
    }
    
    public var body: some View {
        VStack {
            catList
            catAdoptInputView
                .padding(.horizontal, 8)
                .safeAreaPadding(.bottom, 16)
        }
        // 3. ViewModel의 cats(CurrentValueSubject)를 구독하여 상태 업데이트
        .onReceive(catViewModel.cats) { newCats in
            self.adoptedCats = newCats
        }
    }
    
    private var catList: some View {
        // cats.value 대신 상태 변수인 adoptedCats 사용
        List(adoptedCats) { adoptedCat in
            CatRow(catEntity: adoptedCat)
                .contentShape(Rectangle()) // 터치 영역 확보
                .onTapGesture {
                    appCoordinator.push(to: .catDetail(adoptedCat))
                }
        }
        .listStyle(.plain)
    }
    
    private var catAdoptInputView: some View {
        HStack {
            TextField(
                "입양할 고양이의 수를 입력하세요.",
                value: $inputCount,
                format: .number
            )
            .textFieldStyle(.roundedBorder)
            .keyboardType(.numberPad)
            
            Button("입양") {
                if let count = inputCount {
                    catViewModel.adoptCats(count: count)
                    inputCount = nil // 입력 완료 후 초기화
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(inputCount == nil)
        }
    }
}

private struct CatRow: View {
    var catEntity: CatEntity
    
    var body: some View {
        HStack(alignment: .top) {
            catImage
            catInfoView
        }
    }
    
    private var catImage: some View {
        KFImage(catEntity.imageUrl)
            .resizable()
            .scaledToFill()
            .frame(width: 128, height: 128)
            .clipped()
    }
    
    private var catInfoView: some View {
        VStack(alignment: .leading) {
            Text(catEntity.species)
                .font(.title2)
            Text(catEntity.features)
                .font(.body)
            if let wikipedia = catEntity.wikipedia {
                Link("Wikipedia", destination: wikipedia)
                    .foregroundStyle(.blue)
            }
        }
    }
}


//struct CatListView_Preview: PreviewProvider {
//    static var previews: some View {
//        CatListView(catUseCase: MockCatUseCase())
//            .environmentObject(AppCoordinator(root: .catList))
//        
//        CatRow(catEntity: CatEntity(id: UUID().uuidString, imageUrl: URL(string: "https://lv2-cdn.azureedge.net/jypark/f8ba911ed379439fbe831212be8701f9-231103%206PM%20%EB%B0%95%EC%A7%84%EC%98%81%20Conceptphoto03(Clean).jpg"), size: .zero, species: "냐옹", features: "박진냥이에용~", wikipedia: URL(string: "https://en.wikipedia.org/wiki/J.Y._Park")))
//    }
//}
