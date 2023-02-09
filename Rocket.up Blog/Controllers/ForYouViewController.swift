import UIKit

class ForYouViewController: UIViewController {
    var loaderProtocol : LoaderHomeViewProtocol?
    var arrayPosts: [Post]?
    var apiManager = ApiManager()
    var postCollectionCard = PostCollectionViewCell()
    lazy var forYouCollectionView:UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .none
        collectionView.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: postCollectionCard.identifier)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        
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
        setDelegates()
        setupCollectionView()
        getPosts()
    }
    
    private func setDelegates() {
        forYouCollectionView.dataSource = self
        forYouCollectionView.delegate = self
        apiManager.requestDelegate = self
    }
    
    private func setupCollectionView() {
        self.view.addSubview(forYouCollectionView)
        
        NSLayoutConstraint.activate([
            self.forYouCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 5),
            self.forYouCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5),
            self.forYouCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5),
            self.forYouCollectionView.heightAnchor.constraint(equalToConstant: 280)
        ])
    }
    
    func getPosts() {
        VerifyLoader.secondRequest = false
        loaderProtocol?.showLoader()
        apiManager.genericRequest(model: PostResponse.self, path: ApiPath.apiUserPostPath(), method: .get, header: ["Authorization" : Authentication.shared.getToken(), "accept" : "application/json"], body: nil)
    }
}
