//
//  BillTableViewCell.swift
//  AcasaTest
//
//  Created by Natuka on 27/01/2018.
//  Copyright © 2018 Natalia. All rights reserved.
//

import UIKit
import AlamofireImage

class BillTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var payerLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categoryImageView.af_cancelImageRequest()
    }

    func configure(bill: Bill) {
        titleLabel.text = bill.title
        amountLabel.text = "£" + String(bill.amountInPence/100)
        
        if let categoryIconURL = URL(string: bill.categoryIconURL) {
           categoryImageView.af_setImage(withURL: categoryIconURL)
        }
        if bill.upcoming == true {
            payerLabel.text = bill.payerName + " pays"
        } else {
            payerLabel.text = bill.payerName + " paid"
        }
    }
}
