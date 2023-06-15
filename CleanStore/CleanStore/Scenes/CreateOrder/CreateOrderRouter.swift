//
//  CreateOrderRouter.swift
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

@objc protocol CreateOrderRoutingLogic
{
    func routeToListOrders(segue: UIStoryboardSegue?)
    func routeToShowOrder(segue: UIStoryboardSegue?)
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol CreateOrderDataPassing
{
    var dataStore: CreateOrderDataStore? { get }
}

class CreateOrderRouter: NSObject, CreateOrderRoutingLogic, CreateOrderDataPassing
{
    weak var viewController: CreateOrderViewController?
    var dataStore: CreateOrderDataStore?

    // MARK: Routing
    
    func routeToListOrders(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! ListOrdersViewController
            var destinationDS = destinationVC.router!.dataStore!
            self.navigateToListOrder(source: viewController!, destination: destinationVC)
            self.passDataToListOrders(source: dataStore!, destination: &destinationDS)
        }else {
            let index = viewController!.navigationController!.viewControllers.count - 2
            let destinationVC = viewController?.navigationController?.viewControllers[index] as! ListOrdersViewController
            var destinationDS = destinationVC.router!.dataStore!
            self.navigateToListOrder(source: viewController!, destination: destinationVC)
            self.passDataToListOrders(source: dataStore!, destination: &destinationDS)
        }
    }
    
    func routeToShowOrder(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! ShowOrderViewController
            var destinationDS = destinationVC.router!.dataStore!
            
        }else {
            let index = viewController!.navigationController!.viewControllers.count - 2
            print(viewController?.navigationController?.viewControllers)
            let destinationVC = viewController?.navigationController?.viewControllers[index] as! ShowOrderViewController
            var destinationDS = destinationVC.router!.dataStore!
            self.navigateToShowOrder(source: viewController!, destination: destinationVC)
            self.passDataToShowOrder(source: dataStore!, destination: &destinationDS)
        }
        
    }


    // MARK: Navigation
    
    func navigateToListOrder(source: CreateOrderViewController, destination: ListOrdersViewController) {
        source.navigationController?.popViewController(animated: true)
    }
    
    func navigateToShowOrder(source: CreateOrderViewController, destination: ShowOrderViewController) {
        source.navigationController?.popViewController(animated: true)
    }
    

    //func navigateToSomewhere(source: CreateOrderViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}

    // MARK: Passing data
    func passDataToListOrders(source: CreateOrderDataStore, destination: inout ListOrdersDataStore) {
        destination.orders?.append(source.orderToEdit!)
//        OrdersWorker.ord
    }
    
    func passDataToShowOrder(source: CreateOrderDataStore, destination: inout ShowOrderDataStore) {
        destination.order = source.orderToEdit
    }
}
