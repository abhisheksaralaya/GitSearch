//
//  ViewController.swift
//  GitHubSearch
//
//  Created by Apple on 24/11/20.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var repositoryViewModel: RepositoryViewModel!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tblRepo: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblRepo.dataSource = self
        self.tblRepo.delegate = self
        searchBar.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.showSpinner(onView: self.view)
        repositoryViewModel.getData(apiName: "Search", paramaters: searchText, completion:  {
            self.tblRepo.reloadData()
            self.removeSpinner()
        })
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositoryViewModel.repoNumbers()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as? RepositoryListCell
        // labels are created using view model
        cell?.lblName.text = repositoryViewModel.repoName(indexPath: indexPath)
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RepositoryDetailsViewController") as! RepositoryDetailsViewController
        controller.fullName = repositoryViewModel.fullName(indexPath: indexPath)
        controller.descriptionText = repositoryViewModel.description(indexPath: indexPath)
        self.navigationController?.pushViewController(controller, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

class RepositoryListCell : UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        layoutIfNeeded()
    }
}

