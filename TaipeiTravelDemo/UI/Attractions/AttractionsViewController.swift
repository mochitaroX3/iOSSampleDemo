//
//  AttractionsViewController.swift
//  TaipeiTravelDemo
//
//  Created by user on 2025/6/13.
//

import UIKit

class AttractionsViewController: UIViewController {
    
    static func new(attraction: Attraction) -> AttractionsViewController {
        let vc = AttractionsViewController.initInstance() as! AttractionsViewController
        vc.attraction = attraction
        return vc
    }
    
    @IBOutlet weak var pagesControl: UIPageControl!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var detailsContentView: ScrollingStackView!

    let viewModel: AttractionsViewModel = AttractionsViewModel()
    var attraction: Attraction!
    var images: [UIImageView] = []
    var imageWidth: CGFloat = 0
    var timer = Timer()
    var timerInterval: TimeInterval = 5
    var currentImgIndex: Int = 0 {
        didSet {
            pagesControl.currentPage = currentImgIndex
        }
    }
    
    private let imageScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    var details: [SpotDetailRow] {
        let detail = SpotDetail(name: attraction.name,
                                  introduction: attraction.introduction,
                                  openTime: attraction.openTime,
                                  address: attraction.address,
                                  tel: attraction.tel,
                                  fax: attraction.fax,
                                  url: attraction.url)
        return detail.asArray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = attraction.name
        
        imageContainerView.fill(with: imageScrollView)
        imageWidth = imageContainerView.frame.size.width
        imageScrollView.delegate = self
    
        detailsContentView.axis = .vertical
        detailsContentView.spacing = 8
        
        setupViewModel()
        setupRows()
    }
    
    func setupViewModel() {
        viewModel.downloadAllImage(srcs: attraction.imageSrcs ?? []) { images in
            if !images.isEmpty {
                self.images = images
                self.setPageControl()
                self.addImagesToScrollView()
                self.startTimer()
            }
        }
    }
    
    func setPageControl() {
        pagesControl.numberOfPages = images.count
        pagesControl.pageIndicatorTintColor = .descriptionColor
        pagesControl.currentPageIndicatorTintColor = .pageIndicatorColor
    }
    
    private func addImagesToScrollView() {
        // add 3 imges to imageView
        let _ = imageScrollView.subviews.map { $0.removeFromSuperview() }
        for i in 0 ..< 3 {
            let imageView = UIImageView(frame: CGRect(x: (CGFloat(i) * imageWidth), y: 0, width: imageWidth, height: imageScrollView.frame.height))
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            
            // Imges order: last -> first -> second
            let index = ((i + images.count - 1) % images.count)
            imageView.image = images[index].image
            imageScrollView.addSubview(imageView)
        }
        // set scrollView ContentSize (顯示範圍)
        imageScrollView.contentSize = CGSize(width: imageWidth * 3, height: imageScrollView.frame.height)
        
        // 調整 scroll 位置顯示中間
        imageScrollView.contentOffset = CGPoint(x: imageWidth, y: 0)
    }
    
    /// 更新Banner
    func nextBanner() {
        // 顯示的Banner在 subviews[1] index控制目前要顯示的image
        if currentImgIndex > (images.count - 1) { // 超過邊界值
            currentImgIndex = 0
        } else if currentImgIndex < 0 { // 往左滑動時，超過邊界值
            currentImgIndex = (images.count - 1)
        }
        
        let currentIndex = currentImgIndex
        let nextIndex = (currentIndex + 1) % images.count
        let preIndex = (currentIndex + images.count - 1) % images.count
        
        if imageScrollView.subviews.count > 0 && imageScrollView.subviews.filter({ $0.isKind(of: UIImageView.self) }).count > 0 {
            (imageScrollView.subviews[0] as! UIImageView).image = images[preIndex].image
            (imageScrollView.subviews[1] as! UIImageView).image = images[currentIndex].image
            (imageScrollView.subviews[2] as! UIImageView).image = images[nextIndex].image
        }
    }
    
    func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(timeInterval: timerInterval, target: self, selector: #selector(refreshBanner), userInfo: nil, repeats: true)
    }
    
    private func stopTimer() {
        timer.invalidate()
    }
    
    @objc func refreshBanner() {
        currentImgIndex = currentImgIndex + 1
        if images.count > 0 {
            nextBanner()
        }
    }
    
    func setupRows() {
        details.forEach {
            let view = AttractionsView.new
            if let content = $0.1 as? String, !content.isEmpty {
                view.setupContent(with: $0)
                detailsContentView.add(view: view)
                
                view.doAction = {
                    self.doTapAction(spot: $0)
                }
            }
        }
    }
    
    func doTapAction(spot: SpotDetailRow) {
        if spot.key == "tel" {
            guard let phoneNumber = URL(string: "tel://" + (spot.content as? String ?? "")) else { return }
            UIApplication.shared.open(phoneNumber, options: [:], completionHandler: nil)
        } else if spot.key == "url" {
            let vc = WebViewController.new(with: attraction.name, url: spot.content as? String ?? "")
            navigationController?.pushViewController(vc, animated: true)
            navigationItem.backButtonDisplayMode = .minimal
        }
    }
}

extension AttractionsViewController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopTimer()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // 往左邊滑到底，偏移到中間view
        if scrollView.contentOffset.x == 0 {
            imageScrollView.contentOffset = CGPoint(x: imageWidth, y: 0)
            currentImgIndex -= 1
            nextBanner()
        }
        
        // 往右邊滑到底，偏移到中間view
        if scrollView.contentOffset.x == imageWidth * 2 {
            imageScrollView.contentOffset = CGPoint(x: imageWidth, y: 0)
            currentImgIndex += 1
            nextBanner()
        }
        startTimer()
    }
}
