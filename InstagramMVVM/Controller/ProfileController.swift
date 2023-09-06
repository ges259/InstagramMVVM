//
//  ProfileController.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/05.
//s

import UIKit

final class ProfileController: UICollectionViewController {
    
    // MARK: - Properties
    
    
    
    
    
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    
    
    
    // MARK: - Helper_Funtions
    private func configureUI() {
        self.collectionView.backgroundColor = UIColor.white
        
        self.collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: Idenrifier.profile_Col_Cell)
        self.collectionView.register(ProfileHeader.self,
                                     forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                     withReuseIdentifier: Idenrifier.profile_Header)
    }
    
    
    
    
    
    // MARK: - Selectors
    
    
    
    
    
    
    
    
    // MARK: - API
    
    
}




















// MARK: - DataSource
extension ProfileController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Idenrifier.profile_Col_Cell, for: indexPath) as! ProfileCell
        
        return cell
    }
    
    
    // Header
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: Idenrifier.profile_Header,
                                                                     for: indexPath) as! ProfileHeader
        
        
        return header
    }
}




// MARK: - Delegate





// MARK: - FlowLayout
extension ProfileController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (self.view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 240)
    }
}
