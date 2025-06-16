import UIKit

extension UIImageView {
    
    func makeImageRounded() {
        self.layer.cornerRadius = self.frame.size.height / 2
        self.clipsToBounds = true
    }
}

