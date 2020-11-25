//
//  RawDetailsViewController.swift
//  GitHubSearch
//
//  Created by Apple on 25/11/20.
//

import UIKit

class RawDetailsViewController: UIViewController, UITableViewDataSource {

    @IBOutlet var tblRawDetails: UITableView!
    var issue: Issue?
    var contributor: Contributor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblRawDetails.dataSource = self
        tblRawDetails.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if issue != nil {
//            return 1
//        } else if contributor != nil {
//
//        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        if issue != nil {
            let arrData = issue.debugDescription.replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: "GitHubSearch.Issue(", with: "").components(separatedBy: "),")
            cell.textLabel?.attributedText = dataFontChange(arrData: arrData)
        } else if contributor != nil {
            let arrData = contributor.debugDescription.replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: "GitHubSearch.Contributor(", with: "").components(separatedBy: "),")
            cell.textLabel?.attributedText = dataFontChange(arrData: arrData)
        }
        return cell
    }
    
    func dataFontChange(arrData: [String]) -> NSMutableAttributedString {
        let attributedStrings = NSMutableAttributedString(string: "")
        for string in arrData {
            attributedStrings.append(NSMutableAttributedString().changeTextColor(string: NSMutableString(string: string), stringColor: string.components(separatedBy: ":")[0], font: 15, fontColor: 20, newLine: true))
        }
        return attributedStrings
    }
}
