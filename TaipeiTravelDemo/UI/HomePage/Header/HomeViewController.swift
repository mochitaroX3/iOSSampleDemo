//
//  ViewController.swift
//  TaipeiTravelDemo
//
//  Created by user on 2025/6/10.
//

import UIKit
import Alamofire
import SafariServices
import SwiftUI

class HomeViewController: UIViewController {

    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel = HomeViewModel()
    let sectionTitle = ["news.section.title".localized, "attraction.section.title".localized]
    var items: [[Any]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "home.tilte".localized
        setupNavigation()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: HeaderView.id, bundle: .main), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.id)
        collectionView.register(UINib(nibName: FooterView.id, bundle: .main), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterView.id)
        collectionView.register(UINib(nibName: NewsCell.id, bundle: .main), forCellWithReuseIdentifier: NewsCell.id)
        collectionView.register(UINib(nibName: AttractionCell.id, bundle: .main), forCellWithReuseIdentifier: AttractionCell.id)
                                
        items = Array(repeating: [], count: sectionTitle.count)
        
        let languageUsedInApp = Bundle.main.preferredLocalizations.first ?? "en"
        fetchData(with: AppLanguage(rawValue: languageUsedInApp) ?? .zh_tw)

        setupViewMode()
    }
    
    func setupNavigation() {
        
        // 標題文字樣式
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 20)
        ]
        
        let globeImage = UIImage(systemName: "globe")
        let globeButton = UIBarButtonItem(image: globeImage,
                                          style: .plain,
                                          target: self,
                                          action: #selector(changeLanguge))
        
        navigationItem.rightBarButtonItem = globeButton
        
        // 返回鍵等按鈕的顏色
        navigationController?.navigationBar.tintColor = .white
        
        // .minimal 會只顯示返回箭頭，不顯示文字
        navigationItem.backButtonDisplayMode = .minimal
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .mainColor
        appearance.shadowColor = .clear

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func setupViewMode() {
        viewModel.showLoading = {
            LoadingOverlay.shared.show(in: self)
        }
        
        viewModel.hideLoading = {
            LoadingOverlay.shared.hide()
        }
        
        viewModel.showErrorMessage = { err in
            debugPrint(err)
        }
    }
    
    func fetchData(with language: AppLanguage) {
        viewModel.fetchNews(lange: language) { news in
            self.items[0] = news
            self.collectionView.reloadData()
        }
        
        viewModel.fetchAttractions(lange: language) { attractions in
            self.items[1] = attractions
            self.collectionView.reloadData()
        }
    }
    
    @objc func changeLanguge() {
        let menu = LanguageMenu(content: AppLanguage.allCases.map({ $0 }))
        menu.show(in: view)
        
        menu.onChangeLanguage = { language in
            menu.dismiss()
            self.fetchData(with: language)
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard section < items.count else { return 0 }
        return items[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCell.id, for: indexPath) as? NewsCell,
           let data = items[indexPath.section][indexPath.row] as? News {
            cell.config(with: data, isLast: indexPath.row == items[indexPath.section].count - 1)
            return cell
        }
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AttractionCell.id, for: indexPath) as? AttractionCell,
           let data = items[indexPath.section][indexPath.row] as? Attraction {
            cell.config(with: data)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            if let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.id, for: indexPath) as? HeaderView {
                
                header.setup(with: sectionTitle[indexPath.section].localized)
                return header
            }
        case UICollectionView.elementKindSectionFooter:
            if let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterView.id, for: indexPath) as? FooterView {
                return footer
            }
        default:
            return UICollectionReusableView()
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            guard let news = items[indexPath.section][indexPath.row] as? News else { return }
            let vc = WebViewController.new(url: news.url ?? "")
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.section == 1 {
            guard let viewspoint = items[indexPath.section][indexPath.row] as? Attraction else { return }
            let vc = AttractionsViewController.new(attraction: viewspoint)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width, height: 112)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return  .init(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return  .init(width: collectionView.frame.width, height: 0)
    }
}
