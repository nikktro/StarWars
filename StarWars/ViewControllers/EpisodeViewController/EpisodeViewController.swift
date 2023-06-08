//
//  EpisodeViewController.swift
//  StarWars
//
//  Created by Nikolay Trofimov on 07.06.2023.
//

import UIKit

typealias TableViewProtocols = UITableViewDelegate & UITableViewDataSource

class EpisodeViewController: UIViewController {

  private var tableView: UITableView!
  private var episodes: [Episode] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    configureTableView()
    fetchEpisodes(from: Link.films.rawValue)
  }
}

private extension EpisodeViewController {
  func configureTableView() {
    setupUI()
    setupCell()
    setupTableViewDelegateAndDataSource()
  }

  func setupUI() {
    setupTableView()
    title = "Episodes"
  }

  func setupTableView() {
    tableView = UITableView(frame: view.frame)
    view.addSubview(tableView)
  }

  func setupCell() {
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "episode")
  }

  func setupTableViewDelegateAndDataSource() {
    tableView.delegate = self
    tableView.dataSource = self
  }
}

private extension EpisodeViewController {
  func fetchEpisodes(from url: String?) {
    NetworkManager.shared.fetchData(from: url, dataType: Saga.self) { saga in
      self.episodes = saga.results
      self.tableView.reloadData()
    }
  }
}

extension EpisodeViewController: TableViewProtocols {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    episodes.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "episode", for: indexPath)
    cell.textLabel?.text = episodes[indexPath.row].title
    return cell
  }
}
