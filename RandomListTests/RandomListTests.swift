//
//  RandomListTests.swift
//  RandomListTests
//
//  Created by Aaqib Hussain on 23/4/19.
//  Copyright © 2019 Aaqib Hussain. All rights reserved.
//

import XCTest
@testable import RandomList

class RandomListTests: XCTestCase {

    var manager: NetworkRequestManager?
    var viewModel: RandomListViewModel?

    override func setUp() {
        super.setUp()
        manager = NetworkRequestManager(apiManager: MockAPIManager(), coreDataManager: MockCoreDataManager())
        viewModel = RandomListViewModel(manager: manager!)
        viewModel!.getRandomProducts(router: FilePathRouter.getProducts)
    }
    
    override func tearDown() {
        super.tearDown()
       
        manager = nil
        viewModel = nil
        
    }
    
    func testRandomListViewModel() {
        let product = viewModel!.products.first!
        XCTAssertEqual(product.prodName, "Buggati Veyron")
        XCTAssertEqual(product.brand, "Buggati")
        XCTAssertEqual(product.orignalPrice, "600000.0")
        XCTAssertEqual(product.currentPrice, "100000.0")
        XCTAssertEqual(product.currency, "EUR")
        XCTAssertEqual(product.image?.url, "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c9/Bugatti_Veyron_16.4_%E2%80%93_Frontansicht_%281%29%2C_5._April_2012%2C_D%C3%BCsseldorf.jpg/280px-Bugatti_Veyron_16.4_%E2%80%93_Frontansicht_%281%29%2C_5._April_2012%2C_D%C3%BCsseldorf.jpg")
        
    }
    
    func testGetRandomProducts() {
        let product = viewModel!.getItemAtIndex(index: 0)
        XCTAssertEqual(product.prodName, "Buggati Veyron")
        XCTAssertEqual(product.brand, "Buggati")
        XCTAssertEqual(product.orignalPrice, "600000.0")
        XCTAssertEqual(product.currentPrice, "100000.0")
        XCTAssertEqual(product.currency, "EUR")
        XCTAssertEqual(product.image?.url, "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c9/Bugatti_Veyron_16.4_%E2%80%93_Frontansicht_%281%29%2C_5._April_2012%2C_D%C3%BCsseldorf.jpg/280px-Bugatti_Veyron_16.4_%E2%80%93_Frontansicht_%281%29%2C_5._April_2012%2C_D%C3%BCsseldorf.jpg")
    }
    
    func testNumberOfRows() {
        let product = viewModel!.products
        XCTAssertEqual(product.count, 16)
    }
    
    func testSearch() {
        viewModel!.searchProductByName(text: "Bu")
        XCTAssertEqual(viewModel!.products.first!.prodName, "Buggati Veyron")
    }
    
}
