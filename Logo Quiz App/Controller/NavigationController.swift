import Foundation
import UIKit

class NavigationController: UINavigationController
{
    override var preferredStatusBarStyle : UIStatusBarStyle
    {
        if let topVC = viewControllers.last { return topVC.preferredStatusBarStyle }
        return .lightContent
    }
}
