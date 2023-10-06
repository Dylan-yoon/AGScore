//
//  ScoreTableViewCell.swift
//  K-AGScore
//
//  Created by MARY on 2023/10/05.
//

import UIKit

final class ScoreTableViewCell: UITableViewCell {
    let rankLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let flagImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()
    
    let nationLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)

        return label
    }()
    
    let goldLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.textAlignment = .center

        return label
    }()
    
    let silverLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.textAlignment = .center

        return label
    }()
    
    let bronzeLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.textAlignment = .center

        return label
    }()
    
    let totalMedalLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.textAlignment = .center

        return label
    }()
    
    let nationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        return stackView
    }()
    
    private let medalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        return stackView
    }()
    
    private let scoreStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        setupConstraints()
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.backgroundColor = .label
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(data: ScoreData) {
        rankLabel.text = data.rank
        flagImage.image = UIImage(named: data.alpha3)
        nationLabel.text = data.alpha3
        goldLabel.text = data.gold
        silverLabel.text = data.silver
        bronzeLabel.text = data.bronze
        totalMedalLabel.text = data.totalMedal
    }
    
    private func configureUI() {
        nationStackView.addArrangedSubview(flagImage)
        nationStackView.addArrangedSubview(nationLabel)
        
        medalStackView.addArrangedSubview(goldLabel)
        medalStackView.addArrangedSubview(silverLabel)
        medalStackView.addArrangedSubview(bronzeLabel)
        medalStackView.addArrangedSubview(totalMedalLabel)
        
        scoreStackView.addArrangedSubview(rankLabel)
        scoreStackView.addArrangedSubview(nationStackView)
        scoreStackView.addArrangedSubview(medalStackView)
        
        contentView.addSubview(scoreStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scoreStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            scoreStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            scoreStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            scoreStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            rankLabel.widthAnchor.constraint(equalTo: scoreStackView.widthAnchor, multiplier: 0.15),
            nationStackView.leadingAnchor.constraint(equalTo: rankLabel.trailingAnchor),
            nationStackView.trailingAnchor.constraint(equalTo: medalStackView.leadingAnchor),
            medalStackView.widthAnchor.constraint(equalTo: scoreStackView.widthAnchor, multiplier: 0.5),
            medalStackView.trailingAnchor.constraint(equalTo: scoreStackView.trailingAnchor),
            
            flagImage.widthAnchor.constraint(equalTo: scoreStackView.widthAnchor, multiplier: 0.1),
            flagImage.heightAnchor.constraint(equalTo: flagImage.widthAnchor),
        ])
    }
}
