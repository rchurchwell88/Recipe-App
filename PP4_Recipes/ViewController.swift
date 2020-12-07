//
//  ViewController.swift
//  PP4_Recipes
//
//  Created by Russell Churchwell on 11/25/20.
//

import UIKit
import FirebaseAuth
import Firebase
import AVKit

class ViewController: UIViewController {
    
    var player:AVPlayer?
    var playerLayer:AVPlayerLayer?

    
    @IBOutlet weak var lO: UIImageView!
    @IBOutlet weak var vO: UIView!
    @IBOutlet weak var LoginO: UIButton!
    @IBAction func toRegister(_ sender: UIButton) {
        
        if sender.tag == 0{
            performSegue(withIdentifier: "toLogin", sender: self)
        }
        
        else{
            performSegue(withIdentifier: "toRegister", sender: self)
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .portrait
        } else {
            return .all
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupLRBackground()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func testPushUser(){
        Auth.auth().createUser(withEmail: "worked@worked.com", password: "password", completion: nil)
    }
    
    func setupLRBackground(){
        let vidRoot = Bundle.main.path(forResource: "Chef", ofType: "mp4")
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
        
        self.view.bringSubviewToFront(vO)
        self.view.bringSubviewToFront(lO)
        
    }

}

