//
//  ViewController.swift
//  WeatherAppv2
//
//  Created by Ömer Şahin on 2.07.2019.
//  Copyright © 2019 Ömer Şahin. All rights reserved.
//

import UIKit

class MainController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    private let apiManager = APIManager()
    private let secondapiManager = SecondAPIManager()
    
    var pages : [Page] = []
    
    @objc func getWeather() {
        apiManager.getWeather() { (weather, error) in
            if let error = error {
                print("Get weather error: \(error.localizedDescription)")
                return
            }
            guard let weather = weather  else { return }
            //print("Current Weather Object:")
            //print(weather)
            print("refreshed")
            let cities = ["Moscow","Kiev","London"]
            for i in 0...2 {
                var icon = String(weather.list![i].weather![0].icon!)
                let temp = String(weather.list![i].main!.temp!)
                let humidty = String(Int(weather.list![i].main!.humidity!))
                let pressre = String(Int(weather.list![i].main!.pressure!))
                let tmax = String(weather.list![i].main!.tempMax!)
                let tmin = String(weather.list![i].main!.tempMin!)
                let windsp = String(weather.list![i].wind!.speed!)
                let cityname = cities[i]
                icon.append(".png")
                let exploreitems = Page(imageName: icon , headerText: cityname, bodyText: weather.list![i].weather![0].description!.capitalized, temperature: temp, pressure: pressre, windspeed: windsp, humidity: humidty, maxTemp: tmax, minTemp: tmin )
                self.pages.append(exploreitems)
                //print(self.pages)
                DispatchQueue.main.async {
                      self.refreshControl.endRefreshing()
                }
              
                
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
            
        }
        
        
    }
    

    
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("BACK", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        return button
    }()
    @objc private func handlePrev() {
        let nextIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.mainPink, for: .normal)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    @objc private func handleNext() {
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1 )
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 3
        pc.currentPageIndicatorTintColor = .mainPink
        pc.pageIndicatorTintColor = UIColor(red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
        return pc
    }()
    
    fileprivate func setupBottomControls() {
        
        let bottomControlsStackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually
        
        view.addSubview(bottomControlsStackView)
        
        NSLayoutConstraint.activate([
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
    }
    
    lazy var refreshControl : UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .mainPink
        refreshControl.addTarget(self, action: #selector(getWeather), for: .valueChanged)
        return refreshControl
    }()
        
        
    
    
    private let cellId = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        collectionView.alwaysBounceHorizontal = false
        collectionView.isPagingEnabled = true
        getWeather()
        setupBottomControls()
        collectionView.backgroundColor = UIColor(red: 236/255.0, green: 240/255.0, blue: 241/255.0, alpha: 1.0)
        collectionView.register(ForecastCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.refreshControl = refreshControl
        
        
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ForecastCell
        let page = pages[indexPath.item]
        cell.page = page
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    


}

extension UIColor {
    static var mainPink = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
    static var mainBlue = UIColor(red: 4/255.0, green: 79/255.0, blue: 103/255.0, alpha: 1.0)
}

