import Foundation
import UIKit

@IBDesignable
class LevelProgressControl: UIControl
{
    @IBOutlet weak var accentView: UIView!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    
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
}
