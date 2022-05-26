import Foundation
import UIKit

@IBDesignable
class LevelProgressControl: UIControl
{
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var accentView: UIView!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var lockedView: UIView!
    @IBOutlet weak var lockedLabel: UILabel!
    
    @IBInspectable var accentColor: UIColor! { didSet {
        accentView.backgroundColor = accentColor
    }}
    
    @IBInspectable var level: Int = 0 { didSet {
        levelLabel.text = "Level \(level)"
    }}
    
    @IBInspectable var valueNow: Int = 0 { didSet {
        let percentage = valueMax == 0 ? 100.0 : 100.0 * Double(valueNow) / Double(valueMax)
        percentageLabel.text = String(format: "%0.0f%%", percentage)
        progressLabel.text = String(format: "%d/%d", valueNow, valueMax)
    }}
    
    @IBInspectable var valueMax: Int = 0 { didSet {
        let percentage = valueMax == 0 ? 100.0 : 100.0 * Double(valueNow) / Double(valueMax)
        percentageLabel.text = String(format: "%0.0f%%", percentage)
        progressLabel.text = String(format: "%d/%d", valueNow, valueMax)
    }}
    
    @IBInspectable var requirementLogoSolved: Int = 0 { didSet {
        lockedLabel.text = "Solved \(requirementLogoSolved) logos to unlock this level";
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
        let bundle = Bundle(for: LevelProgressControl.self)
        let view = bundle.loadNibNamed(String(describing: LevelProgressControl.self), owner: self, options: nil)![0] as! UIView
        view.frame = self.bounds
        addSubview(view)
        return view
    }
    
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
