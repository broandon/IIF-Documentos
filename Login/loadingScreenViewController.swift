//
//  loadingScreenViewController.swift
//  IIF Documentos
//
//  Created by Brandon Gonzalez on 04/03/20.
//  Copyright © 2020 Brandon Gonzalez. All rights reserved.
//

import UIKit
import AVKit
import LazyFadeInView
import Hero

class loadingScreenViewController: UIViewController {
    
    //MARK: Outlets
    
    var player : AVPlayer?
    @IBOutlet weak var loadingVideo: UIView!
    @IBOutlet weak var welcomeSign: LazyFadeInView!
    
    //MARK: viewDid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkLoggedStatus()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        player?.play()
        
    }
    
    //MARK: Funcs
    
    func configureView() {
        
        welcomeSign.isHidden = false
        welcomeSign.text = "¡Bienvenido! Inicia sesión."
        welcomeSign.textColor = .white
        welcomeSign.interval = 0.01
        
    }
    
    func presentTheMainViewController() {
        
        self.hero.isEnabled = true
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "mainViewController") as! mainViewController
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.hero.modalAnimationType = .fade
        
        self.hero.replaceViewController(with: newViewController)
        
    }
    
    func checkLoggedStatus() {
        
        if UserDefaults.standard.bool(forKey: "loggedIn") == true {
            
            initializeVideoPlayerWithVideo()
            
        } else {
            
            configureView()
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                
                self.hero.isEnabled = true
                
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "loginViewController") as! loginViewController
                newViewController.modalPresentationStyle = .fullScreen
                newViewController.hero.modalAnimationType = .push(direction: .up)
                
                self.hero.replaceViewController(with: newViewController)
                
            }
            
        }
        
    }
    
    func initializeVideoPlayerWithVideo() {
        
        welcomeSign.isHidden = true
        
        // Video will obey layout rules
        loadingVideo.clipsToBounds = true
        
        // get the path string for the video from assets
        let videoString:String? = Bundle.main.path(forResource: "loadingVideo", ofType: "mp4")
        guard let unwrappedVideoPath = videoString else {return}
        
        // convert the path string to a url
        let videoUrl = URL(fileURLWithPath: unwrappedVideoPath)
        
        // initialize the video player with the url
        self.player = AVPlayer(url: videoUrl)
        
        // create a video layer for the player
        let layer: AVPlayerLayer = AVPlayerLayer(player: player)
        
        // make the layer the same size as the container view
        layer.frame = loadingVideo!.bounds
        
        // make the video fill the layer as much as possible while keeping its aspect size
        layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        // Added rounded corners
        layer.cornerRadius = 30
        
        // add the layer to the container view
        loadingVideo?.layer.addSublayer(layer)
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem, queue: .main) { [weak self] _ in
            
            self?.presentTheMainViewController()
            
        }
        
    }
    
}
