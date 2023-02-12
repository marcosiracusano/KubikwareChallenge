//
//  RestaurantsViewModelTests.swift
//  KubikwareChallengeTests
//
//  Created by Marco Siracusano on 12/02/2023.
//

import XCTest
import Combine
@testable import KubikwareChallenge

final class RestaurantsViewModelTests: XCTestCase {
    
    private var sut: RestaurantsViewModel!
    private var mockService: MockRestaurantsService!
    private var input: PassthroughSubject<RestaurantsViewModel.Input, Never>!
    
    override func setUp() {
        super.setUp()
        
        input = .init()
        mockService = MockRestaurantsService()
        sut = RestaurantsViewModel(service: mockService)
        let _ = sut.transform(input: input.eraseToAnyPublisher())
    }
    
    override func tearDown() {
        sut = nil
        mockService = nil
        input = nil
        
        super.tearDown()
    }
    
    
    // MARK: - Tests
    
    func test_getRestaurantsCountWithSuccessResult_shouldReturnProperQuantity() {
        // Given
        let quantity = 9
        mockService.fetchRestaurantsResult = mockService.getSuccessResult(quantity: quantity)
        
        // When
        input.send(.viewDidLoad)
        
        // Then
        XCTAssertEqual(sut.getRestaurantsCount(), quantity)
    }
    
    func test_getRestaurantsCountWithFailureResult_shouldReturnZero() {
        // Given
        mockService.fetchRestaurantsResult = mockService.getFailureResult()
        
        // When
        input.send(.viewDidLoad)
        
        // Then
        XCTAssertEqual(sut.getRestaurantsCount(), 0)
    }
    
    func test_getRestaurantName_shouldReturnProperName() {
        // Given
        let restaurant = MockFactory.exampleRestaurant
        mockService.fetchRestaurantsResult = mockService.getSuccessResult(quantity: 1)
        
        // When
        input.send(.viewDidLoad)
        
        // Then
        XCTAssertEqual(sut.getRestaurantName(for: 0), restaurant.name)
    }
    
    func test_getRestaurantNameWithEmptyRestaurant_shouldReturnDefaultValue() {
        // Given
        let emptyRestaurant = Restaurant()
        mockService.fetchRestaurantsResult = mockService.getSuccessResult(emptyRestaurant, quantity: 1)
        
        // When
        input.send(.viewDidLoad)
        
        // Then
        XCTAssertEqual(sut.getRestaurantName(for: 0), "Name unavailable")
    }
    
    func test_getRestaurantRating_shouldReturnProperRatingForKey() {
        // Given
        let restaurant = MockFactory.exampleRestaurant
        mockService.fetchRestaurantsResult = mockService.getSuccessResult(quantity: 1)
        
        // When
        input.send(.viewDidLoad)
        
        // Then
        XCTAssertEqual(sut.getRestaurantRating(for: 0), String(restaurant.aggregateRatings?["thefork"]?.ratingValue ?? 0))
    }
    
    func test_getRestaurantRatingWithEmptyRestaurant_shouldReturnDefaultValue() {
        // Given
        let emptyRestaurant = Restaurant()
        mockService.fetchRestaurantsResult = mockService.getSuccessResult(emptyRestaurant, quantity: 1)
        
        // When
        input.send(.viewDidLoad)
        
        // Then
        XCTAssertEqual(sut.getRestaurantRating(for: 0), "")
    }
    
    func test_getRestaurantAddress_shouldReturnProperFullAddress() {
        // Given
        let restaurant = MockFactory.exampleRestaurant
        let street = restaurant.address?.street ?? ""
        let locality = restaurant.address?.locality ?? ""
        let country = restaurant.address?.country ?? ""
        mockService.fetchRestaurantsResult = mockService.getSuccessResult(quantity: 1)
        
        // When
        input.send(.viewDidLoad)
        
        // Then
        XCTAssertEqual(sut.getRestaurantAddress(for: 0), street + ", " + locality + ", " + country)
    }
    
    func test_getRestaurantAddressWithEmptyRestaurant_shouldReturnDefaultValue() {
        // Given
        let emptyRestaurant = Restaurant()
        mockService.fetchRestaurantsResult = mockService.getSuccessResult(emptyRestaurant, quantity: 1)
        
        // When
        input.send(.viewDidLoad)
        
        // Then
        XCTAssertEqual(sut.getRestaurantAddress(for: 0), "Address unavailable")
    }
    
