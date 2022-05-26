import UIKit

// TODO: Tooltip Text Field Color set Fixed Color (

@objc protocol QuizViewControllerDelegate
{
    @objc optional func onCorrectAnswer(didAnswerItemAt indexPath: IndexPath)
}

class QuizViewController: UIViewController
{
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var textField: UITextField!
    @IBOutlet weak var hintButton: SmallLogoButton!
    @IBOutlet weak var solveButton: SmallLogoButton!
    @IBOutlet weak var solvedInicatorView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    weak var delegate: QuizViewControllerDelegate?
    
    var coinView = CoinView(frame: CGRect(x: 0, y: 0, width: 72, height: 27))
    
    var managedUser: ManagedUser?
    var characterNumber = 0

    // set by previous view controller
    var dataSource: [Logo] = []
    var selectIndexPath: IndexPath!
    
    var store: UserCoreDataStore {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return UserCoreDataStore(context: context)
    }
    
    private var gainCoinValue: Int = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Guess The Logo"
        textField.delegate = self
        managedUser = store.fetchUser()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: coinView)
        textField.addTarget(self, action: #selector(checkAnswer), for: .editingChanged)
        
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        
        navigationButtonChecker(at: selectIndexPath, itemCount: dataSource.count)
        refreshView(at: selectIndexPath)
        refreshCoinView()
    }
    
    func refreshView(at indexPath: IndexPath)
    {
        let data = dataSource[indexPath.row]
        let isAnswered = managedUser?.answeredQuestions?.contains(data.name) ?? false

        imageView.image = UIImage(named: isAnswered ? data.answerImageName : data.guessImageName)
        solvedInicatorView.isHidden = !isAnswered
        solveButton.isEnabled = !isAnswered
        hintButton.isEnabled = !isAnswered
        solveButton.imageView.tintColor = isAnswered ? .lightGray : .appAccent2
        hintButton.imageView.tintColor  = isAnswered ? .lightGray : .appAccent2
        textField.text = isAnswered ? data.name : nil
        textField.isUserInteractionEnabled = !isAnswered
    }
    
    func refreshCoinView()
    {
        let coinValue = Int(managedUser?.score ?? 0)
        coinView.coinValue = coinValue
    }
    
    func navigationButtonChecker(at indexPath: IndexPath, itemCount: Int)
    {
        prevButton.isEnabled = indexPath.row > 0
        nextButton.isEnabled = indexPath.row < itemCount - 1
    }
    
    @IBAction func onPrevButton(_ sender: UIButton)
    {
        selectIndexPath.row -= 1
        navigationButtonChecker(at: selectIndexPath, itemCount: dataSource.count)
        refreshView(at: selectIndexPath)
    }
    
    @IBAction func onNextButton(_ sender: UIButton)
    {
        selectIndexPath.row += 1
        navigationButtonChecker(at: selectIndexPath, itemCount: dataSource.count)
        refreshView(at: selectIndexPath)
    }
    
    @IBAction func onSolveButton(_ sender: SmallLogoButton)
    {
        let costs       = 30
        let userCoins   = Int(managedUser?.score ?? 0)
        let deficit     = costs - userCoins
        
        let alert = UIAlertController(
            title: "Solve Logo",
            message: "It costs you \(costs) coins to solve. Obtain \(deficit) more coins to continue",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        if (userCoins >= costs)
        {
            alert.message = "Would you like to solve this logo? This costs you: \(costs) coins"
            alert.addAction(UIAlertAction(title: "Solve", style: .default) { [self] _ in
                let data = dataSource[selectIndexPath.row]
                
                if characterNumber == 0 {
                    textField.text = data.name[characterNumber]
                } else {
                    textField.text! += data.name[characterNumber]
                }
                
                checkAnswer()
                onCorrectAnswer(addCoins: -(costs))
                refreshCoinView()
            })
        }
        
        present(alert, animated: true)
    }
    
    @IBAction func onHintButton(_ sender: SmallLogoButton)
    {
        let costs       = 10
        let userCoins   = Int(managedUser?.score ?? 0)
        let deficit     = costs - userCoins
        
        let alert = UIAlertController(
            title: "Use Hint",
            message: "It costs you \(costs) coins to use hint. Obtain \(deficit) more coins to continue",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        if (userCoins >= costs)
        {
            alert.message = "Would you like to reveal a letter? This costs you: \(costs) coins"
            alert.addAction(UIAlertAction(title: "Hint", style: .default) { [self] _ in
                let data = dataSource[selectIndexPath.row]
                textField.text = data.name[0]
                checkAnswer()
                store.addUserScore(amount: -(costs))
                refreshCoinView()
            })
        }
        
        present(alert, animated: true)
    }
    
    @objc func checkAnswer()
    {
        let data = dataSource[selectIndexPath.row]
        let isCorrectAnswer = textField.text?.caseInsensitiveCompare(data.name) == .orderedSame
        if (isCorrectAnswer) { onCorrectAnswer(addCoins: 10) }
    }
    
    func onCorrectAnswer(addCoins: Int)
    {
        let data = dataSource[selectIndexPath.row]
        store.addUserScore(amount: addCoins)
        store.addAnsweredQuestion(data.name)
        refreshView(at: selectIndexPath)
        refreshCoinView()
        
        let vc = GainPointViewController(nibName: "GainPointViewController", bundle: nil)
        vc.coinValue = addCoins
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = self
        
        vc.view.clipsToBounds = true
        vc.view.layer.cornerRadius = 33
        vc.view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        present(vc, animated: true)
        
        delegate?.onCorrectAnswer?(didAnswerItemAt: selectIndexPath)
    }
}

extension QuizViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
}

