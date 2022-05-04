import UIKit

@IBDesignable
class LogoCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var imageView: UIImageView!
    
    @IBInspectable var image: UIImage! { didSet {
        imageView.image = image
    }}

}
