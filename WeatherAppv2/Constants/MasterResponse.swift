//
//  MasterResponse.swift
//  Codable
//
//  Created by Ömer Şahin on 21.06.2019.
//  Copyright © 2019 Ömer Şahin. All rights reserved.
//

import Foundation

struct CurrentWeather : Codable {
    let cnt : Int?
    let list : [List]?
    
    enum CodingKeys: String, CodingKey {
        
        case cnt
        case list
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cnt = try values.decodeIfPresent(Int.self, forKey: .cnt)
        list = try values.decodeIfPresent([List].self, forKey: .list)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(cnt, forKey: .cnt)
        try container.encodeIfPresent(list, forKey: .list)
        
    }
    
    
    
    
}
struct Clouds : Codable {
    let all : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case all
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        all = try values.decodeIfPresent(Int.self, forKey: .all)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(all, forKey: .all)
    }
    
}

struct List : Codable {
    let weather : [Weather]?
    let main : Main?
    let wind : Wind?
    let clouds : Clouds?
    let dt : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case coord
        case sys
        case weather
        case main
        case wind
        case clouds
        case dt
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        weather = try values.decodeIfPresent([Weather].self, forKey: .weather)
        main = try values.decodeIfPresent(Main.self, forKey: .main)
        wind = try values.decodeIfPresent(Wind.self, forKey: .wind)
        clouds = try values.decodeIfPresent(Clouds.self, forKey: .clouds)
        dt = try values.decodeIfPresent(Int.self, forKey: .dt)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(weather, forKey: .weather)
        try container.encodeIfPresent(main, forKey: .main)
        try container.encode(wind, forKey: .wind)
        try container.encodeIfPresent(clouds, forKey: .clouds)
        try container.encodeIfPresent(dt, forKey: .dt)
    }
    
}
struct Main : Codable {
    let temp : Double?
    let pressure : Double?
    let humidity : Double?
    let tempMin : Double?
    let tempMax : Double?
    
    private enum CodingKeys: String, CodingKey {
        
        case temp
        case pressure
        case humidity
        case tempMin = "tempMin"
        case tempMax = "tempMax"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        temp = try values.decodeIfPresent(Double.self, forKey: .temp)
        pressure = try values.decodeIfPresent(Double.self, forKey: .pressure)
        humidity = try values.decodeIfPresent(Double.self, forKey: .humidity)
        tempMin  = try values.decodeIfPresent(Double.self, forKey: .tempMin)
        tempMax = try values.decodeIfPresent(Double.self, forKey: .tempMax)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(temp, forKey: .temp)
        try container.encodeIfPresent(pressure, forKey: .pressure)
        try container.encode(humidity, forKey: .humidity)
        try container.encodeIfPresent(tempMin, forKey: .tempMin)
        try container.encodeIfPresent(tempMax, forKey: .tempMax)
    }
}

struct Weather : Codable {
    let id : Int?
    let main : String?
    let description : String?
    let icon : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case main = "main"
        case description = "description"
        case icon = "icon"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        main = try values.decodeIfPresent(String.self, forKey: .main)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        icon = try values.decodeIfPresent(String.self, forKey: .icon)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(main, forKey: .main)
        try container.encode(description, forKey: .description)
        try container.encodeIfPresent(icon, forKey: .icon)
    }
    
    
}
struct Wind : Codable {
    let speed : Double?
    let deg : Double?
    
    enum CodingKeys: String, CodingKey {
        
        case speed
        case deg
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        speed = try values.decodeIfPresent(Double.self, forKey: .speed)
        deg = try values.decodeIfPresent(Double.self, forKey: .deg)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(speed, forKey: .speed)
        try container.encode(deg, forKey: .deg)
    }
    
    
}



