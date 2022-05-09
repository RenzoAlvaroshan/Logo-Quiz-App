//
//  SmallLogoButton.swift
//  Logo Quiz App
//
//  Created by Ramadhan Kalih Sewu on 07/05/22.
//

import UIKit

@IBDesignable
class SmallLogoButton: UIControl
{
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
   
    @IBInspectable var image: UIImage! { didSet {
        imageView.image = image
    }}
    
    @IBInspectable var title: String! { didSet {
        label.text = title
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
        let bundle = Bundle(for: SmallLogoButton.self)
        let view = bundle.loadNibNamed(String(describing: SmallLogoButton.self), owner: self, options: nil)![0] as! UIView
        view.frame = self.bounds
        addSubview(view)
        return view
    }

}
