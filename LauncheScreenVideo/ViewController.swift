//
//  ViewController.swift
//  LauncheScreenVideo
//
//  Created by Vadim Koppe on 21.11.16.
//  Copyright © 2016 Vadim Koppe. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player: AVPlayer!
    @IBOutlet var playerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createVideoPlayer()
    }
    
    func createVideoPlayer() {
        let path = Bundle.main.path(forResource: "video", ofType: "mp4")
        let url = NSURL.fileURL(withPath: path!)
        let item = AVPlayerItem.init(url: url)
        
        self.player = AVPlayer(playerItem: item)
        self.player.volume = 100;
        
        let playerLayer = AVPlayerLayer(player: self.player)
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayer.frame = self.playerView.layer.bounds
        
        self.playerView.layer.addSublayer(playerLayer)
        
        self.player.play()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(ViewController.moviePlayDidEnd),
            name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
            object: self.player.currentItem)
    }
    
    func moviePlayDidEnd(notification: NSNotification) {
        let item = notification.object as! AVPlayerItem
        item.seek(to: kCMTimeZero)
        self.player.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
