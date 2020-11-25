//
//  RepositoryDetailsViewController.swift
//  GitHubSearch
//
//  Created by Apple on 24/11/20.
//

import UIKit

class RepositoryDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var repositoryViewModel: RepositoryViewModel!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    var fullName = ""
    var descriptionText = ""

    @IBOutlet weak var tblRepo: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        tblRepo.dataSource = self
        tblRepo.delegate = self
        if !fullName.isEmpty {
            lblName.attributedText = NSMutableAttributedString().changeTextColor(string: NSMutableString(string:"Name: \(fullName)"), stringColor: "Name", font: 15, fontColor: 20, newLine: true)
            if !descriptionText.isEmpty {
                lblDescription.attributedText = NSMutableAttributedString().changeTextColor(string: NSMutableString(string:"Description: \(descriptionText)"), stringColor: "Description", font: 15, fontColor: 20, newLine: true)
//                lblDescription.text = "Description: \(descriptionText)"
            } else {
                lblDescription.text = ""
            }
//            let alertController = UIAlertController(title: "Loading ..",
//                                                    message: "Please wait",
//                                                    preferredStyle: .alert)
//            self.present(alertController, animated: true, completion: nil)
            self.showSpinner(onView: self.view)
            repositoryViewModel.getData(apiName: "Issue", paramaters: fullName, completion:  {
                self.repositoryViewModel.getData(apiName: "Contributors", paramaters: self.fullName, completion:  {
                    self.tblRepo.reloadData()
                    self.removeSpinner()
                })
            })
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return repositoryViewModel.numberOfSections() ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return repositoryViewModel.numberOfIssues() ?? 0
        } else {
            return repositoryViewModel.numberOfContributors() ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
            if indexPath.section == 0 {
                cell.textLabel!.text = "Issue"
                cell.textLabel?.font = .boldSystemFont(ofSize: 21)
            } else if indexPath.section == 1 {
                cell.textLabel!.text = "Contributors"
                cell.textLabel?.font = .boldSystemFont(ofSize: 21)
            } else {
                cell.textLabel?.text = ""
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
            cell.textLabel?.numberOfLines = 0
            if indexPath.section == 0 {
                cell.textLabel!.text = "    \(repositoryViewModel.issueTitle(indexPath: indexPath))"
                cell.textLabel?.font = .systemFont(ofSize: 15)
            } else {
                cell.textLabel!.text = "    \(repositoryViewModel.contributorLogin(indexPath: indexPath))"
                cell.textLabel?.font = .systemFont(ofSize: 15)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RawDetailsViewController") as! RawDetailsViewController
        if indexPath.section == 0 {
            if let issue = repositoryViewModel.issue(indexPath: indexPath) {
                controller.issue = issue
            }
        } else {
            if let contributor = repositoryViewModel.contributor(indexPath: indexPath) {
                controller.contributor = contributor
            }
        }
        self.navigationController?.pushViewController(controller, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
