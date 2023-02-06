import UIKit

class PeopleViewController: UIViewController {
    
    @IBOutlet weak var peopleCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        setupCollectionView()
    }
    
    private func setDelegates() {
        peopleCollectionView.dataSource = self
        peopleCollectionView.delegate = self
    }
    
    private func setupCollectionView() {
        peopleCollectionView.register(UINib(nibName: K.NibName.personCell, bundle: nil), forCellWithReuseIdentifier: "PersonCardCollectionViewCell")
    }
}
