//
//  DetailForecastCell.swift
//  WeatherApp
//
//  Created by Ömer Şahin on 1.07.2019.
//  Copyright © 2019 Ömer Şahin. All rights reserved.
//

import UIKit

class BottomCell : UICollectionViewCell, UICollectionViewDelegateFlowLayout{
    var page : Page? {
        didSet {
            guard let unwrappedPage = page else { return}
            let tempmin = "   Temperature Minimum:    \(unwrappedPage.minTemp)°C"
            let tempmax = "   Temperature Maximum:    \(unwrappedPage.maxTemp)°C"
            let humidity = "   Humidity:    \(unwrappedPage.humidity)"
            let pressure = "   Pressure:    \(unwrappedPage.pressure)"
            let windspeed = "   Wind Speed:    \(unwrappedPage.windspeed)"
            cityLabel.text = tempmin
            tempLabel.text = tempmax
            descriptionLabel.text = humidity
            pressureLabel.text = pressure
            windLabel.text = windspeed
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let appCollectionView : UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(red: 236/255.0, green: 240/255.0, blue: 241/255.0, alpha: 1.0)
        
        return collectionView
    }()
    let cityLabel : UILabel = {
        let label = UILabel()
        label.text = "İstanbul"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.mainPink
        label.textAlignment = .center
        return label
        
    }()
    let tempLabel : UILabel = {
        let label = UILabel()
        label.text = "29"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.mainPink
        label.textAlignment = .center
        return label
    }()
    
    let descriptionLabel : UILabel = {
        let label = UILabel()
        label.text = "time"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.mainBlue
        label.textAlignment = .center
        return label
    }()
    
    let pressureLabel : UILabel = {
        let label = UILabel()
        label.text = "time"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.mainBlue
        label.textAlignment = .center
        return label
    }()
    
    let windLabel : UILabel = {
        let label = UILabel()
        label.text = "time"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.mainBlue
        label.textAlignment = .center
        return label
    }()
    
    func setupViews() {
        backgroundColor = UIColor(red: 236/255.0, green: 240/255.0, blue: 241/255.0, alpha: 1.0)
        addSubview(cityLabel)
        addSubview(tempLabel)
        addSubview(descriptionLabel)
        addSubview(pressureLabel)
        addSubview(windLabel)
        
        
        cityLabel.frame = CGRect(x: 0, y: 0, width: frame.width, height: 30)
        tempLabel.frame = CGRect(x: 0, y: 60, width: frame.width, height: 30)
        descriptionLabel.frame = CGRect(x: 0, y: 120, width: frame.width, height: 30)
        pressureLabel.frame = CGRect(x: 0, y: 180, width: frame.width, height: 30)
        windLabel.frame = CGRect(x: 0, y: 240, width: frame.width, height: 30)
        
    }
    
    
    
}


