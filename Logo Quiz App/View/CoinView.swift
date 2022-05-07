import UIKit

@IBDesignable
class CoinView: UIView
{
    @IBOutlet weak var coinImageView: UIImageView!
    @IBOutlet weak var coinLabel: UILabel!
    
    @IBInspectable var coinImage: UIImage? { didSet {
        coinImageView.image = coinImage
    }}
    
    @IBInspectable var coinValue: Int = 0 { didSet {
        coinLabel.text = "\(coinValue)"
    }}
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
        loadNib()
    }
    
    @discardableResult func loadNib() -> UIView
    {
        let bundle = Bundle(for: CoinView.self)
        let view = bundle.loadNibNamed(String(describing: CoinView.self), owner: self, options: nil)![0] as! UIView
        view.frame = self.bounds
        addSubview(view)
        return view
    }
}
