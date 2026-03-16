import XCTest
@testable import Data

final class DataTests: XCTestCase {
    
    private var catService: CatService!
    
    override func setUp() {
        super.setUp()
        
        catService = DefaultCatService()
    }
    
    override func tearDown() {
        catService = nil
        
        super.tearDown()
    }
    
    func testFetchCats() throws {
        let expectation = XCTestExpectation(description: "비동기 Test")
        var receivedValue: Int?
        
        let cancellable = catService.fetchCats(count: 5)
            .sink(receiveCompletion: { result in
                print(result)
            }, receiveValue: { dto in
                print(dto)
                receivedValue = dto.count
                expectation.fulfill()
            })
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertEqual(receivedValue, 5)
        
        cancellable.cancel()
    }
}
