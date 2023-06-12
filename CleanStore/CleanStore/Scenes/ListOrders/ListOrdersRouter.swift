//
//  ListOrdersRouter.swift
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

@objc protocol ListOrdersRoutingLogic
{
    //func routeToSomewhere(segue: UIStoryboardSegue?)
    func routeToCreateOrder(segue: UIStoryboardSegue?)
    func routeToShowOrder(segue: UIStoryboardSegue?)
}

protocol ListOrdersDataPassing
{
    var dataStore: ListOrdersDataStore? { get }
}

class ListOrdersRouter: NSObject, ListOrdersRoutingLogic, ListOrdersDataPassing
{
    weak var viewController: ListOrdersViewController?
    var dataStore: ListOrdersDataStore?

    // MARK: Routing
    
    func routeToCreateOrder(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! CreateOrderViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToCreateOrder(source: dataStore!, destination: &destinationDS)
        }else {
            let destinationVC = segue?.destination as! CreateOrderViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToCreateOrder(source: dataStore!, destination: &destinationDS)
            navigateToCreateOrder(source: viewController!, destination: destinationVC)
            print("###")
        }
        
    }
    
    func routeToShowOrder(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let detinationVC = segue.destination as! ShowOrderViewController
            var destinationDS = detinationVC.router!.dataStore!
            passDataToShowOrder(source: dataStore!, destination: &destinationDS)
        }else {
            let detinationVC = segue?.destination as! ShowOrderViewController
            var destinationDS = detinationVC.router!.dataStore!
            navigationToShowOrder(source: viewController!, destination: detinationVC)
            passDataToShowOrder(source: dataStore!, destination: &destinationDS)
        }
    }
    
    //func routeToSomewhere(segue: UIStoryboardSegue?)
    //{
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}

    // MARK: Navigation

    //func navigateToSomewhere(source: ListOrdersViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}
    
    func navigateToCreateOrder(source: ListOrdersViewController, destination: CreateOrderViewController) {
        
    }
    
    func navigationToShowOrder(source: ListOrdersViewController, destination: ShowOrderViewController) {
        
    }

    // MARK: Passing data

    //func passDataToSomewhere(source: ListOrdersDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
    
    func passDataToCreateOrder(source: ListOrdersDataStore, destination: inout CreateOrderDataStore) {
        print(#function)
        
    }
    
    func passDataToShowOrder(source: ListOrdersDataStore, destination: inout ShowOrderDataStore) {
        print(#function)
        let selectedRow = viewController?.tableView.indexPathForSelectedRow?.row
        destination.order = source.orders?[selectedRow!]
    }
}
