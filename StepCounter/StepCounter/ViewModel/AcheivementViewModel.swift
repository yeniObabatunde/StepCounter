import UIKit

final class AcheivementViewModel {
    
    var achievementPresenter: AcheivementModels?
    
    func presentCollectionCells() -> [AcheivementModels] {
        
                return [AcheivementModels(images: Constants.Images.noAcheivement, achievementBadge: Constants.AchievementCollectionCellStrings.noacheivmentYet, achievementMileStone: Constants.AchievementCollectionCellStrings.keepWalking),
                 AcheivementModels(images: Constants.Images.displayImage, achievementBadge: Constants.AchievementCollectionCellStrings.goals, achievementMileStone: "10k"),
                 AcheivementModels(images: Constants.Images.secondImage, achievementBadge: Constants.AchievementCollectionCellStrings.goals, achievementMileStone: "15k"),
                 AcheivementModels(images: Constants.Images.thirdImage, achievementBadge: Constants.AchievementCollectionCellStrings.goals, achievementMileStone: "20k"),
                 AcheivementModels(images: Constants.Images.fourthImage, achievementBadge: Constants.AchievementCollectionCellStrings.goals, achievementMileStone: "25k"),
                 AcheivementModels(images: Constants.Images.fifthImage, achievementBadge: Constants.AchievementCollectionCellStrings.goals, achievementMileStone: "30k"),
                 AcheivementModels(images: Constants.Images.sixthImage, achievementBadge: Constants.AchievementCollectionCellStrings.goals, achievementMileStone: "35k"),
                 AcheivementModels(images: Constants.Images.seventhImage, achievementBadge: Constants.AchievementCollectionCellStrings.goals, achievementMileStone: "40k")
                ]
    }
}
