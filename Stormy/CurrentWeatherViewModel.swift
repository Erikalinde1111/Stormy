//
//  CurrentWeatherViewModel.swift
//  Stormy
//
//  Created by Erika Linde on 2018-03-13.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation
import UIKit

struct CurrentWeatherViewModel {
    let temperature: String
    let humidity: String
    let precipitationProbability: String
    let summary: String
    let icon: UIImage
    
    init(model: CurrentWeather){
        let roundedTemperature = Int(model.temperature)
        self.temperature = "\(roundedTemperature)"
        
        let humidityPercentage = Int(model.humidity * 100)
        self.humidity = "\(humidityPercentage)%"
        
        let precipitationProbabilityPercentage = Int(model.precipitationProbability * 100)
        self.precipitationProbability = "\(precipitationProbabilityPercentage)%"
        
        self.summary = model.summary
        let weatherIcon = WeatherIcon(iconString: model.icon)
        self.icon = weatherIcon.image
    }
}
