//
//  TreeCell.swift
//  WeatherAppv2
//
//  Created by Ömer Şahin on 2.07.2019.
//  Copyright © 2019 Ömer Şahin. All rights reserved.
//

import UIKit

class TopCell : UICollectionViewCell, UICollectionViewDelegateFlowLayout{
    var page : Page? {
        didSet {
            guard var unwrappedPage = page else { return}
            imageView.image = UIImage(named: page!.imageName)
            cityLabel.text = unwrappedPage.headerText
            unwrappedPage.temperature.append("°C")
            tempLabel.text = unwrappedPage.temperature
            descriptionLabel.text = unwrappedPage.bodyText
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "11d.png")
        iv.contentMode = .scaleAspectFill
        return iv
        
    }()
    let appCollectionView : UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.blue
        
        return collectionView
    }()
    let cityLabel : UILabel = {
        let label = UILabel()
        label.text = "İstanbul"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = UIColor.mainPink
        label.textAlignment = .center
        return label
        
    }()
    let tempLabel : UILabel = {
        let label = UILabel()
        label.text = "29"
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = .darkGray
        label.textAlignment = .center
        return label
    }()
    
    let descriptionLabel : UILabel = {
        let label = UILabel()
        label.text = "time"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    func setupViews() {
        backgroundColor = UIColor(red: 236/255.0, green: 240/255.0, blue: 241/255.0, alpha: 1.0)
        addSubview(imageView)
        addSubview(cityLabel)
        addSubview(tempLabel)
        addSubview(descriptionLabel)
        
        imageView.frame = CGRect(x: 162, y: 60, width: 100, height: 100)
        cityLabel.frame = CGRect(x: 0, y: 180, width: frame.width, height: 30)
        tempLabel.frame = CGRect(x: 0, y: 220, width: frame.width, height: 25)
        descriptionLabel.frame = CGRect(x: 0, y: 260, width: frame.width, height: 20)
        
    }
    
    
    
}
