//
//  CoffeeServiceTests.swift
//  DemoAppForTests
//
//  Created by Сомов Кирилл on 13.05.2025.
//

import XCTest
@testable import DemoAppForTests

final class CoffeeServiceTests: XCTestCase {
    var sut: CoffeeServiceProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CoffeeService()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_fetchCoffees() async throws {
        // given
        
        // when
        let coffees = try await sut.fetchCoffees()
        
        // then
        XCTAssertEqual(coffees.count, 5)
        XCTAssertEqual(coffees[0].name, "Espresso")
    }
    
    func test_placeOrder() async throws {
        // given
        let coffeeId = 1
        let quantity = 1
        let customerName = "John Doe"
        
        // when
        let order = try await sut.placeOrder(
            coffeeId: coffeeId,
            quantity: quantity,
            customerName: customerName
        )
        
        // then
        XCTAssertEqual(order.coffeeId, coffeeId)
        XCTAssertEqual(order.customerName, customerName)
        XCTAssertEqual(order.status, .pending)
    }
    
    func test_getOrderStatusSuccess() async throws {
        // given
        let order = try await sut.placeOrder(coffeeId: 1, quantity: 2, customerName: "John Doe")
        
        // when
        let fetchedOrder = try await sut.getOrderStatus(orderId: order.id)
        
        // then
        XCTAssertEqual(fetchedOrder.id, order.id)
        XCTAssertEqual(fetchedOrder.status, .pending)
    }
    
    func test_getOrderStatusFailure() async {
        // given
        let invalidOrderId = 9999
        
        // when & then
        do {
            _ = try await sut.getOrderStatus(orderId: invalidOrderId)
            XCTFail("Ожидалась ошибка")
        } catch CoffeeError.invalidOrderId {
            // Успешный случай, ожидаем ошибку
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func test_cancelOrderSuccess() async throws {
        // given
        let order = try await sut.placeOrder(coffeeId: 1, quantity: 2, customerName: "John Doe")
        
        // when
        let isCancelled = try await sut.cancelOrder(orderId: order.id)
        let updatedOrder = try await sut.getOrderStatus(orderId: order.id)
        
        // then
        XCTAssertTrue(isCancelled)
        XCTAssertEqual(updatedOrder.status, .cancelled)
    }
    
    func test_cancelOrderFailure() async throws {
        // given
        let invalidOrderId = 9999
        
        // when & then
        do {
            _ = try await sut.cancelOrder(orderId: invalidOrderId)
            XCTFail("Ожидалась ошибка")
        } catch CoffeeError.invalidOrderId {
            // Успешный случай, ожидаем ошибку
        } catch {
            XCTFail("\(error)")
        }
    }
}
