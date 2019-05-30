//
//  menuViewController.swift
//  DemoVietComBank
//
//  Created by Đặng Khánh  on 5/29/19.
//  Copyright © 2019 Khánh Trắng. All rights reserved.
//

import UIKit

class menuViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var icon = [IconMenu]()
    var newEventImages = [String]()
    @IBOutlet weak var mycollectionView: UICollectionView!
    @IBOutlet weak var collectionViewFlowLayout: CollectionFlowLayout!
    let WIDTH_SCREEN = UIScreen.main.bounds.width
    // so item
    let numberOfItems: CGFloat = 3
    // khoang cach giua cac item
    let padding: CGFloat = 45
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mycollectionView.delegate = self
        mycollectionView.dataSource = self
        let itemSize = UIScreen.main.bounds.width / 4
        collectionViewFlowLayout.itemSize = CGSize(width: itemSize, height: itemSize)
        icon = [
            IconMenu(image: UIImage(named: "home")!),
            IconMenu(image: UIImage(named: "menu")!),
            IconMenu(image: UIImage(named: "settings")!),
            IconMenu(image: UIImage(named: "search")!),
            IconMenu(image: UIImage(named: "letter")!),
            
        ]
        let flowlayout = mycollectionView.collectionViewLayout as!UICollectionViewFlowLayout
        flowlayout.itemSize = CGSize(width: itemSize, height: itemSize / 3.5)
        flowlayout.sectionInset = UIEdgeInsets(top: padding, left: 0, bottom: padding, right: 0)
        flowlayout.minimumInteritemSpacing = padding
        flowlayout.minimumLineSpacing = padding
        
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return icon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mycollectionView.dequeueReusableCell(withReuseIdentifier: "cellmenu", for: indexPath) as! menuCollectionViewCell
        cell.images.image = icon[indexPath.row].image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let totalCellWidth = 80 * collectionView.numberOfItems(inSection: 0)
        let totalSpacingWidth = 10 * (collectionView.numberOfItems(inSection: 0) - 1)
        
        let leftInset = (collectionView.layer.frame.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
        
    }
}

class CollectionFlowLayout: UICollectionViewFlowLayout {
    // Scolling Velocity là vuốt theo tốc độ vào.vuốt lên hay vuốt xuống
    // minimumLineSpacing là khoảng cách giữa thằng trên với thằng dưới
    // minimumInteritemSpacing là khoảng cách giữa 2 thằng cạnh nhau
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        // vuốt theo chiều ngang
        let pageSize = self.itemSize.width + minimumInteritemSpacing
        // tính page đang gần cái page thứ bao nhiêu nhất
        // contentOffset là nội dung đang nằm ở toạ độ bao nhiêu
        let approximatePage = self.collectionView!.contentOffset.x/pageSize
        //velocity là vận tốc
        //nếu như là vận tốc theo chiều dương (mình muốn vuốt ngnang)
        let currentPage = (velocity.x < 0.0) ? floor(approximatePage) : ceil(approximatePage)
        let flickVelocity = velocity.x * 0.2
        let flickedPages = (abs(round(flickVelocity)) <= 1) ? 0 :
            round(flickVelocity)
        // offset là chỉnh không.
        let newVerticalOffset = ((currentPage + flickedPages) * pageSize) - self.collectionView!.contentInset.top
        // nó chạy theo chiều x thì x của mình là new
        return CGPoint(x: newVerticalOffset, y: proposedContentOffset.y)
        
    }
    
    
    
    
    
    
}








