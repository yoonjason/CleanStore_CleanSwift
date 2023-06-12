//
//  CreateOrderPresenter.swift
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

protocol CreateOrderPresentationLogic
{
    func presentExpirationDate(response: CreateOrder.FormatExpirationDate.Response)
}

class CreateOrderPresenter: CreateOrderPresentationLogic
{
    weak var viewController: CreateOrderDisplayLogic?

    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()


    func presentExpirationDate(response: CreateOrder.FormatExpirationDate.Response) {
        let date = dateFormatter.string(from: response.date)
        let viewModel = CreateOrder.FormatExpirationDate.ViewModel(date: date)
        viewController?.displayExpirationDate(viewModel: viewModel)
    }
}
