//
//  TableViewCell.swift
//  AssetTV
//
//  Created by Alexandre Malkov on 30/11/2016.
//  Copyright © 2016 Alexandre Malkov. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var imageData: NSData?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    internal var aspectConstraint: NSLayoutConstraint? {
        didSet {
            if oldValue != nil && aspectConstraint != nil {
                thumbnailImageView.removeConstraint(aspectConstraint!)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        aspectConstraint = nil
    }
    
    func setPostedImage(image: UIImage?) {
        if image != nil {
            let aspect = image!.size.width / image!.size.height
            aspectConstraint = NSLayoutConstraint(item: thumbnailImageView,
                                                  attribute: .width,
                                                  relatedBy: .equal,
                                                  toItem: thumbnailImageView,
                                                  attribute: .height,
                                                  multiplier: aspect,
                                                  constant: 0.0)
        }
        thumbnailImageView.image = image
    }

}
