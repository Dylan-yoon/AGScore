//
//  KoreaMedalView.swift
//  K-AGScore
//
//  Created by MARY on 2023/10/05.
//

import UIKit

class KoreaMedalView: UIView {
    private let medalsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Medals")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.addSubview(medalsImage)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            medalsImage.topAnchor.constraint(equalTo: self.topAnchor),
            medalsImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            medalsImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            medalsImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
