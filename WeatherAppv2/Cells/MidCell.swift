//
//  DayForecastCell.swift
//  WeatherApp
//
//  Created by Ömer Şahin on 26.06.2019.
//  Copyright © 2019 Ömer Şahin. All rights reserved.
//

import UIKit

class MidCell : UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    
    var predict : [Forecast] = []
    private let secondapiManager = SecondAPIManager()
    
    func secondgetWeather() {
        secondapiManager.secondgetWeather() { (weather, error) in
            if let error = error {
                print("Get weather error: \(error.localizedDescription)")
                return
            }
            guard let weather = weather  else { return }
            //print("Current Weather Object:")
            //print(weather)
            for i in 0 ... 39 {
                var icon = String(weather.list![i].weather![0].icon!)
                let temp = String(weather.list![i].main!.temp!)
                let unixtimeInterval = Double(weather.list![i].dt!)
                let date = Date(timeIntervalSince1970: unixtimeInterval)
                let dateFormatter = DateFormatter()
                dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
                dateFormatter.locale = NSLocale.current
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" //Specify your format that you want
                let strDate = dateFormatter.string(from: date)
                let index = strDate.index(strDate.endIndex, offsetBy: -5)
                let mySubstring = strDate[index...] // playground
                icon.append(".png")
                let exploreitems = Forecast(imageName: icon, headerText: temp, bodyText: String(mySubstring))
                self.predict.append(exploreitems)
                //print(self.predict)
                
            }
            DispatchQueue.main.async {
                self.appCollView.reloadData()
            }
            
            
        }
        
        
    }
    private let DcellId = "appCellId"
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        setupV()
        secondgetWeather()
    }
    required init?(coder aDecoder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    let appCollView : UICollectionView = {
        var lay = UICollectionViewFlowLayout()
        lay.scrollDirection = .horizontal
        let collView = UICollectionView(frame: .zero, collectionViewLayout: lay)
        collView.backgroundColor = UIColor(red: 236/255.0, green: 240/255.0, blue: 241/255.0, alpha: 1.0)
        collView.translatesAutoresizingMaskIntoConstraints = false
        return collView
    }()
    func setupV() {
        backgroundColor = UIColor(patternImage: UIImage(named: "scroll.png")!)
        addSubview(appCollView)
        
        appCollView.dataSource = self
        appCollView.delegate = self
        
        appCollView.register(AppCell.self, forCellWithReuseIdentifier: DcellId)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": appCollView]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": appCollView]))
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return predict.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DcellId, for: indexPath) as! AppCell
        let page = predict[indexPath.item]
        cell.page = page
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: frame.height)
    }
}
class AppCell : UICollectionViewCell, UICollectionViewDelegateFlowLayout {
    
    var page : Forecast? {
        didSet {
            guard let unwrappedPage = page else { return}
            imageView.image = UIImage(named: page!.imageName)
            var Kelvin = Double(unwrappedPage.headerText)
            Kelvin = (Kelvin ?? 0) - 273
            var predictCelcius = "\(Int(Kelvin ?? 0))"
            predictCelcius.append("°C")
            descriptionLabel.text = predictCelcius
            hourLabel.text = unwrappedPage.bodyText
            
        }
    }
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        sView()
    }
    required init?(coder aDecoder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "03d.png")
        iv.contentMode = .scaleAspectFit
        
        return iv
        
    }()
    let descriptionLabel : UILabel = {
        let label = UILabel()
        label.text = "Yağmurlu"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    let hourLabel : UILabel = {
        let label = UILabel()
        label.text = "time"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    func sView() {
        backgroundColor = UIColor(red: 236/255.0, green: 240/255.0, blue: 241/255.0, alpha: 1.0)
        addSubview(hourLabel)
        addSubview(imageView)
        addSubview(descriptionLabel)
        hourLabel.frame = CGRect(x: 0, y: 10, width: frame.width, height: 20)
        imageView.frame = CGRect(x: 0, y: 30, width: frame.width, height: 70)
        descriptionLabel.frame = CGRect(x: 0, y: 100, width: frame.width, height: 20)
    }
}

