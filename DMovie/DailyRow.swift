//
//  CategoryRow.swift
//  DMovie
//
//  Created by 김건영 on 2020/12/26.
//

import UIKit

class DailyRow: UITableViewCell {
    let hardCodedPadding:CGFloat = 5
    var viewcontroller: UIViewController!
}

extension DailyRow: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dailyThumbnailCell", for: indexPath)
    
        let image: UIImage
        
        image = HttpManager().loadThumbnailImage(BoxOffice.shared.dailyRankList[indexPath.row].imageUrl!)
        
        let imageView = UIImageView(image: image)
        imageView.frame.size = CGSize(width: image.size.width, height: image.size.height + hardCodedPadding * 2)
        cell.addSubview(imageView)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return BoxOffice.shared.dailyRankList.count
    }
}

extension DailyRow: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mdvc = self.viewcontroller.storyboard?.instantiateViewController(identifier: "movie_detail") as! MovieDetailViewController
        mdvc.mvo = BoxOffice.shared.dailyRankList[indexPath.row]
        
        
        self.viewcontroller.navigationController?.pushViewController(mdvc, animated: true)
    }
}

extension DailyRow: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = HttpManager().loadThumbnailImage(BoxOffice.shared.dailyRankList[indexPath.row].imageUrl!).size.width
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
