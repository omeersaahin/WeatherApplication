//
//  ForecastCell.swift
//  WeatherAppv2
//
//  Created by Ömer Şahin on 2.07.2019.
//  Copyright © 2019 Ömer Şahin. All rights reserved.
//

import UIKit  

class ForecastCell : UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    private let cellId = "cellId"
    private let mcellId = "mcellId"
    private let bcellId = "bcellId"
    
    var Forecastitem : [Page] = []
    var page : Page? {
        didSet {
            guard let unwrappedPage = page else { return}
            let ForecastItems = Page(imageName: unwrappedPage.imageName, headerText: unwrappedPage.headerText, bodyText: unwrappedPage.bodyText, temperature: unwrappedPage.temperature, pressure: unwrappedPage.pressure, windspeed: unwrappedPage.windspeed, humidity: unwrappedPage.humidity, maxTemp: unwrappedPage.maxTemp, minTemp: unwrappedPage.minTemp)
            Forecastitem.append(ForecastItems)
            
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let appCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = UIColor(red: 236/255.0, green: 240/255.0, blue: 241/255.0, alpha: 1.0)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    func setupViews() {
        backgroundColor = UIColor(red: 236/255.0, green: 240/255.0, blue: 241/255.0, alpha: 1.0)
        addSubview(appCollectionView)
        
        appCollectionView.dataSource = self
        appCollectionView.delegate = self
        appCollectionView.register(TopCell.self, forCellWithReuseIdentifier: cellId)
        appCollectionView.register(MidCell.self, forCellWithReuseIdentifier: mcellId)
        appCollectionView.register(BottomCell.self, forCellWithReuseIdentifier: bcellId)
        
        
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": appCollectionView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": appCollectionView]))
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mcellId, for: indexPath) as! MidCell
            return cell
        }
        else if indexPath.item == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bcellId, for: indexPath) as! BottomCell
            let page = Forecastitem[0]
            cell.page = page
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TopCell
        let page = Forecastitem[indexPath.item]
        cell.page = page
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 1  {
            return CGSize(width: frame.width, height: 150)
        }
        else if indexPath.item == 0{
            return CGSize(width: frame.width, height: 300)
        }
        
        return CGSize(width: frame.width, height: 496)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

