import UIKit

extension PeopleViewController : RequestDelegate {
    func success<T>(_ response: T) {
        VerifyLoader.secondRequest = true
        loaderProtocol?.hideLoader()
        guard let peopleResponse = response as? PeopleResponse else {return}
        self.people = peopleResponse.data.users
        peopleCollectionView.reloadData()
    }
    
    func errorMessage(_ message: String) {
        VerifyLoader.secondRequest = true
        loaderProtocol?.hideLoader()
    }
}

extension PeopleViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let numberofItems = people?.count else {return 0}
        return numberofItems
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let personCell = peopleCollectionView.dequeueReusableCell(withReuseIdentifier: personCollectionCard.identifier, for: indexPath) as? PersonCardCollectionViewCell else {return UICollectionViewCell()}
    
        guard let user = people?[indexPath.row] else {return UICollectionViewCell()}
        personCell.setupDefinitiveLayout(user: user)
        personCell.delegate = self
        return personCell
    }
}

extension PeopleViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

extension PeopleViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 175, height: 260)
    }
}

extension PeopleViewController : GoToUser {
    func gotToUser(user : User) {

    }
}
