import UIKit

protocol GainPointViewControllerDelegate: AnyObject
{
    func onDismissButton()
}

class GainPointViewController: UIViewController
{
    weak var delegate: GainPointViewControllerDelegate?
    
    @IBOutlet weak var coinLabel: UILabel!
    @IBOutlet weak var dismissButton: UIButton!
    
    var dismissButtonTitle: String?
    var coinValue: Int = 10
    
    @IBAction func onDismissButton(_ sender: UIButton)
    {
        dismiss(animated: true)
        delegate?.onDismissButton()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let absCoinValue = abs(coinValue)
        
        if      (coinValue == 0)    { coinLabel.text = "0" }
        else if (coinValue < 0)     { coinLabel.text = "- \(absCoinValue)" }
        else                        { coinLabel.text = "+ \(absCoinValue)"}
        
        if let dismissButtonTitle = dismissButtonTitle
        {
            dismissButton.setTitle(dismissButtonTitle, for: .normal)
        }
    }
}
