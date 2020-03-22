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
    
    @IBInspectable private var videoName: String?
    @IBInspectable private var videoType: String?
    @IBInspectable private var videoNameDarkMode: String?
    @IBInspectable private var videoTypeDarkMode: String?

    private var videoScaling: AVLayerVideoGravity?
    private var videoScalingDarkMode: AVLayerVideoGravity?
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
        guard videoIsSet else {
            throw VideoPropertiesNotSetError.runtimeError("Video name or video type not set")
        }
        guard darkModeVideoIsValid else {
            throw VideoPropertiesNotSetError.runtimeError("Dark mode video name or video type not set")
        }
        guard !darkModeVideoWithoutDefaultVideo else {
            throw VideoPropertiesNotSetError.runtimeError("A dark mode video can not be set without a default video also set")
        }
        if player == nil  {
            self.backgroundColor = UIColor.clear
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                guard let self = self, let path = Bundle.main.path(forResource: self.videoForUserInterfaceStyle.fileName, ofType: self.videoForUserInterfaceStyle.fileExtension) else {
                        debugPrint("video file not found")
                        return
                }
                let playerItem = AVPlayerItem(url: URL(fileURLWithPath: path))
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.player = AVPlayer(playerItem: playerItem)
                    self.player?.isMuted = true
                    self.playerLayer.player = self.player
                    self.playerLayer.videoGravity = self.videoForUserInterfaceStyle.gravity
                    self.player!.play()
                    NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player!.currentItem, queue: .main) { [weak self] _ in
                        guard let player = self?.player else { return }
                        player.seek(to: CMTime.zero)
                        player.play()
                    }
                    NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { [weak self] _ in
                        guard let player = self?.player else { return }
                        player.seek(to: CMTime.zero)
                        player.play()
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

extension SDLoopingVideoView {
    
    private var videoIsSet: Bool {
        videoName != nil && videoType != nil
    }
    
    private var darkModeVideoIsSet: Bool {
        videoNameDarkMode != nil && videoTypeDarkMode != nil
    }
    
    private var darkModeVideoIsValid: Bool {
        darkModeVideoIsSet || !darkModeVideoIsSet
    }
    
    private var darkModeVideoWithoutDefaultVideo: Bool {
        return darkModeVideoIsSet && !videoIsSet
    }
    
    private var videoForUserInterfaceStyle: SDVideo {
        if let dmv = videoTypeDarkMode, let dmvt = videoTypeDarkMode, let dmvs = videoScalingDarkMode, traitCollection.userInterfaceStyle == .dark {
            return .video(fileName: dmv, fileextension: SDVideoExtension(from: dmvt), scaling: dmvs)
        }
        return .video(fileName: videoName ?? "", fileextension: SDVideoExtension(from: videoType ?? ""), scaling: videoScaling ?? .resizeAspectFill)
    }
    
}
