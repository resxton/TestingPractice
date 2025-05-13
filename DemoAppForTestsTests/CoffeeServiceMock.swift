//
//  CoffeeServiceMock.swift
//  DemoAppForTests
//
//  Created by Сомов Кирилл on 13.05.2025.
//

@testable import DemoAppForTests
import Foundation

final class CoffeeServiceMock: CoffeeServiceProtocol {
    
    // MARK: - Properties
    
    var mockCoffees: [Coffee] = []
    var mockOrders: [Order] = []
    var mockOrderResult: Order?
    var mockCancelOrderResult: Bool = true

    var fetchCoffeesCalled = false
    var fetchCoffeesCallCount = 0
    
    var placeOrderCalled = false
    var placeOrderCallCount = 0
    var lastPlaceOrderParameters: (coffeeId: Int, quantity: Int, customerName: String)?
    
    var getOrderStatusCalled = false
    var getOrderStatusCallCount = 0
    var lastGetOrderStatusParameter: Int?
    
    var cancelOrderCalled = false
    var cancelOrderCallCount = 0
    var lastCancelOrderParameter: Int?

    // MARK: - Methods
    
    func fetchCoffees() async throws -> [Coffee] {
        fetchCoffeesCalled = true
        fetchCoffeesCallCount += 1
        return mockCoffees
    }
    
    func placeOrder(coffeeId: Int, quantity: Int, customerName: String) async throws -> Order {
        placeOrderCalled = true
        placeOrderCallCount += 1
        lastPlaceOrderParameters = (coffeeId, quantity, customerName)
        
        guard let order = mockOrderResult else {
            throw CoffeeError.invalidOrderId
        }
        
        return order
    }
    
    func getOrderStatus(orderId: Int) async throws -> Order {
        getOrderStatusCalled = true
        getOrderStatusCallCount += 1
        lastGetOrderStatusParameter = orderId
        
        guard let order = mockOrders.first(where: { $0.id == orderId }) else {
            throw CoffeeError.invalidOrderId
        }
        
        return order
    }
    
    func cancelOrder(orderId: Int) async throws -> Bool {
        cancelOrderCalled = true
        cancelOrderCallCount += 1
        lastCancelOrderParameter = orderId
        
        guard mockCancelOrderResult else {
            throw CoffeeError.orderAlreadyCancelled
        }
        
        return mockCancelOrderResult
    }
}
