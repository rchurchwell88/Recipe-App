//
//  RegisterVC.swift
//  PP4_Recipes
//
//  Created by Russell Churchwell on 12/2/20.
//

import UIKit
import AVKit
import FirebaseAuth

class RegisterVC: UIViewController, UITextFieldDelegate {
    
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    
    

    @IBOutlet weak var canO: UIButton!
    @IBOutlet weak var errO: UILabel!
    @IBOutlet weak var tF2: UITextField!
    @IBOutlet weak var tF1: UITextField!
    @IBOutlet weak var rBO: UIButton!
    @IBOutlet weak var iFVO: UIView!
    @IBOutlet weak var lO: UIImageView!
    
    
    
    @IBAction func regAct(_ sender: UIButton) {
        pushData()
    }
    
    @IBAction func canAct(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tF1.delegate = self
        self.tF2.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupLRBackground()
    }
    
    func setupLRBackground(){
        let vidRoot = Bundle.main.path(forResource: "Chef2", ofType: "mp4")
        let vidURL = URL(fileURLWithPath: vidRoot!)
        
        
        let vid = AVPlayerItem(url: vidURL)
        
        player = AVPlayer(playerItem: vid)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = self.view.bounds
        playerLayer?.videoGravity = .resizeAspectFill
        self.view.layer.addSublayer(playerLayer!)
        
        self.view.bringSubviewToFront(lO)
        self.view.bringSubviewToFront(rBO)
        self.view.bringSubviewToFront(iFVO)
        self.view.bringSubviewToFront(tF2)
        self.view.bringSubviewToFront(tF1)
        self.view.bringSubviewToFront(canO)
        
        player?.play()
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem, queue: .main) { [weak self] _ in
            self?.player?.seek(to: CMTime.zero)
            self?.player?.play()
        }
        
    }
    
    func pushData(){
        let email = (!tF1.text!.isEmpty) ? tF1.text : nil
        let password = (!tF2.text!.isEmpty) ? tF2.text : nil
        
        if email != nil && password != nil{
            Auth.auth().createUser(withEmail: email!, password: password!) { (result, error) in
                if error != nil{
                    self.errO.text = "EMAIL OR PASSWORD IS INVALID!"
                    self.errO.alpha = 1
                }
                else{
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        
        else{
            self.errO.text = "NOT ALL FIELDS ARE FILLED IN!"
            errO.alpha = 1
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
