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
        
        title.font = .preferredFont(forTextStyle: .title3)
        title.textAlignment = .center
        title.text = "Republic OF Korea"
        title.textColor = .label
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    
    let medalsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "medal_View")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let gold: UILabel = {
        let title = UILabel()
        
        title.font = .preferredFont(forTextStyle: .title3)
        title.textAlignment = .center
        title.text = "999"
        title.textColor = .label
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    
    let silver: UILabel = {
        let title = UILabel()
        
        title.font = .preferredFont(forTextStyle: .title3)
        title.textAlignment = .center
        title.text = "9"
        title.textColor = .label
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    
    let bronze: UILabel = {
        let title = UILabel()
        
        title.font = .preferredFont(forTextStyle: .title3)
        title.textAlignment = .center
        title.text = "99"
        title.textColor = .label
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    
    let nationStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        return stackView
    }()
    
    let medalStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
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
            
            medalStackView.topAnchor.constraint(equalTo: medalsImage.bottomAnchor),
            medalStackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 75),
            medalStackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -75),
            medalStackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
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
