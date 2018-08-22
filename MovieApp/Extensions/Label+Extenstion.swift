//
//  Label+Extenstion.swift
//  MovieApp
//
//  Created by Sami Youssef on 8/20/18.
//  Copyright © 2018 Sami Youssef. All rights reserved.
//

import UIKit

extension UILabel {
    func set(image: UIImage, with text: String) {
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = CGRect(x: 0, y: 0, width: 14, height: 14)
        let attachmentStr = NSAttributedString(attachment: attachment)

        let mutableAttributedString = NSMutableAttributedString()
        mutableAttributedString.append(attachmentStr)

        let textString = NSAttributedString(string: " " + text, attributes: [.font: self.font])
        mutableAttributedString.append(textString)

        self.attributedText = mutableAttributedString
    }
}
