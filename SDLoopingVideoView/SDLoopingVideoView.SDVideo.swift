//
//  SDLoopingVideoView.SDVideo.swift
//  SDLoopingVideoViewExample
//
//  Created by John Solsma on 3/21/20.
//  Copyright © 2020 Solsma Dev Inc. All rights reserved.
//

import Foundation
import AVKit

@available(iOS 13.0, *)
extension SDLoopingVideoView {
    
    public enum SDVideo {
        case video(fileName: String, fileExtension: SDVideoExtension, scaling: AVLayerVideoGravity  = .resizeAspectFill)
        
        var fileNameWithExtension: String {
            fileName + "." + fileExtension
        }
        
        var fileName: String {
            switch self {
                case .video(let fileName, _, _):
                    return fileName
            }
        }
        
        var fileExtension: String {
            switch self {
                case .video(_, let fileExtension, _):
                    return fileExtension.stringRepresentation
            }
        }
        
        var gravity: AVLayerVideoGravity {
            switch self {
                case .video(_, _, let scaling):
                    return scaling
            }
        }

    }
    
}
