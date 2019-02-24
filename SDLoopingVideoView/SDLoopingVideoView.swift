//
//  SDLoopingVideoView.swift
//  SDSwiftVideoBackground
//
//  Created by John Solsma on 2/19/19.
//  Copyright © 2019 John Solsma. All rights reserved.
//

import UIKit
import AVKit

/// A looping video-view based off of AVPlayerLayer. Automatically scales video to aspect-fill, but can be manually set otherwise. Responds to UIView animations and scales accordingly.
public class SDLoopingVideoView: UIView {
    
    enum VideoPropertiesNotSetError: Error {
        case runtimeError(String)
    }
    
    @IBInspectable private var videoName: String?
    @IBInspectable private var videoType: String?
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer { get { return (self.layer as! AVPlayerLayer) } }
    public var scaling: AVLayerVideoGravity?
    override public class var layerClass: AnyClass { return AVPlayerLayer.self }
    
    
    /**
     Initializes a new SDLoopingVideoView.
     
     - Parameters:
     - frame: The frame of the view
     - videoName: The name of the video file to play and loop
     - videoType: The file extension of the video file
     
     - Returns: An SDLoopingVideoView
     */
    init(frame: CGRect, videoName: String, videoType: String) {
        self.videoName = videoName
        self.videoType = videoType
        super.init(frame:frame)
        attemptVideoSetup()
    }
    
    private func setupVideoView() throws {
        guard videoName != nil && videoType != nil else {
            throw VideoPropertiesNotSetError.runtimeError("Video name or video type not set")
        }
        if player == nil  {
            self.backgroundColor = UIColor.clear
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                guard let path = Bundle.main.path(forResource: self?.videoName!, ofType:self?.videoType!) else { debugPrint("video file not found")
                    return }
                self?.player = AVPlayer(url: URL(fileURLWithPath: path))
                self?.player?.isMuted = true
                DispatchQueue.main.async {
                    self?.playerLayer.player = self?.player
                    self?.playerLayer.videoGravity = self?.scaling ?? AVLayerVideoGravity.resizeAspectFill
                    self?.player!.play()
                    NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self?.player!.currentItem, queue: .main) { [weak self] _ in
                        self?.player?.seek(to: CMTime.zero)
                        self?.player?.play()
                    }
                    NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { [weak self] _ in
                        self?.player?.seek(to: CMTime.zero)
                        self?.player?.play()
                    }
                }
            }
        }
    }
    
    private func attemptVideoSetup() {
        do {
            try setupVideoView()
        } catch VideoPropertiesNotSetError.runtimeError(let errorMessage) {
            print(errorMessage)
        } catch{
            print("Unknown error")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        attemptVideoSetup()
    }
}
