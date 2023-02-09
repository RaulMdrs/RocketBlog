import UIKit

class PeopleViewController: UIViewController {
    var people : [User]?
    var loaderProtocol : LoaderHomeViewProtocol?
    var personCollectionCard = PersonCardCollectionViewCell()
    lazy var peopleCollectionView:UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .none
        collectionView.register(PersonCardCollectionViewCell.self, forCellWithReuseIdentifier: personCollectionCard.identifier)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.bouncesZoom = false
        collectionView.bounces = false
        collectionView.alwaysBounceHorizontal = false
        collectionView.alwaysBounceVertical = false
        collectionView.showsHorizontalScrollIndicator = false
    
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPeople()
        setupCollectionView()
    }
    
    func getPeople() {
        VerifyLoader.secondRequest = false
        loaderProtocol?.showLoader()
        var apiManager = ApiManager()
        apiManager.requestDelegate = self
        apiManager.genericRequest(model: PeopleResponse.self, path: ApiPath.apiPeoplePath(), method: .get, header: ["Authorization" : Authentication.shared.getToken(), "accept" : "application/json"], body: nil)
    }
    
    private func setupCollectionView() {
        self.view.addSubview(peopleCollectionView)
        
        NSLayoutConstraint.activate([
            self.peopleCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 5),
            self.peopleCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            self.peopleCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            self.peopleCollectionView.heightAnchor.constraint(equalToConstant: 260)
        ])
    }
}
