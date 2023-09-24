//
//  ViewController.swift
//  TotalityCorpAssignment
//
//  Created by Vaibhav Shah on 22/09/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate=self
        tableView.dataSource=self
        tableView.register(UINib(nibName:"HomeTableViewCell" , bundle: Bundle.main), forCellReuseIdentifier: "HomeTableViewCell")
    }
    

    //MARK: - Table View Fuctions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        
        switch section{
        
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
            
            return cell
    
        default:
            break
        }
        
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = indexPath.section
        
        switch section{
        case 0 :
            return 500
        default:
            break
        }
        
        return 0
    }
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(identifier: "SecondViewController") as! SecondViewController
        nextVC.hidesBottomBarWhenPushed = true
        nextVC.modalPresentationStyle = .custom
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
