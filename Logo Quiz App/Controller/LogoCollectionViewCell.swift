import UIKit

@IBDesignable
class LogoCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var indicatorImageView: UIImageView!
    
    @IBInspectable var image: UIImage! { didSet {
        imageView.image = image
    }}
    
    @IBInspectable var indicatorImage: UIImage! { didSet {
        indicatorImageView.image = indicatorImage
    }}

}
