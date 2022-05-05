import UIKit

private let reuseIdentifier = "LogoCell"

class LogoCollectionViewController: UIViewController
{
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    var selectedLevel: Int?
    
    var dataSource: [Logo] = []
    var selectedLogo: Logo?
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        collectionView.register(
            UINib(nibName: "LogoCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: reuseIdentifier
        )
        
        Logo.list.forEach({ if ($0.level == selectedLevel) { dataSource.append($0) } })
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "goToQuiz")
        {
            guard let vc = segue.destination as? QuizViewController
            else { return }
            vc.logo = selectedLogo
        }
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
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier:reuseIdentifier,
            for: indexPath
        ) as! LogoCollectionViewCell
        let assetImageURL = dataSource[indexPath.row].imageUrl
        cell.image = UIImage(named: assetImageURL)
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension LogoCollectionViewController: UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        selectedLogo = dataSource[indexPath.row]
        performSegue(withIdentifier: "goToQuiz", sender: self)
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension LogoCollectionViewController: UICollectionViewDelegateFlowLayout
{
    // this will set the cell size programmatically based on collection view size
    // collection view flow layout from storyboard will override this if estimate size doesn't set to none!
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let cellsAcross: CGFloat = 3
        let dim = collectionView.bounds.width / cellsAcross - collectionView.bounds.width / 40
        return CGSize(width: dim, height: dim)
    }
}
