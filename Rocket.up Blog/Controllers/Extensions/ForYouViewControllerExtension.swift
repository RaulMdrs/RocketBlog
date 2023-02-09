import UIKit

extension ForYouViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return arrayPosts?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let postCell = forYouCollectionView.dequeueReusableCell(withReuseIdentifier: K.Identifier.postCell, for: indexPath)
                as? PostCollectionViewCell else {return UICollectionViewCell()}
        let emptyArray = Post(id : "", title: "", image: "", postedBy: [Author(id: "", name: "", avatar: "")])
        postCell.setupPost(post: arrayPosts?[indexPath.section] ?? emptyArray)
        return postCell
    }
}

extension ForYouViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: K.StoryboardNames.post, bundle: nil)
        guard let postScreen = storyboard.instantiateViewController(withIdentifier: K.Identifier.postViewController) as? PostViewController else {return}
        navigationItem.hidesBackButton = false
        navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(postScreen, animated: true)
    }
}

extension ForYouViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 220, height: 260)
    }
}
extension ForYouViewController: RequestDelegate {
    func success<T>(_ response: T) {
        VerifyLoader.secondRequest = true
        loaderProtocol?.hideLoader()
        guard let postResponse = response as? PostResponse else {return}
        self.arrayPosts = postResponse.data?.featuredPosts
        forYouCollectionView.reloadData()
    }
    
    func errorMessage(_ message: String) {
        VerifyLoader.secondRequest = true
        loaderProtocol?.hideLoader()
        ShowError.ShowErrorModal(targetView: self.view, message: message, animationDuration: 0.5)
    }
}
