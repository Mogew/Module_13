//
//  ViewController.swift
//  Module_13
//
//  Created by Renat on 27.04.2023.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {
    
    var weatherManager = WeatherManager()

    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
    }


    @IBAction func searchPressed(_ sender: UIButton) {
        print(searchTextField.text)
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            searchTextField.placeholder = "Type city"
            return false
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
    
}

