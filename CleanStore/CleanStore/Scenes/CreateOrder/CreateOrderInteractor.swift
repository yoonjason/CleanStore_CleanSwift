//
//  CreateOrderInteractor.swift
//  CleanStore
//
//  Created by Bradley.yoon on 2023/05/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CreateOrderBusinessLogic
{
    var shippingMethods: [String] { get }
    func formatExpirationDate(request: CreateOrder.FormatExpirationDate.Request)
}

protocol CreateOrderDataStore
{
    var orderToEdit: Order? { get set }
    
}

class CreateOrderInteractor: CreateOrderBusinessLogic, CreateOrderDataStore
{
    var presenter: CreateOrderPresentationLogic?
    var worker: CreateOrderWorker?
    var shippingMethods: [String] = [
        ShipmentMethod(speed: .Standard).toString(),
        ShipmentMethod(speed: .OneDay).toString(),
        ShipmentMethod(speed: .TwoDay).toString(),
    ]
    var orderToEdit: Order?
    

    func formatExpirationDate(request: CreateOrder.FormatExpirationDate.Request) {
        let response = CreateOrder.FormatExpirationDate.Response(date: request.date)
        presenter?.presentExpirationDate(response: response)
    }
}
