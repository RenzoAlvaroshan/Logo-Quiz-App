import UIKit

@IBDesignable
class LogoCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var indicatorImageView: UIImageView!
    
    @IBInspectable var image: UIImage! { didSet {
        imageView.image = image
    }}
    
    @IBInspectable var indicatorImage: UIImage! { didSet {
        indicatorImageView.image = indicatorImage
    }}
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            self.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
            self.alpha = 0.8
        })
        super.touchesBegan(touches, with: event)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.alpha = 1
        })
        super.touchesEnded(touches, with: event)
    }

}
