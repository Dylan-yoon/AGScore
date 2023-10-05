//
//  MainViewController.swift
//  K-AGScore
//
//  Created by Baem on 2023/10/05.
//

import UIKit

class MainViewController: UIViewController {
    private var datas: [ScoreData]?
    
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
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl: UIRefreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setupConstraints()
        refreshData()
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
        scoreTableView.refreshControl = refreshControl
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

extension MainViewController {
    @objc private func refreshData() {
        NetworkManager.parsingData { result in
            switch result {
                case .success(let data):
                    self.datas = data
                case .failure(let error):
                    print(error)
            }
            
            DispatchQueue.main.async {
                self.scoreTableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ScoreTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? ScoreTableViewCell
        else {
            return UITableViewCell()
        }
        
        guard let data = datas?[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.configureCell(data: data)
        
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