    func test_getAveragePriceRange_shouldReturnProperPrice() {
        // Given
        let restaurant = MockFactory.exampleRestaurant
        let currency = restaurant.currenciesAccepted ?? "eur"
        mockService.fetchRestaurantsResult = mockService.getSuccessResult(quantity: 1)
        
        // When
        input.send(.viewDidLoad)
        
        // Then
        XCTAssertEqual(sut.getAveragePriceRange(for: 0), restaurant.priceRange?.currencyFormattedString(currency))
    }
    
    func test_getAveragePriceRangeWithEmptyRestaurant_shouldReturnDefaultValue() {
        // Given
        let emptyRestaurant = Restaurant()
        mockService.fetchRestaurantsResult = mockService.getSuccessResult(emptyRestaurant, quantity: 1)
        
        // When
        input.send(.viewDidLoad)
        
        // Then
        XCTAssertEqual(sut.getAveragePriceRange(for: 0), "Price unavailable")
    }
    
    func test_getRestaurantCuisine_shouldReturnProperCuisineType() {
        // Given
        let restaurant = MockFactory.exampleRestaurant
        mockService.fetchRestaurantsResult = mockService.getSuccessResult(quantity: 1)
        
        // When
        input.send(.viewDidLoad)
        
        // Then
        XCTAssertEqual(sut.getRestaurantCuisine(for: 0), restaurant.servesCuisine?.uppercased())
    }
    
    func test_getRestaurantCuisineWithEmptyRestaurant_shouldReturnDefaultValue() {
        // Given
        let emptyRestaurant = Restaurant()
        mockService.fetchRestaurantsResult = mockService.getSuccessResult(emptyRestaurant, quantity: 1)
        
        // When
        input.send(.viewDidLoad)
        
        // Then
        XCTAssertEqual(sut.getRestaurantCuisine(for: 0), "")
    }
    
    func test_getRestaurantDiscoount_shouldReturnProperDiscount() {
        // Given
        let restaurant = MockFactory.exampleRestaurant
        mockService.fetchRestaurantsResult = mockService.getSuccessResult(quantity: 1)
        
        // When
        input.send(.viewDidLoad)
        
        // Then
        XCTAssertEqual(sut.getRestaurantDiscount(for: 0), restaurant.bestOffer?.label)
    }
    
    func test_getRestaurantDiscountWithEmptyRestaurant_shouldReturnDefaultValue() {
        // Given
        let emptyRestaurant = Restaurant()
        mockService.fetchRestaurantsResult = mockService.getSuccessResult(emptyRestaurant, quantity: 1)
        
        // When
        input.send(.viewDidLoad)
        
        // Then
        XCTAssertEqual(sut.getRestaurantDiscount(for: 0), "")
    }
    
    func test_getRestaurantUUID_shouldReturnProperUUID() {
        // Given
        let restaurant = MockFactory.exampleRestaurant
        mockService.fetchRestaurantsResult = mockService.getSuccessResult(quantity: 1)
        
        // When
        input.send(.viewDidLoad)
        
        // Then
        XCTAssertEqual(sut.getRestaurantUUID(for: 0), restaurant.uuid)
    }
    
    func test_getRestaurantUUIDWithEmptyRestaurant_shouldReturnDefaultValue() {
        // Given
        let emptyRestaurant = Restaurant()
        mockService.fetchRestaurantsResult = mockService.getSuccessResult(emptyRestaurant, quantity: 1)
        
        // When
        input.send(.viewDidLoad)
        
        // Then
        XCTAssertEqual(sut.getRestaurantUUID(for: 0), "")
    }
    
    func test_getRestaurantImageUrl_shouldReturnProperUrl() {
        // Given
        let restaurant = MockFactory.exampleRestaurant
        mockService.fetchRestaurantsResult = mockService.getSuccessResult(quantity: 1)
        
        // When
        input.send(.viewDidLoad)
        
        // Then
        XCTAssertEqual(sut.getRestaurantImageUrl(for: 0), URL(string: restaurant.mainPhoto?.source ?? ""))
    }
    
    func test_getRestaurantImageUrlWithEmptyRestaurant_shouldReturnDefaultValue() {
        // Given
        let emptyRestaurant = Restaurant()
        mockService.fetchRestaurantsResult = mockService.getSuccessResult(emptyRestaurant, quantity: 1)
        
        // When
        input.send(.viewDidLoad)
        
        // Then
        XCTAssertNil(sut.getRestaurantImageUrl(for: 0))
    }
    
    func test_isRestaurantFavoriteWithEmptyRestaurant_shouldReturnFalse() {
        // Given
        let emptyRestaurant = Restaurant()
        mockService.fetchRestaurantsResult = mockService.getSuccessResult(emptyRestaurant, quantity: 1)
        
        // When
        input.send(.viewDidLoad)
        
        // Then
        XCTAssertFalse(sut.isRestaurantFavorite(for: 0))
    }
}
