//
//  ScoreTableViewHeaderView.swift
//  K-AGScore
//
//  Created by MARY on 2023/10/05.
//

import UIKit

final class ScoreTableViewHeaderView: UITableViewHeaderFooterView {
    let rankLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "순위"
        label.textColor = .systemGray6
        
        return label
    }()
    
    let nationLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.text = "국가"
        label.textColor = .systemGray6

        return label
    }()
    
    let goldLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.textAlignment = .center
        label.text = "금"
        label.textColor = .systemGray6

        return label
    }()
    
    let silverLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.textAlignment = .center
        label.text = "은"
        label.textColor = .systemGray6

        return label
    }()
    
    let bronzeLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.textAlignment = .center
        label.text = "동"
        label.textColor = .systemGray6

        return label
    }()
    
    let totalLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.textAlignment = .center
        label.text = "합계"
        label.textColor = .systemGray6

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
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        configureUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        nationStackView.addArrangedSubview(nationLabel)
        
        medalStackView.addArrangedSubview(goldLabel)
        medalStackView.addArrangedSubview(silverLabel)
        medalStackView.addArrangedSubview(bronzeLabel)
        medalStackView.addArrangedSubview(totalLabel)
        
        scoreStackView.addArrangedSubview(rankLabel)
        scoreStackView.addArrangedSubview(nationStackView)
        scoreStackView.addArrangedSubview(medalStackView)
        
        contentView.addSubview(scoreStackView)
        contentView.backgroundColor = .systemOrange
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scoreStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            scoreStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            scoreStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            scoreStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            rankLabel.widthAnchor.constraint(equalTo: scoreStackView.widthAnchor, multiplier: 0.15),
            nationStackView.leadingAnchor.constraint(equalTo: rankLabel.trailingAnchor),
            nationStackView.trailingAnchor.constraint(equalTo: medalStackView.leadingAnchor),
            medalStackView.widthAnchor.constraint(equalTo: scoreStackView.widthAnchor, multiplier: 0.5),
            medalStackView.trailingAnchor.constraint(equalTo: scoreStackView.trailingAnchor),
        ])
    }
}
