//
//  KoreaMedalView.swift
//  K-AGScore
//
//  Created by MARY on 2023/10/05.
//

import UIKit

class NationMedalView: UIView {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let title: UILabel = {
        let title = UILabel()
        
        title.font = .preferredFont(forTextStyle: .headline)
        title.textAlignment = .left
        title.textColor = .label
        title.translatesAutoresizingMaskIntoConstraints = false
        title.adjustsFontForContentSizeCategory = true
        title.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        title.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        return title
    }()
    
    let medalsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "allMedal_IMG")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let gold: UILabel = {
        let title = UILabel()
        
        title.font = .boldSystemFont(ofSize: 40)
        title.textAlignment = .center
        title.textColor = .black
        title.translatesAutoresizingMaskIntoConstraints = false
        title.adjustsFontForContentSizeCategory = true
        
        return title
    }()
    
    let silver: UILabel = {
        let title = UILabel()
        
        title.font = .boldSystemFont(ofSize: 40)
        title.textAlignment = .center
        title.textColor = .black
        title.translatesAutoresizingMaskIntoConstraints = false
        title.adjustsFontForContentSizeCategory = true
        
        return title
    }()
    
    let bronze: UILabel = {
        let title = UILabel()
        
        title.font = .boldSystemFont(ofSize: 40)
        title.textAlignment = .center
        title.textColor = .black
        title.translatesAutoresizingMaskIntoConstraints = false
        title.adjustsFontForContentSizeCategory = true
        
        return title
    }()
    
    let nationStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    let medalStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        return stackView
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
        self.addSubview(medalStackView)
        self.addSubview(nationStackView)
        
        [gold, silver, bronze].forEach { medalStackView.addArrangedSubview($0) }
        [imageView, title].forEach { nationStackView.addArrangedSubview($0) }
    }
    
    private func setupConstraints() {
        self.layoutMargins = .init(top: 10, left: 10, bottom: 10, right: 10)
        nationStackView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        NSLayoutConstraint.activate([
            nationStackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            nationStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            nationStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            medalsImage.topAnchor.constraint(equalTo: nationStackView.bottomAnchor, constant: 10),
            medalsImage.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            medalsImage.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            medalsImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            medalStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 15),
            medalStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -15),
            medalStackView.centerYAnchor.constraint(equalTo: medalsImage.centerYAnchor, constant: 35),
            medalStackView.heightAnchor.constraint(equalToConstant: 50),
            
            imageView.widthAnchor.constraint(equalTo: nationStackView.widthAnchor, multiplier: 0.1),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
        ])
    }
    
    func configureView(_ data: ScoreData) {
        imageView.image = UIImage(named: data.alpha3)
        title.text = data.nation
        gold.text = data.gold
        silver.text = data.silver
        bronze.text = data.bronze
    }
}
