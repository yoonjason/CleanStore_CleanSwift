//
//  OrderMemStore.swift
//  CleanStore
//
//  Created by Bradley.yoon on 2023/06/08.
//

import Foundation

class OrderMemStore: OrdersStoreProtocol, OrdersStoreUtilityProtocol {

    static var billingAddress = Address(street1: "1 Infinite Loop", city: "Seoul", state: "SE", zip: "02")
    static var shipmentAddress = Address(street1: "One Microsoft Way", city: "Redmond", state: "WA", zip: "98052")
    static var paymentMethod = PaymentMethod(creditCardNumber: "1234-1234-1234-1234", expirationDate: Date(), cvc: "999")
    static var shipmentMethod = ShipmentMethod(speed: .OneDay)

    static var orders = [
        Order(firstName: "bradley", lastName: "yoon", phone: "010-2959-9730", email: "yeong806@gmail.com", billingAddress: billingAddress, paymentMethod: paymentMethod, shipmentAddress: shipmentAddress, shipmentMethod: shipmentMethod, id: "abc123", date: Date(), total: NSDecimalNumber(string: "1.23")),
        Order(firstName: "bradley", lastName: "yoon", phone: "010-2959-9730", email: "yeong806@gmail.com", billingAddress: billingAddress, paymentMethod: paymentMethod, shipmentAddress: shipmentAddress, shipmentMethod: shipmentMethod, id: "abc123", date: Date(), total: NSDecimalNumber(string: "4.56")),
        Order(firstName: "bradley", lastName: "yoon", phone: "010-2959-9730", email: "yeong806@gmail.com", billingAddress: billingAddress, paymentMethod: paymentMethod, shipmentAddress: shipmentAddress, shipmentMethod: shipmentMethod, id: "abc123", date: Date(), total: NSDecimalNumber(string: "1.44")),
    ]

    func fetchOrders(completionHandler: @escaping (() throws -> [Order]) -> Void) {
        completionHandler { return type(of: self).orders }
    }
    
    func createOrder(orderToCreate: Order, completionHandler: @escaping (() throws -> Order?) -> Void) {
        var order = orderToCreate
        generateOrderID(order: &order)
        calculateOrderTotal(order: &order)
        completionHandler { return order }
    }
    
    func updateOrder(orderToUpdate: Order, completionHandler: @escaping (() throws -> Order?) -> Void) {
        if let index = indexOrOrderWithID(id: orderToUpdate.id) {
            OrderMemStore.orders[index] = orderToUpdate
            let order = OrderMemStore.orders[index]
            completionHandler{ return order }
        }else {
            completionHandler { throw OrderStoreError.CannotUpdate("Cannot fetch order with id \(String(describing: orderToUpdate.id)) to update")}
        }
    }
    
    
    func testOrder(orderToTest: Order, completionHandler: @escaping (() -> Order) -> Void) {
        //TODO: 구현해보기
    }
    
    private func indexOrOrderWithID(id: String?) -> Int? {
        return type(of: self).orders.firstIndex{ $0.id == id }
    }
}
