import UIKit

private let reuseIdentifier = "LogoCell"

class LogoCollectionViewController: UIViewController
{
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    var selectedLevel: Int?
    
    var dataSource: [Logo] = []
    var selectIndexPath: IndexPath!
    
    let managedUser: ManagedUser? = {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return UserCoreDataStore(context: context).fetchUser()
    }()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

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
            vc.logo = dataSource[selectIndexPath.row]
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
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier:reuseIdentifier,
            for: indexPath
        ) as! LogoCollectionViewCell
        
        cell.image = UIImage(named: data.imageUrl)
        cell.indicatorImageView.tintColor = .appGreen
        cell.indicatorImageView.isHidden = !isAnswered
        
        cell.layer.cornerRadius = 8
        cell.layer.borderWidth = isAnswered ? 2 : 1
        cell.layer.borderColor = isAnswered ? UIColor.appAccent.cgColor : UIColor.gray.cgColor
        
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
    func onCorrectAnswer()
    {
        collectionView.reloadItems(at: [selectIndexPath])
    }
}
