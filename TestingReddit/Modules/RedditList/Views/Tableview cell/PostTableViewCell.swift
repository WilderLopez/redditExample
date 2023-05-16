//
//  PostTableViewCell.swift
//  TestingReddit
//
//  Created by Wilder López on 5/16/23.
//

import UIKit
import SDWebImage

class PostTableViewCell: UITableViewCell {
    static let nibName = "PostTableViewCell"
    static let identifier = "PostTableViewCellID"
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var postedLabel: UILabel!
    @IBOutlet weak var numComments: UILabel!
    @IBOutlet weak var subredditLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    //Image constraints
    @IBOutlet weak var widthImageConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightImageConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func changeDeviceOrientation(isLandscape: Bool){
        if isLandscape {
            widthImageConstraint.constant = 200
//            widthImageConstraint.isActive = true
            
            heightImageConstraint.constant = 130
//            heightImageConstraint.isActive = true
        }else {
            widthImageConstraint.constant = 100
//            widthImageConstraint.isActive = true
            
            heightImageConstraint.constant = 80
//            heightImageConstraint.isActive = true
        }
    }

    
    override func prepareForReuse() {
        thumbnailImageView.sd_cancelCurrentImageLoad()
        thumbnailImageView.image = nil
    }
    
    public func loadThumbnailImage(url: URL?) {
        guard let url = url else {
            debugPrint("Unable to load thumbnail")
            return
        }
        
        thumbnailImageView.sd_setImage(with: url, placeholderImage: nil)
        thumbnailImageView.sd_imageTransition = .fade(duration: 0.5)
        thumbnailImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
    }
}
