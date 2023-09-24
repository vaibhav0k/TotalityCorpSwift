//
//  SecondViewController.swift
//  TotalityCorpAssignment
//
//  Created by Vaibhav Shah on 22/09/23.
//


import UIKit

class SecondViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource{

    @IBOutlet weak var one: UIButton!

    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var two: UIButton!

    @IBOutlet weak var three: UIButton!
    @IBOutlet weak var firstButtonCircle: UIButton!

    @IBOutlet weak var secondNextButton: UIButton!
    @IBOutlet weak var thirdButtonCircle: UIButton!
    
    @IBOutlet weak var secondButtonCircle: UIButton!
  
    
    @IBOutlet weak var emptyLabelFirstViewPopup: UILabel!
    @IBOutlet weak var collectionview: UICollectionView!
   @IBOutlet var nextbutton:UIButton!
    
    @IBOutlet var secondbutton:UIButton!


    @IBOutlet var FirstViewPopup:UIView!
    
    @IBOutlet var SecondViewPopup:UIView!
    
    @IBOutlet var ThirdViewPopup:UIView!
    
    var selectedindex:Int?
    var iscollapse=false
    let animationDuration: Double = 1.0
    let delayBase: Double = 1.0
    
    
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.delegate=self
        tableView.dataSource=self
        
        tableviewSetup()

        firstButtonCircle.layer.cornerRadius = firstButtonCircle.frame.size.width / 2
        secondButtonCircle.layer.cornerRadius = secondButtonCircle.frame.size.width / 2
        thirdButtonCircle.layer.cornerRadius = thirdButtonCircle.frame.size.width / 2

        
        one.layer.cornerRadius = one.frame.size.width / 2
        two.layer.cornerRadius = two.frame.size.width / 2
        three.layer.cornerRadius = three.frame.size.width / 2
        

        ThirdViewPopup.isHidden=true
        SecondViewPopup.isHidden=true
        FirstViewPopup.isHidden=true
        tableviewSetup()
        tableView.reloadData()

        
        confirmButton.layer.cornerRadius = 20
        nextbutton.layer.cornerRadius = 20
        secondNextButton.layer.cornerRadius=20

    }
    
    
    @IBAction func FirstNextAction(_ sender: Any) {
        SecondViewPopup.isHidden=false
        UIView.animate(withDuration: 1.0, animations: {
            self.firstButtonCircle.alpha = 0.0
        }) { (completed) in
            if completed {
                self.firstButtonCircle.alpha = 1
            }
        }
    }

    @IBAction func ConfirmAction(_ sender: Any) {
        SecondViewPopup.isHidden=true
        FirstViewPopup.isHidden=true
        ThirdViewPopup.isHidden=true
    }

    @IBAction func SecondNextAction(_ sender: Any) {
        ThirdViewPopup.isHidden=false
        FirstViewPopup.isHidden=true
        SecondViewPopup.isHidden=true

    }
    
    
    //TableView SetUp
    
    func tableviewSetup(){
        tableView.isScrollEnabled = false
        setCollectionViewLayouts()
        tableView.register(UINib(nibName:"SecondTableViewCell" , bundle: Bundle.main), forCellReuseIdentifier: "SecondTableViewCell")
        tableView.register(UINib(nibName:"DownloadTableViewCell" , bundle: Bundle.main), forCellReuseIdentifier: "DownloadTableViewCell")
    }
    
    func setCollectionViewLayouts(){
        collectionview.delegate=self
        collectionview.dataSource=self
        let flowLayout=UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize=CGSize(width: 100, height: 120)
        flowLayout.sectionInset.left = 20
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 20
        collectionview.setCollectionViewLayout(flowLayout, animated: true)
        collectionview.register(ItemInboxCollectionViewCell.nib, forCellWithReuseIdentifier: ItemInboxCollectionViewCell.identifier)
    }


//MARK: - Table View Code for Second View Controller
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        
        switch section{
            
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell") as! SecondTableViewCell
            cell.yellowImage.layer.cornerRadius = 15
            cell.readMoreButton.addTarget(self, action: #selector(readmore), for: .touchUpInside)
            cell.cancelButton.addTarget(self, action: #selector(cancle), for: .touchUpInside)
            cell.readMoreButton.tag = indexPath.row
            cell.alpha = 0
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DownloadTableViewCell") as! DownloadTableViewCell
           
            cell.PlayButton.addTarget(self, action: #selector(New), for: .touchUpInside)
            cell.alpha = 0
            return cell
            
        default:
            break
        }
    
        return UITableViewCell()
        
    }
    
    
//MARK: - CollectionView Code for First popup Item

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemInboxCollectionViewCell.identifier, for: indexPath) as? ItemInboxCollectionViewCell else { return UICollectionViewCell() }
        cell.alpha = 0
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        UIView.animate(withDuration: 1, delay: 0.5*Double(indexPath.item), animations: {
                cell.alpha = 1
        })
    }
    
    //MARK: - Action Function
    
    @objc func New(){
        FirstViewPopup.isHidden=false
    }
    
    /* Action on Clicking Readmore */
    @objc func readmore(sender:UIButton){
       
            let index = sender.tag
            let indexpath1 = IndexPath(row:sender.tag,section: 0)
            if selectedindex == index{
                selectedindex = nil
            }else{
                selectedindex = index
            }
        tableView.reloadRows(at:[indexpath1],with:.automatic)
        tableView.endUpdates()

    }
    
    /* On Clicking Cross */
    @objc func cancle(sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Table View Code for Display
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let section = indexPath.section
        
        switch section{
            
        case 0 :
             
            cell.alpha = 0
            UIView.animate(withDuration: 0.5, delay: 0.5*Double(indexPath.row),animations: {
                cell.alpha = 1
            })
            
        case 1 :
            
            cell.transform = CGAffineTransform(translationX:  cell.contentView.frame.height, y: cell.contentView.frame.width)
            cell.alpha=1
            
        default:
            break
            
        }
    }
        
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = indexPath.section
        
        switch section{
            
        case 0 :
            if self.selectedindex == indexPath.section{
                return 400
            }else{
                return 220
            }
            
        case 1 :
            return 500
            
        default:
            break
            
        }
        
        return 0
    
    }
}

    
/* Nib and Identifier Extension for Collection View */

extension UICollectionViewCell {
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
