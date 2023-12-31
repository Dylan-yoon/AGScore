//
//  MainViewController.swift
//  K-AGScore
//
//  Created by Baem on 2023/10/05.
//

import UIKit
import SafariServices

class MainViewController: UIViewController {
    private var datas: [ScoreData]?
    
    private let bannerView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "banner")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let nationMedalView: NationMedalView = {
        let view = NationMedalView()
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
        view.addSubview(nationMedalView)
        view.addSubview(scoreTableView)
        view.addSubview(bannerView)
        
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
        setupBannerViewConstraints()
        setupTableViewConstraints()
        setupKoreaViewConstraints()
    }
    
    private func setupBannerViewConstraints() {
        NSLayoutConstraint.activate([
            bannerView.topAnchor.constraint(equalTo: view.topAnchor),
            bannerView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.15),
            bannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            nationMedalView.topAnchor.constraint(equalTo: bannerView.bottomAnchor),
            nationMedalView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3),
            nationMedalView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            nationMedalView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    private func setupKoreaViewConstraints() {
        NSLayoutConstraint.activate([
            scoreTableView.topAnchor.constraint(equalTo: nationMedalView.bottomAnchor),
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
        
        if indexPath.row == 0 {
            cell.backgroundColor = UIColor(named: "gold")
        } else if indexPath.row == 1 {
            cell.backgroundColor = UIColor(named: "silver")
        } else if indexPath.row == 2 {
            cell.backgroundColor = UIColor(named: "bronze")
        } else {
            cell.backgroundColor = UIColor.clear
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        nationMedalView.configureView(datas![indexPath.row])
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let link = datas![indexPath.row].link
        
        let openURL = UIContextualAction(style: .normal, title: "메달 정보") {_,_,_ in
            guard let url = URL(string: link) else { return }
            let safariViewController = SFSafariViewController(url: url)
            self.present(safariViewController, animated: true, completion: nil)
        }
        
        let actions = UISwipeActionsConfiguration(actions: [openURL])
        
        return actions
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
