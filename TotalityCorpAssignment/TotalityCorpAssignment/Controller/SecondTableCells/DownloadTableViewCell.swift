//
//  DownloadTableViewCell.swift
//  TotalityCorpAssignment
//
//  Created by Vaibhav Shah on 23/09/23.
//

import UIKit
import Loady
import IBAnimatable


class DownloadTableViewCell: UITableViewCell {
    
    
    
    
  
    @IBOutlet var CancleButton : LoadyButton!
    @IBOutlet var PlayButton : AnimatableButton!
    @IBOutlet var StackView : UIStackView!
    
    var tempTimer1 : Timer?
    var tempTimer2 : Timer?
    var tempTimer3 : Timer?
    var tempTimer4 : Timer?
    var fourPhaseTempTimer : Timer?
    
    @IBOutlet var fourPhaseButton : LoadyFourPhaseButton!
    
    @IBOutlet weak var downloadButton: LoadyButton!
    
    @IBOutlet var picCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        collectionViewSetup()
        CancleButton.isHidden=true
        PlayButton.isHidden=true
        self.downloadButton.addTarget(self, action:#selector(downloadButtonAnimate(_:)), for:.touchUpInside)
        self.downloadButton.setAnimation(LoadyAnimationType.backgroundHighlighter())
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func play(_ sender : UIButton){
        

        
    }
    
    @IBAction func downloadButtonAnimate(_ sender : UIButton){
        if let button = sender as? LoadyFourPhaseButton {
            if button.loadingIsShowing() {
                button.stopLoading()
                return
            }
            button.startLoading()
            self.fourPhaseTempTimer?.invalidate()
            self.fourPhaseTempTimer = nil
            self.fourPhaseButton.loadingPhase()
            if #available(iOS 10.0, *) {
                self.fourPhaseTempTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true){(t) in
                    if self.fourPhaseButton.tag  == 0 {
                        self.fourPhaseButton.errorPhase()
                        self.fourPhaseButton.tag = 1
                    }else if self.fourPhaseButton?.tag  == 1{
                        self.fourPhaseButton.successPhase()
                        self.fourPhaseButton.tag = 2
                    } else{
                        self.fourPhaseButton.normalPhase()
                        self.fourPhaseButton.tag = 0
                    }
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.fourPhaseTempTimer?.fire()
            }
            return
        }
        
        guard let button = sender as? LoadyButton else {
            return
        }
        if button.loadingIsShowing() {
            button.stopLoading()
            return
        }
        button.startLoading()
        var percent : CGFloat = 0
        switch button.animationType {
        case LoadyBackgroundHighlighterAnimation.animationTypeKey:
            self.tempTimer1?.invalidate()
            self.tempTimer1 = nil
            if #available(iOS 10.0, *) {
                self.tempTimer1 = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (t) in
                    percent += CGFloat.random(in: 0...10)
                    button.update(percent: percent)
                    if percent > 105 {
                        percent = 60
                        self.tempTimer1?.invalidate()
                        print("Download")
                        self.CancleButton.setImage(UIImage(named: "checkmark.seal.fill"), for: .normal)
                        self.CancleButton.setImage(UIImage(systemName: "checkmark.seal.fill")?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal), for: .normal)
                        
                    
                        percent = 100
                        print("Download100")
                        self.CancleButton.isHidden=true
                        self.StackView.isHidden=true
                        self.PlayButton.isHidden=false

                    }
                    
                    
                }
                self.CancleButton.isHidden=false
                
            }
            

            self.tempTimer1?.fire()
            
        case LoadyCircleAndTickAnimation.animationTypeKey:
            self.tempTimer2?.invalidate()
            self.tempTimer2 = nil
            if #available(iOS 10.0, *) {
                self.tempTimer2 = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (t) in
                    percent += CGFloat.random(in: 0...10)
                    button.update(percent: percent)
                    if percent > 105 {
                        percent = 100
                        self.tempTimer2?.invalidate()
                       
                    }
                   
                }
              
            }
            
            self.tempTimer2?.fire()
            
        case LoadyAppStoreAnimation.animationTypeKey:
            self.tempTimer3?.invalidate()
            self.tempTimer3 = nil
            if #available(iOS 10.0, *) {
                self.tempTimer3 = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (t) in
                    percent += CGFloat.random(in: 0...10)
                    button.update(percent: percent)
                    
                    if percent > 105 {
                        percent = 100
                        self.tempTimer3?.invalidate()
                    }
                    
                }
            }
            self.tempTimer3?.fire()
        case LoadyDownloadingAnimation.animationTypeKey:
            self.tempTimer4?.invalidate()
            self.tempTimer4 = nil
            if #available(iOS 10.0, *) {
                self.tempTimer4 = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true){(t) in
                    percent += CGFloat.random(in: 5...10)
                    
                    button.update(percent: percent)
                    if percent > 105 {
                        percent = 100
                        self.tempTimer4?.invalidate()
                    }
                }
            }
            self.tempTimer4?.fire()
        default:
            break;
        }
    }
    
    
    
    
    
    /*  Collection View Identifier Function */
    
    private func collectionViewSetup(){
        
        picCollectionView.delegate=self
        picCollectionView.dataSource=self
        picCollectionView.register(UINib(nibName: "CollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "CollectionViewCell")
        setCollectionViewLayouts()
    }
    
    // Flow Layout for Collection View
    func setCollectionViewLayouts(){
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            
            layout.itemSize=CGSize(width: 240, height: 440)
            layout.minimumLineSpacing = 5
            layout.minimumInteritemSpacing = 5
            picCollectionView.setCollectionViewLayout(layout, animated: true)
          
        }

}

//MARK: - Extending for Collection View


extension DownloadTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        
        
        return cell
    }
    
}
