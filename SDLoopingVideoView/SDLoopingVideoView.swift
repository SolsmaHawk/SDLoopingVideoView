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
@available(iOS 12.0, *)
public class SDLoopingVideoView: UIView {
    
    enum VideoPropertiesNotSetError: Error {
        case runtimeError(String)
    }
    
    @IBInspectable private var videoName: String
    @IBInspectable private var videoType: String
    @IBInspectable private var videoNameDarkMode: String?
    @IBInspectable private var videoTypeDarkMode: String?
    
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer { get { return (self.layer as! AVPlayerLayer) } }

    override public class var layerClass: AnyClass { return AVPlayerLayer.self }
    
    
    /**
     Initializes a new SDLoopingVideoView.
     
     - Parameters:
     - frame: The frame of the view
     - videoName: The name of the video file to play and loop
     - videoType: The file extension of the video file
     
     - Returns: An SDLoopingVideoView
     */
    public init(frame: CGRect, video: SDVideo, darkModeVideo: SDVideo? = nil) {
        self.videoName = video.fileName
        self.videoNameDarkMode = darkModeVideo?.fileName
        self.videoType = video.fileNameWithExtension
        super.init(frame:frame)
        attemptVideoSetup()
    }
    
    private func setupVideoView() throws {
        guard videoName != nil && video_Night != nil && videoType != nil else {
            throw VideoPropertiesNotSetError.runtimeError("Video name or video type not set")
        }
        if player == nil  {
            self.backgroundColor = UIColor.clear
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                
                DispatchQueue.main.async {
                    var video: String {
                            switch self?.traitCollection.userInterfaceStyle {
                            case .light, .unspecified, .none:
                                return self!.video_Light!
                             case .dark:
                                return self!.video_Night!
                            }
                    }
                    guard let path = Bundle.main.path(forResource: video, ofType:self?.videoType!) else { debugPrint("video file not found")
                        return }
                    self?.player = AVPlayer(url: URL(fileURLWithPath: path))
                    self?.player?.isMuted = true
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
