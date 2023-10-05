//
//  MainViewController.swift
//  K-AGScore
//
//  Created by Baem on 2023/10/05.
//

import UIKit

class MainViewController: UIViewController {
    private let koreaView: UIView = {
        let uiView = UIView()
        uiView.translatesAutoresizingMaskIntoConstraints = false
        
        return uiView
    }()
    
    private let scoreTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setupConstraints()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(koreaView)
        view.addSubview(scoreTableView)

        configureTableView()
        setupConstraints()
    }
    
    private func configureTableView() {
        scoreTableView.dataSource = self
        scoreTableView.register(ScoreTableViewCell.self, forCellReuseIdentifier: ScoreTableViewCell.reuseIdentifier)
    }
    
    private func setupConstraints() {
        setupTableViewConstraints()
        setupKoreaViewConstraints()
    }
    
    private func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            koreaView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            koreaView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3),
            koreaView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            koreaView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            koreaView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    private func setupKoreaViewConstraints() {
        NSLayoutConstraint.activate([
            scoreTableView.topAnchor.constraint(equalTo: koreaView.bottomAnchor),
            scoreTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scoreTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scoreTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ScoreTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? ScoreTableViewCell
        else {
            return UITableViewCell()
        }
        
        cell.rankLabel.text = "1"
        cell.flagImage.image = UIImage(named: "KOR")
        cell.nationLabel.text = "Korea 대한민구우욱"
        cell.goldLabel.text = "50"
        cell.silverLabel.text = "77"
        cell.bronzeLabel.text = "111"
        cell.totalLabel.text = "222"
        
        return cell
    }
}
