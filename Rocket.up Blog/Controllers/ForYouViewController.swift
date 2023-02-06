import UIKit

class ForYouViewController: UIViewController {
    
    @IBOutlet weak var forYouCollectionView: UICollectionView!
    var loaderProtocol : LoaderHomeViewProtocol?
    
    var arrayPosts: [Post]?
    var loader = LoaderView()
    var apiManager = ApiManager()
    
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
        forYouCollectionView.register(UINib(nibName: K.NibName.postCell, bundle: nil), forCellWithReuseIdentifier: K.Identifier.postCell)
    }
    
    func getPosts() {
        loaderProtocol?.showLoader()
        apiManager.genericRequest(model: PostResponse.self, path: ApiPath.apiUserPostPath(), method: .get, header: ["Authorization" : Authentication.shared.getToken(), "accept" : "application/json"], body: nil)
    }
    
    private func loaderSetup() {
        loader = LoaderView(frame: forYouCollectionView.frame)
        loader.hideLoader()
        self.view.addSubview(loader)
    }
}