extension QuizViewController: UIViewControllerTransitioningDelegate
{
    class ToastPresentationController: UIPresentationController
    {
        let inset: CGFloat!
        
        init(inset: CGFloat, presentedViewController: UIViewController, presenting: UIViewController?)
        {
            self.inset = inset
            super.init(presentedViewController: presentedViewController, presenting: presenting)
        }
        
        override var frameOfPresentedViewInContainerView: CGRect
        {
            guard let containerView = containerView,
                let presentedView = presentedView else { return .zero }

            // Make sure to account for the safe area insets
            let safeAreaFrame = containerView.bounds
                .inset(by: containerView.safeAreaInsets)

            let targetWidth = safeAreaFrame.width - 2 * inset
            let fittingSize = CGSize(
                width: targetWidth,
                height: UIView.layoutFittingCompressedSize.height
            )
            let targetHeight = presentedView.systemLayoutSizeFitting(
                fittingSize, withHorizontalFittingPriority: .required,
                verticalFittingPriority: .defaultLow).height

            var frame = safeAreaFrame
            frame.origin.x += inset
            frame.origin.y += frame.size.height - targetHeight - inset
            frame.size.width = targetWidth
            frame.size.height = targetHeight
            return frame
        }

        override func containerViewDidLayoutSubviews() {
            super.containerViewDidLayoutSubviews()
            presentedView?.frame = frameOfPresentedViewInContainerView
        }
    }
    
    class SheetPresentationController: UIPresentationController
    {
        override var frameOfPresentedViewInContainerView: CGRect
        {
            guard let containerView = containerView,
                let presentedView = presentedView else { return .zero }

            let targetWidth     = containerView.bounds.width
            let targetHeight    = presentedView.frame.height

            var frame           = containerView.bounds
            frame.origin.y      += frame.size.height - targetHeight
            frame.size.width    = targetWidth
            frame.size.height   = targetHeight
            return frame
        }

        override func containerViewDidLayoutSubviews() {
            super.containerViewDidLayoutSubviews()
            presentedView?.frame = frameOfPresentedViewInContainerView
        }
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController?
    {
        return SheetPresentationController(
            presentedViewController: presented,
            presenting: presenting
        )
    }
}
