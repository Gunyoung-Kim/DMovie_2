//
//  WeeklyRow.swift
//  DMovie
//
//  Created by 김건영 on 2021/01/01.
//

import UIKit

class WeeklyRow: UITableViewCell {
    let hardCodedPadding:CGFloat = 5
    var viewcontroller: UIViewController!
}

extension WeeklyRow: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weeklyThumbnailCell", for: indexPath)
    
        let image: UIImage
        
        image = HttpManager().loadThumbnailImage(BoxOffice.shared.weeklyRankList[indexPath.row].imageUrl!)
        
        let imageView = UIImageView(image: image)
        imageView.frame.size = CGSize(width: image.size.width, height: image.size.height + hardCodedPadding * 2)
        cell.addSubview(imageView)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return BoxOffice.shared.weeklyRankList.count
    }
}

extension WeeklyRow: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mdvc = self.viewcontroller.storyboard?.instantiateViewController(identifier: "movie_detail") as! MovieDetailViewController
        mdvc.mvo = BoxOffice.shared.weeklyRankList[indexPath.row]
        
        self.viewcontroller.navigationController?.pushViewController(mdvc, animated: true)
    }
}

extension WeeklyRow: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = HttpManager().loadThumbnailImage(BoxOffice.shared.weeklyRankList[indexPath.row].imageUrl!).size.width
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
