import UIKit

extension PeopleViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let personCell = peopleCollectionView.dequeueReusableCell(withReuseIdentifier: "PersonCardCollectionViewCell", for: indexPath) as? PersonCardCollectionViewCell else {return UICollectionViewCell()}
        
        return personCell
    }
}

extension PeopleViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}
