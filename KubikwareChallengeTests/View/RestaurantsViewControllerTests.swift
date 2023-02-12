//
//  RestaurantsViewControllerTests.swift
//  KubikwareChallengeTests
//
//  Created by Marco Siracusano on 12/02/2023.
//

import XCTest
@testable import KubikwareChallenge

final class RestaurantsViewControllerTests: XCTestCase {
    
    private var sut: RestaurantsViewController!
    private var mockViewModel: MockRestaurantsViewModel!
    
    override func setUp() {
        super.setUp()
        
        sut = RestaurantsViewController()
        
        mockViewModel = MockRestaurantsViewModel()
        sut.viewModel = mockViewModel
    }
    
    override func tearDown() {
        mockViewModel = nil
        sut = nil
        
        super.tearDown()
    }
    
    
    // MARK: - Tests
    
    func test_viewNotNil() {
        XCTAssertNotNil(sut.view)
    }
    
    func test_viewIsLoaded_backgroundColorShouldBeSetUp() {
        // Given
        
        // When
        sut.loadViewIfNeeded()
        
        // Then
        XCTAssertEqual(sut.view.backgroundColor, .white)
    }
    
    func test_viewIsLoaded_nameLabelShouldBeSetUp() {
        // Given
        
        // When
        sut.loadViewIfNeeded()
        
        // Then
        XCTAssertEqual(sut.nameLabel.text, "Restaurants")
    }
    
    func test_viewIsLoaded_tableViewShouldBeSetUp() {
        // Given
        
        // When
        sut.loadViewIfNeeded()
        
        // Then
        XCTAssertNotNil(sut.tableView.delegate)
        XCTAssertNotNil(sut.tableView.dataSource)
    }
    
    func test_tableView_numberOfRowsInSection() {
        // Given
        let expectedRowCount = 5
        mockViewModel._getRestaurantsCount = expectedRowCount
        
        // When
        sut.loadViewIfNeeded()
        
        // Then
        XCTAssertEqual(sut.tableView(sut.tableView, numberOfRowsInSection: 0), expectedRowCount)
    }
    
    func test_tableViewCellForRowAt_shouldReturnCastedCell() {
        // Given
        sut.loadViewIfNeeded()
        
        // When
        let cell = sut.tableView(sut.tableView, cellForRowAt: .init(row: 0, section: 0))
        
        // Then
        XCTAssertTrue(cell is RestaurantTableViewCell)
    }
    
    func test_tableViewCellForRowAt_shouldReturnCellWithDelegateSetup() {
        // Given
        
        // When
        sut.loadViewIfNeeded()
        
        let cell = sut.tableView(sut.tableView, cellForRowAt: .init(row: 0, section: 0)) as? RestaurantTableViewCell
        
        // Then
        XCTAssertNotNil(cell?.favoritesDelegate as? RestaurantsViewController)
    }
    
    func test_tableViewCellForRowAt_shouldReturnCellWithProperUUID() {
        // Given
        let expectedUUID = MockFactory.exampleRestaurant.uuid!
        mockViewModel._getRestaurantUUID = expectedUUID
        
        // When
        sut.loadViewIfNeeded()
        
        let cell = sut.tableView(sut.tableView, cellForRowAt: .init(row: 0, section: 0)) as? RestaurantTableViewCell
        
        // Then
        XCTAssertEqual(cell?.uuid, expectedUUID)
    }
    
    func test_tableViewCellForRowAt_shouldReturnCellWithProperIsFavoriteValue() {
        // Given
        mockViewModel._isRestaurantFavorite = true
        
        // When
        sut.loadViewIfNeeded()
        
        let cell = sut.tableView(sut.tableView, cellForRowAt: .init(row: 0, section: 0)) as? RestaurantTableViewCell
        
        // Then
        XCTAssertTrue(cell?.isFavorite ?? false)
    }
    
    func test_tableViewCellForRowAt_shouldReturnCellWithProperName() {
        // Given
        let expectedName = MockFactory.exampleRestaurant.name!
        mockViewModel._getRestaurantName = expectedName
        
        // When
        sut.loadViewIfNeeded()
        
        let cell = sut.tableView(sut.tableView, cellForRowAt: .init(row: 0, section: 0)) as? RestaurantTableViewCell
        
        // Then
        XCTAssertEqual(cell?.nameLabel.text, expectedName)
    }
    
    func test_tableViewCellForRowAt_shouldReturnCellWithProperRatingBadge() {
        // Given
        let expectedRating = "9.5"
        mockViewModel._getRestaurantRating = expectedRating
        
        // When
        sut.loadViewIfNeeded()
        
        let cell = sut.tableView(sut.tableView, cellForRowAt: .init(row: 0, section: 0)) as? RestaurantTableViewCell
        
        // Then
        XCTAssertEqual(cell?.ratingBadge.text, expectedRating)
    }
    
    func test_tableViewCellForRowAt_shouldReturnCellWithProperDiscountBadge() {
        // Given
        let expectedDiscount = MockFactory.exampleRestaurant.bestOffer!.label!
        mockViewModel._getRestaurantDiscount = expectedDiscount
        
        // When
        sut.loadViewIfNeeded()
        
        let cell = sut.tableView(sut.tableView, cellForRowAt: .init(row: 0, section: 0)) as? RestaurantTableViewCell
        
        // Then
        XCTAssertEqual(cell?.discountBadge.text, expectedDiscount)
    }
    
    func test_tableViewCellForRowAt_shouldReturnCellWithProperCuisineBadge() {
        // Given
        let expectedCuisine = MockFactory.exampleRestaurant.servesCuisine!
        mockViewModel._getRestaurantCuisine = expectedCuisine
        
        // When
        sut.loadViewIfNeeded()
        
        let cell = sut.tableView(sut.tableView, cellForRowAt: .init(row: 0, section: 0)) as? RestaurantTableViewCell
        
        // Then
        XCTAssertEqual(cell?.cuisineBadge.text, expectedCuisine)
    }
    
    func test_tableViewCellForRowAt_shouldReturnCellWithLocation() {
        // Given
        let expectedLocation = MockFactory.exampleRestaurant.address!.street!
        mockViewModel._getRestaurantAddress = expectedLocation
        
        // When
        sut.loadViewIfNeeded()
        
        let cell = sut.tableView(sut.tableView, cellForRowAt: .init(row: 0, section: 0)) as? RestaurantTableViewCell
        
        // Then
        XCTAssertEqual(cell?.locationLabel.text, expectedLocation)
    }
    
    func test_tableViewCellForRowAt_shouldReturnCellWithPrice() {
        // Given
        let expectedPrice = MockFactory.exampleRestaurant.priceRange!.currencyFormattedString("eur")
        mockViewModel._getAveragePriceRange = expectedPrice
        
        // When
        sut.loadViewIfNeeded()
        
        let cell = sut.tableView(sut.tableView, cellForRowAt: .init(row: 0, section: 0)) as? RestaurantTableViewCell
        
        // Then
        XCTAssertEqual(cell?.priceLabel.text, expectedPrice)
        XCTAssertNotNil(cell?.mainPictureImageView.image)
    }
    
    func test_tableViewCellForRowAt_shouldReturnCellWithImage() {
        // Given
        sut.loadViewIfNeeded()
        
        // When
        let cell = sut.tableView(sut.tableView, cellForRowAt: .init(row: 0, section: 0)) as? RestaurantTableViewCell
        
        // Then
        XCTAssertNotNil(cell?.mainPictureImageView.image)
    }
}
