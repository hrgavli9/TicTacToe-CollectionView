//
//  T4Cell.swift
//  A4_TicTacToeApp
//
//  Created by Dipak on 30/04/1943 Saka.
//

import UIKit

class T4Cell: UICollectionViewCell {
    private let myImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    func setupCell(with status:Int) {
        
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        
        contentView.addSubview(myImageView)
        
        myImageView.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        
        let name = status == 0 ? "circle" : status == 1 ? "multiply" : ""
        
        myImageView.image = UIImage(systemName: name)
    }
}
