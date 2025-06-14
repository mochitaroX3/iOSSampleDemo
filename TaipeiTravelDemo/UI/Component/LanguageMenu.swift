//
//  LanguageMenu.swift
//  TaipeiTravelDemo
//
//  Created by user on 2025/6/14.
//

import UIKit

class LanguageMenu: UIView {
    
    private let contentView = UIView()
    let height: CGFloat = 40
    var content: [AppLanguage] = []
    var selected: AppLanguage!
    var onChangeLanguage: ((AppLanguage) -> ())? = nil
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 8
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    init(content: [AppLanguage]) {
        self.content = content
        super.init(frame: UIScreen.main.bounds)
        setupView()
    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupView()
//    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        self.frame = UIScreen.main.bounds
        self.backgroundColor = UIColor.label.withAlphaComponent(0.3)

        // add contentView
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.center = self.center
        contentView.backgroundColor = .systemBackground
        contentView.addRadius(radius: 12)
        addSubview(contentView)
        
        // Auto Layout for contentView
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24)
        ])

        // add stackView
        contentView.fill(with: stackView)
 
        // 加上內容
        setMenuContent()
    }
    
    func setMenuContent() {
        // 加入標題
        let label = UILabel()
        label.text = "chose.language.title".localized
        label.font = .systemFont(ofSize: 16, weight: .medium)
        stackView.addArrangedSubview(label)
        label.heightAnchor.constraint(equalToConstant: height).isActive = true
        label.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 12).isActive = true
        
        // 加入內容
        content.forEach {
            let label = UILabel()
            label.text = $0.displayName
            label.font = .systemFont(ofSize: 14)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            tap.name = $0.rawValue
            label.addGestureRecognizer(tap)
            label.isUserInteractionEnabled = true
            
            stackView.addArrangedSubview(label)
            label.heightAnchor.constraint(equalToConstant: height).isActive = true
            label.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 12).isActive = true
        }
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        if let tappedLabel = gesture.view as? UILabel {
            tappedLabel.textColor = .buttonTextColor
        }
        onChangeLanguage?(AppLanguage(rawValue: gesture.name ?? "") ?? .zh_tw)
    }

    func show(in parentView: UIView) {
        self.alpha = 0
        contentView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        parentView.addSubview(self)

        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.8,
                       options: .curveEaseInOut,
                       animations: {
            self.alpha = 1
            self.contentView.transform = .identity
        }, completion: nil)

    }

    func dismiss() {
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }
}
