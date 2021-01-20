//
//  ScreeningRow.swift
//  DMovie
//
//  Created by 김건영 on 2021/01/20.
//

import UIKit

class ScreeningRow: UITableViewCell {
    let hardCodedPadding:CGFloat = 5
    var viewcontroller: UIViewController!
}

extension ScreeningRow: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "screeningThumbnailCell", for: indexPath)
    
        let image: UIImage
        
        image = HttpManager().loadThumbnailImage(BoxOffice.shared.screeningList[indexPath.row].imageUrl!)
        
        let imageView = UIImageView(image: image)
        imageView.frame.size = CGSize(width: image.size.width, height: image.size.height + hardCodedPadding * 2)
        imageView.layer.cornerRadius = imageView.frame.width / 12
        imageView.layer.masksToBounds = true
        cell.addSubview(imageView)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return BoxOffice.shared.screeningList.count
    }
}

extension ScreeningRow: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mdvc = self.viewcontroller.storyboard?.instantiateViewController(identifier: "movie_detail") as! MovieDetailViewController
        mdvc.mvo = BoxOffice.shared.screeningList[indexPath.row]
        
        self.viewcontroller.navigationController?.pushViewController(mdvc, animated: true)
    }
}

extension ScreeningRow: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = HttpManager().loadThumbnailImage(BoxOffice.shared.screeningList[indexPath.row].imageUrl!).size.width
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

