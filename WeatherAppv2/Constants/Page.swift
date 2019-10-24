//
//  Pag.swift
//  WeatherApp
//
//  Created by Ömer Şahin on 1.07.2019.
//  Copyright © 2019 Ömer Şahin. All rights reserved.
//

import Foundation

struct Page {
    let imageName: String
    let headerText: String
    let bodyText: String
    var temperature : String
    let pressure : String
    let windspeed : String
    let humidity : String
    let maxTemp: String
    let minTemp: String
}
struct ExploreItems {
    var cityName : String
}

struct Forecast {
    let imageName: String
    let headerText: String
    let bodyText: String
}

