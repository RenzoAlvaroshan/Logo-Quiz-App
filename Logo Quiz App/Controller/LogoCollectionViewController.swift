import UIKit

private let reuseIdentifier = "LogoCell"

@objc protocol LogoCollectionViewControllerDelegate
{
    @objc optional func onCorrectAnswer(didAnswerItemAt level: Int)
}

class LogoCollectionViewController: UIViewController
{
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    var delegate: LogoCollectionViewControllerDelegate?
    var selectedLevel: Int?
    
    var dataSource: [Logo] = []
    var selectIndexPath: IndexPath!
    
    let managedUser: ManagedUser? = {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return UserCoreDataStore(context: context).fetchUser()
    }()
    
    var answeredCount: Int = 0 { didSet {
        answeredLabel.text = "\(answeredCount) / \(dataSource.count)"
    }}
    
    @IBOutlet weak var answeredLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Level \(selectedLevel!)"
        collectionView.register(
            UINib(nibName: "LogoCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: reuseIdentifier
        )
        collectionView.collectionViewLayout = configureLayout()
        dataSource = Logo.list.filter({ $0.level == selectedLevel })
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "goToQuiz")
        {
            guard let vc = segue.destination as? QuizViewController
            else { return }
            vc.selectIndexPath = self.selectIndexPath
            vc.dataSource = self.dataSource
            vc.delegate = self
        }
    }
    
    func configureLayout() -> UICollectionViewCompositionalLayout
    {
        let itemPerRow: CGFloat = 3
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/itemPerRow),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: itemSize.widthDimension
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
}

// MARK: UICollectionViewDataSource
extension LogoCollectionViewController: UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let data        = dataSource[indexPath.row]
        let isAnswered  = managedUser?.answeredQuestions?.contains(data.name) ?? false
        answeredCount   += isAnswered ? 1 : 0
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier:reuseIdentifier,
            for: indexPath
        ) as! LogoCollectionViewCell
        
        cell.image = UIImage(named: data.guessImageName)
        cell.indicatorImageView.tintColor = .appGreen2
        cell.indicatorImageView.isHidden = !isAnswered
    
        cell.layer.cornerRadius = 8
        cell.layer.masksToBounds = true
        cell.layer.shadowRadius = 4
        cell.layer.shadowOpacity = 0.3
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 5)
        
        cell.bgView.backgroundColor = .white
        
        cell.bgView.layer.cornerRadius     = 8
        // cell.bgView.layer.borderWidth      = isAnswered ? 2 : 1
        // cell.bgView.layer.borderColor      = isAnswered ? UIColor.appAccent.cgColor : UIColor.gray.cgColor
        
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension LogoCollectionViewController: UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        selectIndexPath = indexPath
        performSegue(withIdentifier: "goToQuiz", sender: self)
    }
}

// MARK: QuizViewControllerDelegate
extension LogoCollectionViewController: QuizViewControllerDelegate
{
    func onCorrectAnswer(didAnswerItemAt indexPath: IndexPath)
    {
        collectionView.reloadItems(at: [indexPath])
        delegate?.onCorrectAnswer?(didAnswerItemAt: selectedLevel!)
    }
}
