import UIKit

protocol GainPointViewControllerDelegate: AnyObject {
    func onNextButton()
    func onCloseButton()
}

class GainPointViewController: UIViewController
{
    var dataSource: [Logo]!
    
    weak var delegate: GainPointViewControllerDelegate?
    
    @IBOutlet weak var coinLabel: UILabel!
    
    var coinValue: Int = 10
    
    @IBAction func onCloseButton(_ sender: UIButton)
    {
        dismiss(animated: true)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let absCoinValue = abs(coinValue)
        if      (coinValue == 0)    { coinLabel.text = "0" }
        else if (coinValue < 0)     { coinLabel.text = "- \(absCoinValue)" }
        else                        { coinLabel.text = "+ \(absCoinValue)"}
    }
}
