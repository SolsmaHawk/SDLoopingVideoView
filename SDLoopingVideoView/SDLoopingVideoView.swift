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

@available(iOS 13.0, *)
public class SDLoopingVideoView: UIView {
    
    enum VideoPropertiesNotSetError: Error {
        case runtimeError(String)
    }
    
    // MARK: Private Variables
    
    @IBInspectable private var videoName: String?
    @IBInspectable private var videoType: String?
    @IBInspectable private var videoNameDarkMode: String?
    @IBInspectable private var videoTypeDarkMode: String?

    private var videoScaling: AVLayerVideoGravity?
    private var videoScalingDarkMode: AVLayerVideoGravity?
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer { get { return (self.layer as! AVPlayerLayer) } }
    
    override public class var layerClass: AnyClass { return AVPlayerLayer.self }
    
    // MARK: Construction
    
    /**
     Initializes a new SDLoopingVideoView.
     
     - Parameters:
     - frame: The frame of the view
     - video: The default video to play on loop
     - darkModeVideo: An optional video to play when dark mode is active
     
     - Returns: An SDLoopingVideoView
     */
    
    public init(frame: CGRect, video: SDVideo, darkModeVideo: SDVideo? = nil) {
        self.videoName = video.fileName
        self.videoNameDarkMode = darkModeVideo?.fileName
        self.videoType = video.fileNameWithExtension
        self.videoTypeDarkMode = darkModeVideo?.fileExtension
        self.videoScaling = video.gravity
        self.videoScalingDarkMode = darkModeVideo?.gravity
        super.init(frame:frame)
        attemptVideoSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: Setup
    
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
            let video = videoForUserInterfaceStyle
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                guard let self = self, let path = Bundle.main.path(forResource: video.fileName, ofType: video.fileExtension) else {
                        debugPrint("video file not found")
                        return
                }
                let playerItem = AVPlayerItem(url: URL(fileURLWithPath: path))
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.player = AVPlayer(playerItem: playerItem)
                    self.player?.isMuted = true
                    self.playerLayer.player = self.player
                    self.playerLayer.videoGravity = video.gravity
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
    
    // MARK: UIView
    
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if previousTraitCollection?.userInterfaceStyle != traitCollection.userInterfaceStyle {
            player = nil
            attemptVideoSetup()
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        attemptVideoSetup()
    }
    
}

@available(iOS 13.0, *)
extension SDLoopingVideoView {
    
    // MARK: Computed Variables
    
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
        if let dmv = videoNameDarkMode, let dmvt = videoTypeDarkMode, traitCollection.userInterfaceStyle == .dark {
            return .video(fileName: dmv, fileExtension: SDVideoExtension(from: dmvt), scaling: videoScalingDarkMode ?? .resizeAspectFill)
        }
        return .video(fileName: videoName ?? "", fileExtension: SDVideoExtension(from: videoType ?? ""), scaling: videoScaling ?? .resizeAspectFill)
    }
    
}
