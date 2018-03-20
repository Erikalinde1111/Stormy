//
//  ViewController.swift
//  Stormy
//
//  Created by Pasan Premaratne on 2/15/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var currentHumidityLabel: UILabel!
    @IBOutlet weak var currentPrecipitationLabel: UILabel!
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    @IBOutlet weak var currentSummaryLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    fileprivate let ipKey = "6277fd648941a90480c97befeeefcc4f"
    var tableArray : [String]?
    //allt som har med hämtning från api borde inte ligga i controllern borde ligga i en manager som i MATNYTTIGT
    //även requsten, instansieringen av modelobjecten skall ligga i managern
    //Sortera in koden i model samt controller
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentWeather = CurrentWeather(temperature: 85.5, humidity: 0.4, precipitationProbability: 0.1, summary: "Hot", icon: "clear-day")
        let currentWeatherViewModel = CurrentWeatherViewModel(model: currentWeather)
        displayView(using: currentWeatherViewModel)
        let baseURL = URL(string: "https://api.darksky.net/forecast/\(ipKey)/")
        guard let forecastURL = URL(string: "37.8267,-122.4233", relativeTo: baseURL) else { return }
     
        let configuration = URLSessionConfiguration.default

        let session = URLSession(configuration: configuration)
        
        let request = URLRequest(url: forecastURL)
        
        //borde finnas if satser om det är error, om data == nil
        let dataTask = session.dataTask(with: request){ data, response, error in
            
            guard error == nil else{
                print("returned error "+error.debugDescription)
                return
            }
            
            guard let content = data else {
                print("No data")
                return
            }
            
            guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                print("Not containing JSON")
                return
            }
           
           print(json["currently"])
           
        }
        dataTask.resume()
    }
    
    func displayView(using view: CurrentWeatherViewModel) {
        self.currentTemperatureLabel.text = view.temperature
        self.currentHumidityLabel.text = view.humidity
        self.currentPrecipitationLabel.text = view.precipitationProbability
        self.currentWeatherIcon.image = view.icon
        self.currentSummaryLabel.text = view.summary
        
    }
}
















