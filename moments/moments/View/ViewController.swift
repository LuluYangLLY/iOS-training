//
//  ViewController.swift
//  moments
//
//  Created by Yang Lulu  on 2020/6/22.
//  Copyright © 2020 Yang Lulu . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let viewModel: MomentsViewModel = MomentsViewModel()
    var profile: Profile!
    var allTweets: [Tweet]!
    var disPlayTweets: [Tweet]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 300
        tableView.rowHeight = 500

        self.fetchData()

    }
    
    private func fetchData(){
        self.viewModel.fetchProfile()
        self.viewModel.didUpdateProfile = { [weak self] profile in
            print(profile)
            self?.profile = profile;
            self!.renderHeader()
            self?.tableView.reloadData()
        }
        
        self.viewModel.fetchMomonts()
        self.viewModel.didUpdateMomonts = { [weak self] tweets in
//            print(tweets)
            self?.allTweets = tweets
            self?.disPlayTweets = self!.getDisPlayTweets()
            self?.tableView.reloadData()
        }
//
    }
    
    private func getDisPlayTweets() -> [Tweet]{
        return self.allTweets[0..<2].map { $0 }.reversed()
    }
    
    private func renderHeader(){
        let tableHeader =  Bundle.main.loadNibNamed("TableHeaderView", owner: nil, options: nil)?.first as! TableHeaderView
        
        guard let profile = self.profile else {
            return
        }
        tableHeader.configure(with: profile)
        self.tableView.tableHeaderView = tableHeader
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Let the UITableView know about your data
        return disPlayTweets?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get back the cell using the reuseIdentifier
        // UITableView will create a new cell or reuse an existing cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: disPlayTweets![indexPath.row])
        return cell
    }
}
