//
//  MainViewController.swift
//  K-AGScore
//
//  Created by Baem on 2023/10/05.
//

import UIKit

class MainViewController: UIViewController {
    private let koreaMedalView: UIView = {
        let view = KoreaMedalView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
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
        view.addSubview(koreaMedalView)
        view.addSubview(scoreTableView)

        configureTableView()
        setupConstraints()
    }
    
    private func configureTableView() {
        scoreTableView.dataSource = self
        scoreTableView.delegate = self
        scoreTableView.register(ScoreTableViewCell.self, forCellReuseIdentifier: ScoreTableViewCell.reuseIdentifier)
        scoreTableView.register(ScoreTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: ScoreTableViewHeaderView.reuseIdentifier)
    }
    
    private func setupConstraints() {
        setupTableViewConstraints()
        setupKoreaViewConstraints()
    }
    
    private func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            koreaMedalView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            koreaMedalView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3),
            koreaMedalView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            koreaMedalView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    private func setupKoreaViewConstraints() {
        NSLayoutConstraint.activate([
            scoreTableView.topAnchor.constraint(equalTo: koreaMedalView.bottomAnchor),
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
        cell.totalMedalLabel.text = "222"
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let scoreTableViewHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ScoreTableViewHeaderView.reuseIdentifier) as? ScoreTableViewHeaderView else {
            return UIView()
        }
        
        return scoreTableViewHeaderView
    }
}
