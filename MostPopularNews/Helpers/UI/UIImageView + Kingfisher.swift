//
//  UIImageView + Kingfisher.swift
//  StayHome
//
//  Created by Dalia Hosny on 4/26/20.
//  Copyright © 2020 Dalia Hosny. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
        func setImageBy (urlString: String){
            let url = URL(string: urlString)
            let processor = DownsamplingImageProcessor(size: self.frame.size)
                |> RoundCornerImageProcessor(cornerRadius: 0)
            self.kf.indicatorType = .activity
            self.kf.setImage(
                with: url,
                placeholder: UIImage(named: ""),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
            {
                result in
    //            switch result {
    //            case .success(let value):
    //                print("Task done for: \(value.source.url?.absoluteString ?? "")")
    //            case .failure(let error):
    //                print("Job failed: \(error.localizedDescription)")
    //            }
            }
        }
}
