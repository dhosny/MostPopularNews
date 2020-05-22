//
//  ArticalTableViewCell.swift
//  MostPopularNews
//
//  Created by Dalia Hosny on 5/22/20.
//  Copyright © 2020 Dalia Hosny. All rights reserved.
//

import UIKit

class ArticalTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subtitleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func display(title: String) {
        self.titleLbl.text = title
    }
    
    func display(subtitle: String) {
        self.subtitleLbl.text = subtitle
    }
    
    func display(description: String) {
        self.descriptionLbl.text = description
    }
    
    func display(dateStr: String) {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//        if let date = dateFormatter.date(from: dateStr) {
//            let formatter = DateFormatter()
//            formatter.dateFormat = "E, dd MMM yyyy hh:mm aa"
//            formatter.timeZone = TimeZone.current
//            self.dateLbl.text = formatter.string(from: date)
//        }
        self.dateLbl.text = dateStr
    }
    func setImg(url: String) {
        img.setImageBy(urlString: url)
    }

}
