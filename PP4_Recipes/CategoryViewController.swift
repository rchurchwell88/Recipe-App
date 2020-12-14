//
//  CategoryViewController.swift
//  PP4_Recipes
//
//  Created by Russell Churchwell on 12/12/20.
//

import UIKit
import AVKit

class CategoryViewController: UIViewController {

    var tmpText:String?
    var player:AVPlayer?
    var playerLayer:AVPlayerLayer?
    
    @IBOutlet weak var sView: UIView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var sButton: UIButton!
    @IBOutlet weak var lO: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupLRBackground()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .portrait
        } else {
            return .all
        }
    }
    
    @IBAction func searchAction(_ sender: UIButton) {
        var tmpString=searchField.text
        tmpString=tmpString?.replacingOccurrences(of: " ", with: "+")
        
        self.tmpText=tmpString
        
        performSegue(withIdentifier: "recipeResultSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as?RecipesVCTableViewController
        
        dest?.category=tmpText
    }
    
    func setupLRBackground(){
        let vidRoot = Bundle.main.path(forResource: "Chef4", ofType: "mp4")
        let vidURL = URL(fileURLWithPath: vidRoot!)
        
        
        let vid = AVPlayerItem(url: vidURL)
        
        player = AVPlayer(playerItem: vid)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = self.view.bounds
        playerLayer?.videoGravity = .resizeAspectFill
        self.view.layer.addSublayer(playerLayer!)
        
        player?.play()
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem, queue: .main) { [weak self] _ in
            self?.player?.seek(to: CMTime.zero)
            self?.player?.play()
        }
        
        self.view.bringSubviewToFront(sView)
        self.view.bringSubviewToFront(searchField)
        self.view.bringSubviewToFront(sButton)
        self.view.bringSubviewToFront(lO)
        
        
    }
}
