import Foundation
import UIKit

protocol AchievementCollectionCellsDelegate: AnyObject {
    func removeItem(at index: Int)
}

class AchievementCollectionCells: UICollectionViewCell {
    
    static let cellIdentifier = "AchievementCollectionCells"
    
    weak var delegate: AchievementCollectionCellsDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Constants.Colors.blackColor
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var  achievementLogo: UIImageView = {
        var achievementLogo = UIImageView(frame: CGRect(x: 0, y: 0, width: 116, height: 116))
        achievementLogo.image = UIImage(named: Constants.Images.displayImage)
        achievementLogo.contentMode = .scaleAspectFill
        achievementLogo.clipsToBounds = true
        achievementLogo.translatesAutoresizingMaskIntoConstraints = false
       return achievementLogo
    }()
    
    lazy var goalAchievementText: UILabel = {
        var goalAcheievementText = UILabel()
        goalAcheievementText.text = Constants.AchievementCollectionCellStrings.goals
        goalAcheievementText.numberOfLines = 2
        goalAcheievementText.textAlignment = .center
        goalAcheievementText.textColor = Constants.Colors.whiteColor
        goalAcheievementText.font = UIFont(name: Constants.Fonts.SFProDisplay, size: 16)
        goalAcheievementText.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
       return goalAcheievementText
    }()
    
    lazy var acheivementBenchmarkNumber: UILabel = {
        var acheivementBenchmarkNumber = UILabel()
        acheivementBenchmarkNumber.text = "10k Steps"
        acheivementBenchmarkNumber.textColor = Constants.Colors.grayedColor
        acheivementBenchmarkNumber.textAlignment = .center
        acheivementBenchmarkNumber.font = UIFont(name: Constants.Fonts.SFProDisplay, size: 13.7)
       return acheivementBenchmarkNumber
    }()
    
    
    func configureCell() {
        contentView.addSubview( achievementLogo)
        contentView.addSubview(goalAchievementText)
        contentView.addSubview(acheivementBenchmarkNumber)
        
        configureAchievementLogo()
        configureGoalAchievmentText()
        configureAcheivementBenchmark()
    }
    
    func configureAchievementLogo() {
         achievementLogo.snp.makeConstraints({ make in
            make.top.equalTo(contentView.snp.top)
             make.width.height.equalTo(116)
            make.centerX.equalTo(contentView.snp.centerX)
        })
        achievementLogo.layer.cornerRadius = 58
    }
    
    func configureGoalAchievmentText() {
        goalAchievementText.snp.makeConstraints({ make in
            make.top.equalTo(achievementLogo.snp.bottom).offset(6)
            make.centerX.equalTo(contentView.snp.centerX)
        })
    }

    func configureAcheivementBenchmark() {
        acheivementBenchmarkNumber.snp.makeConstraints({ make in
            make.top.equalTo(goalAchievementText.snp.bottom).offset(1)
            make.centerX.equalTo(contentView.snp.centerX)
        })
    }
    
    func updateCell(with presentCollectionCell: AcheivementModels) {
        achievementLogo.image = UIImage(named: presentCollectionCell.images)
        goalAchievementText.text = presentCollectionCell.achievementBadge
        acheivementBenchmarkNumber.text = presentCollectionCell.achievementMileStone
    }
}
