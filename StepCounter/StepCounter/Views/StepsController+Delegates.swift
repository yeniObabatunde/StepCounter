import Foundation
import UIKit

extension StepCountViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("cell tapped")
    }
}

extension StepCountViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return acheivementData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AchievementCollectionCells.cellIdentifier, for: indexPath) as? AchievementCollectionCells
        cell?.contentMode = .center
        cell?.updateCell(with: acheivementData[indexPath.row])
        
        return cell ?? UICollectionViewCell()
    }
    
    
}

extension StepCountViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt index : IndexPath) -> CGSize {
        var width = 0.0
        if
            acheivementData.count == 1 {
            width = acheivementCollectionView.frame.size.width
        } else if
            acheivementData.count == 2 {
            width = acheivementCollectionView.frame.size.width/2
        }
        else {
            width = acheivementCollectionView.frame.size.width / 2.7
        }
        return CGSize(width: width , height: acheivementCollectionView.frame.size.height)
    }
    
}

extension StepCountViewController {
    func setUpNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = Constants.Colors.blackColor
        navigationItem.title = Constants.NavigationTitle.title
        self.navigationController?.navigationBar.tintColor = Constants.Colors.blackColor
        self.navigationController?.navigationBar.backgroundColor = Constants.Colors.blackColor
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
}

