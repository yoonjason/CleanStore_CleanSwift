//
//  CreateOrderViewController.swift
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

protocol CreateOrderDisplayLogic: class
{
    func displayExpirationDate(viewModel: CreateOrder.FormatExpirationDate.ViewModel)
    func displayCreatedOrder(viewModel: CreateOrder.CreateOrder.ViewModel)
    func displayOrderToEdit(viewModel: CreateOrder.EditOrder.ViewModel)
    func displayOrderToUpdate(viewModel: CreateOrder.UpdateOrder.ViewModel)
}

class CreateOrderViewController: UITableViewController, CreateOrderDisplayLogic
{
    var interactor: CreateOrderBusinessLogic?
    var router: (NSObjectProtocol & CreateOrderRoutingLogic & CreateOrderDataPassing)?


    // MARK: IBOutlet

    @IBOutlet var textFields: [UITextField]!

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!

    // MARK: Payment info
    @IBOutlet weak var billingAddressStreet1TextField: UITextField!
    @IBOutlet weak var billingAddressStreet2TextField: UITextField!
    @IBOutlet weak var billingAddressCityTextField: UITextField!
    @IBOutlet weak var billingAddressStateTextField: UITextField!
    @IBOutlet weak var billingAddressZIPTextField: UITextField!

    @IBOutlet weak var creditCardNumberTextField: UITextField!
    @IBOutlet weak var ccvTextField: UITextField!

    // MARK: Shipping info
    @IBOutlet weak var shipmentAddressStreet1TextField: UITextField!
    @IBOutlet weak var shipmentAddressStreet2TextField: UITextField!
    @IBOutlet weak var shipmentAddressCityTextField: UITextField!
    @IBOutlet weak var shipmentAddressStateTextField: UITextField!
    @IBOutlet weak var shipmentAddressZIPTextField: UITextField!

    // MARK: - Shipping method
    @IBOutlet weak var shippingMethodTextField: UITextField!
    @IBOutlet var shippingMethodPicker: UIPickerView!

    @IBOutlet weak var expirationDateTextField: UITextField!
    @IBOutlet var expirationDatePicker: UIDatePicker!

