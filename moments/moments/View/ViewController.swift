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
    var allTweets: [Tweet] = []
    var displayTweets: [Tweet] = []
    
    var currentPage = 0
    var numberInEachPage = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 300
        
        self.fetchData()
    }

    private func fetchData(){
        self.viewModel.fetchProfile()
        self.viewModel.didUpdateProfile = { [weak self] profile in
            self?.profile = profile;
            self!.renderHeader()
            self?.tableView.reloadData()
        }
        
        self.viewModel.fetchMomonts()
        self.viewModel.didUpdateMomonts = { [weak self] tweets in
            self?.allTweets = tweets
            self?.displayTweets = self!.getNewTweets()
            self?.tableView.reloadData()
        }
    }
    
    private func getNewTweets() -> [Tweet]{
        var newTweets: [Tweet] = []
        if((self.displayTweets.count) + self.numberInEachPage < (self.allTweets.count)){
            newTweets = allTweets[(self.currentPage * self.numberInEachPage)..<( (self.currentPage + 1) * self.numberInEachPage)].map { $0 }
            self.currentPage += 1
        }else {
            newTweets = allTweets[(self.currentPage * self.numberInEachPage)..<self.allTweets.count].map { $0 }
            self.currentPage += 1
        }
        return newTweets
    }
    
    private func renderHeader(){
        let tableHeader =  Bundle.main.loadNibNamed("TableHeaderView", owner: nil, options: nil)?.first as! TableHeaderView
        
        guard let profile = self.profile else {
            return
        }
        tableHeader.configure(with: profile)
        self.tableView.tableHeaderView = tableHeader
    }
    
    @objc func loadMore(){
        self.displayTweets.append(contentsOf: self.getNewTweets())
        self.tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Let the UITableView know about your data
        return displayTweets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get back the cell using the reuseIdentifier
        // UITableView will create a new cell or reuse an existing cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: displayTweets[indexPath.row])
        return cell
    }
}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == displayTweets.count - 1 {
//            print(indexPath.row, allTweets.count, displayTweets.count)
            if(displayTweets.count < allTweets.count){
                self.perform(#selector(loadMore), with: nil, afterDelay: 1.0)
            }
        }
    }
    
}
