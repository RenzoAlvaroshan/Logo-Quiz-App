import UIKit

class GainPointViewController: UIViewController
{
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
        if      (coinValue == 0)    { coinLabel.text = "no coins exchanged" }
        else if (coinValue < 0)     { coinLabel.text = "- \(absCoinValue) coins" }
        else                        { coinLabel.text = "+ \(absCoinValue) coins"}
    }
}