    @IBAction func expirationDatePickerValueChanged(_ sender: Any) {
        let date = expirationDatePicker.date
        print(date)
        let request = CreateOrder.FormatExpirationDate.Request(date: date)
        interactor?.formatExpirationDate(request: request)
    }
    @IBAction func didTapSave(_ sender: Any) {
        let firstName = firstNameTextField.text!
        let lastName = lastNameTextField.text!
        let phone = phoneTextField.text!
        let email = emailTextField.text!

        let billingAddressStreet1 = billingAddressStreet1TextField.text!
        let billingAddressStreet2 = billingAddressStreet2TextField.text!
        let billingAddressCity = billingAddressCityTextField.text!
        let billingAddressState = billingAddressStateTextField.text!
        let billingAddressZip = billingAddressZIPTextField.text!

        let paymentMethodCreditCardNumber = creditCardNumberTextField.text!
        let paymentMethodCVC = ccvTextField.text!
        let paymentMethodExpirationDate = expirationDatePicker.date
        let paymentMEthodExpirationDateString = ""

        let shipmentAddressStreet1 = shipmentAddressStreet1TextField.text!
        let shipmentAddressStreet2 = shipmentAddressStreet2TextField.text!
        let shipmentAddressCity = shipmentAddressCityTextField.text!
        let shipmentAddressState = shipmentAddressStateTextField.text!
        let shipmentAddressZip = shipmentAddressZIPTextField.text!

        let shipmentMethodSpeed = shippingMethodPicker.selectedRow(inComponent: 0)
        let shipmentMethodSpeedString = ""

        var id: String? = nil
        var date = Date()
        var total = NSDecimalNumber.notANumber
        print(interactor?.orderToEdit)
        if let editToOrder = interactor?.orderToEdit {
            id = editToOrder.id
            date = editToOrder.date
            total = editToOrder.total
            let request = CreateOrder.UpdateOrder.Request(orderFormFields: CreateOrder.OrderFormFields(firstName: firstName, lastName: lastName, phone: phone, email: email, billingAddressStreet1: billingAddressStreet1, billingAddressStreet2: billingAddressStreet2, billingAddressCity: billingAddressCity, billingAddressState: billingAddressState, billingAddressZIP: billingAddressZip, paymentMethodCreditCardNumber: paymentMethodCreditCardNumber, paymentMethodCVV: paymentMethodCVC, paymentMethodExpirationDate: paymentMethodExpirationDate, paymentMethodExpirationDateString: paymentMEthodExpirationDateString, shipmentAddressStreet1: shipmentAddressStreet1, shipmentAddressStreet2: shipmentAddressStreet2, shipmentAddressCity: shipmentAddressCity, shipmentAddressState: shipmentAddressState, shipmentAddressZIP: shipmentAddressZip, shipmentMethodSpeed: shipmentMethodSpeed, shipmentMethodSpeedString: shipmentMethodSpeedString, date: date, total: total))
            interactor?.updateOrder(request: request)
        } else {
            let request = CreateOrder.CreateOrder.Request(orderFormFields: CreateOrder.OrderFormFields(firstName: firstName, lastName: lastName, phone: phone, email: email, billingAddressStreet1: billingAddressStreet1, billingAddressStreet2: billingAddressStreet2, billingAddressCity: billingAddressCity, billingAddressState: billingAddressState, billingAddressZIP: billingAddressZip, paymentMethodCreditCardNumber: paymentMethodCreditCardNumber, paymentMethodCVV: paymentMethodCVC, paymentMethodExpirationDate: paymentMethodExpirationDate, paymentMethodExpirationDateString: paymentMEthodExpirationDateString, shipmentAddressStreet1: shipmentAddressStreet1, shipmentAddressStreet2: shipmentAddressStreet2, shipmentAddressCity: shipmentAddressCity, shipmentAddressState: shipmentAddressState, shipmentAddressZIP: shipmentAddressZip, shipmentMethodSpeed: shipmentMethodSpeed, shipmentMethodSpeedString: shipmentMethodSpeedString, date: date, total: total))
            interactor?.createOrder(request: request)
        }


    }

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }


    // MARK: Setup

    private func setup()
    {
        let viewController = self
        let interactor = CreateOrderInteractor()
        let presenter = CreateOrderPresenter()
        let router = CreateOrderRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    func configurePickers() {
        shippingMethodTextField.inputView = shippingMethodPicker
        expirationDateTextField.inputView = expirationDatePicker
    }

    func showOrderEdit() {

        let request = CreateOrder.EditOrder.Request()
        interactor?.editOrder(request: request)
    }

    // MARK: Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    // MARK: View lifecycle

    override func viewDidLoad()
    {
        super.viewDidLoad()
        configurePickers()
        showOrderEdit()
    }

    func printFile() {
        print(#file)
    }

}

extension CreateOrderViewController {
    func displayExpirationDate(viewModel: CreateOrder.FormatExpirationDate.ViewModel) {
        let date = viewModel.date
        expirationDateTextField.text = date
    }
    func displayCreatedOrder(viewModel: CreateOrder.CreateOrder.ViewModel) {
        if viewModel.order != nil {
            router?.routeToListOrders(segue: nil)
        } else {
            //팝업
            showOrderFailureAlert(title: "Failed to Create Order", message: "Please correct your order and submit again.")
        }
    }

    func displayOrderToEdit(viewModel: CreateOrder.EditOrder.ViewModel) {
        let orderFormFields = viewModel.orderFormFields
        firstNameTextField.text = orderFormFields.firstName
        lastNameTextField.text = orderFormFields.lastName
        phoneTextField.text = orderFormFields.phone
        emailTextField.text = orderFormFields.email

        billingAddressStreet1TextField.text = orderFormFields.billingAddressStreet1
        billingAddressStreet2TextField.text = orderFormFields.billingAddressStreet2
        billingAddressCityTextField.text = orderFormFields.billingAddressCity
        billingAddressZIPTextField.text = orderFormFields.billingAddressZIP
        billingAddressStateTextField.text = orderFormFields.billingAddressState

        shipmentAddressStreet2TextField.text = orderFormFields.shipmentAddressStreet2
        shipmentAddressCityTextField.text = orderFormFields.shipmentAddressCity
        shipmentAddressStateTextField.text = orderFormFields.shipmentAddressState
        shipmentAddressZIPTextField.text = orderFormFields.shipmentAddressZIP
        shippingMethodPicker.selectRow(orderFormFields.shipmentMethodSpeed, inComponent: 0, animated: true)
        shippingMethodTextField.text = orderFormFields.shipmentMethodSpeedString
        expirationDatePicker.date = orderFormFields.paymentMethodExpirationDate
        expirationDateTextField.text = orderFormFields.paymentMethodExpirationDateString
    }

    func displayOrderToUpdate(viewModel: CreateOrder.UpdateOrder.ViewModel) {
        if viewModel.order != nil {
            router?.routeToShowOrder(segue: nil)
        } else {
            showOrderFailureAlert(title: "Failed to update order", message: "Please correct your order and submit again.")
        }
    }
}

extension CreateOrderViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let cell = tableView.cellForRow(at: indexPath) {
            for textField in textFields {
                if textField.isDescendant(of: cell) {
                    textField.becomeFirstResponder()
                }
            }
        }
    }
}


extension CreateOrderViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let index = textFields.firstIndex(of: textField) {
            if index < textFields.count - 1 {
                let nextTextfield = textFields[index + 1]
                nextTextfield.becomeFirstResponder()
            }
        }
        return true
    }

}

extension CreateOrderViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return interactor?.shippingMethods[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        shippingMethodTextField.text = interactor?.shippingMethods[row]
    }

}

extension CreateOrderViewController: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return interactor?.shippingMethods.count ?? 0
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}

extension CreateOrderViewController {
    private func showOrderFailureAlert(title: String, message: String)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        showDetailViewController(alertController, sender: nil)
    }
}
