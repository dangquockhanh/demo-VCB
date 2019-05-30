//
//  ViewController.swift
//  DemoVietComBank
//
//  Created by Đặng Khánh  on 5/27/19.
//  Copyright © 2019 Khánh Trắng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var timer: Timer?

    var photo = [Photo]()
    
  
    
        let WIDTH_SCREEN = UIScreen.main.bounds.width
        let numberOfItems: CGFloat = 1
        let padding: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photo = [
            Photo(images: UIImage(named: "1")!),
            Photo(images: UIImage(named: "2")!),
            Photo(images: UIImage(named: "3")!)
        ]
        
        myCollectionView.reloadData()
        startTimer()
       
    }
    
// MARK: - animation photo header using Timer
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(scrollAutomatically), userInfo: nil, repeats: true)
    }
    
//MARK: - condition animation photo header
    @objc func scrollAutomatically(_ timer1: Timer) {
        for cell in myCollectionView.visibleCells {
            if photo.count == 1 {
                return
            }
            let indexPath = myCollectionView.indexPath(for: cell)!
            if indexPath.row < (photo.count - 1) {
                let indexPath1 = IndexPath.init(row: indexPath.row + 1, section: indexPath.section)
                myCollectionView.scrollToItem(at: indexPath1, at: .right, animated: true)
                pageControl.currentPage = indexPath1.row
            }
            else {
                let indexPath1 = IndexPath.init(row: 0, section: indexPath.section)
                myCollectionView.scrollToItem(at: indexPath1, at: .left, animated: true)
                pageControl.currentPage = indexPath1.row
            }
        }
    }
    
//MARK: - Collection VIew
  
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
      return  photo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.imageCell.image = photo[indexPath.row].images
        cell.pageControl.numberOfPages = photo.count
        return cell
    }

}

//MARK: - Size of Item
extension ViewController: UICollectionViewDelegateFlowLayout {
    //Calculator Item Collection View
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (WIDTH_SCREEN - padding * 2 - padding * (numberOfItems - 1))/numberOfItems
        return CGSize(width: itemSize, height: itemSize)
    }
    
    // Spacing Between Each Edge Of Section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: padding, left: 0, bottom: padding, right: 0)
    }
    
    // Spacing Between Rows Of Section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return padding
    }
    
    //    Spacing Between Colums Of Section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return padding
    }
}



