//
//  ListOrdersInteractor.swift
//  CleanStore
//
//  Created by Bradley.yoon on 2023/06/07.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ListOrdersBusinessLogic
{
    func fetchOrders(request: ListOrders.FetchOrders.Request)
}

protocol ListOrdersDataStore
{
    //var name: String { get set }
    var orders: [Order]? { get }
}

class ListOrdersInteractor: ListOrdersBusinessLogic, ListOrdersDataStore
{
    var presenter: ListOrdersPresentationLogic?
    var worker: ListOrdersWorker?
    var orderWorker = OrdersWorker(ordersStore: OrderMemStore())
    var orders: [Order]?
    
    
    func fetchOrders(request: ListOrders.FetchOrders.Request) {
        orderWorker.fetchOrders { (orders) -> Void in
            self.orders = orders
            let response = ListOrders.FetchOrders.Response(orders: orders)
            self.presenter?.presentFetchedOrders(response: response)
        }
    }

}
