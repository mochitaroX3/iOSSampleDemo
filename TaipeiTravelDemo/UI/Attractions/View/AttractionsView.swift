//
//  AttractionsView.swift
//  TaipeiTravelDemo
//
//  Created by user on 2025/6/13.
//

import UIKit

class AttractionsView: UIView {
    
    @IBOutlet weak var colTitleLabel: UILabel!
    @IBOutlet weak var contentInfoLabel: UILabel!
    
    public static var new: AttractionsView {
        return AttractionsView().newNib()
    }
    
    var doAction: ((SpotDetailRow) ->())? = nil
    var row: SpotDetailRow!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        colTitleLabel.font = UIFont.systemFont(ofSize: 14)
        colTitleLabel.textColor = .descriptionColor
        contentInfoLabel.numberOfLines = 0
        
        contentInfoLabel.font = UIFont.systemFont(ofSize: 14)
        contentInfoLabel.textColor = .label
        contentInfoLabel.numberOfLines = 0
    }
    
    func setupContent(with spot: SpotDetailRow) {
        self.row = spot
        colTitleLabel.text = spot.title
        colTitleLabel.isHidden = spot.title.isEmpty
        contentInfoLabel.text = spot.content as? String ?? ""
        
        if spot.key == "tel" || spot.key == "url" {
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            tap.name = spot.key
            addGestureRecognizer(tap)
            contentInfoLabel.addClickStyle(text: contentInfoLabel.text ?? "")
        }
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        doAction?(row)
    }
}
