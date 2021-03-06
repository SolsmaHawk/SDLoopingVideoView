//
//  SDLoopingVideoView.VideoType.swift
//  SDLoopingVideoViewExample
//
//  Created by John Solsma on 3/21/20.
//  Copyright © 2020 Solsma Dev Inc. All rights reserved.
//

import Foundation

@available(iOS 13.0, *)
extension SDLoopingVideoView {
    
    public enum SDVideoExtension {
        case mpg
        case wmv
        case avi
        case mkv
        case rmvb
        case rm
        case mp4
        case mov
        case custom(fileExtension: String)
    }
    
}

@available(iOS 13.0, *)
extension SDLoopingVideoView.SDVideoExtension {
    
    init(from string: String) {
        switch string {
        case "mpg":
            self = .mkv
        case "wmv":
            self = .wmv
        case "avi":
            self = .avi
        case "mkv":
            self = .mkv
        case "rmvb":
            self = .rmvb
        case "rm":
            self = .rm
        case "mp4":
            self = .mp4
        case "mov":
            self = .mov
        default:
            self = .custom(fileExtension: string)
        }
    }
    
    var stringRepresentation: String {
        switch self {
        case .custom(let fileExtension):
            return fileExtension
        case .mpg:
            return "mpg"
        case .wmv:
            return "wmv"
        case .avi:
            return "avi"
        case .mkv:
            return "mkv"
        case .rmvb:
            return "rmvb"
        case .rm:
            return "rm"
        case .mp4:
            return "mp4"
        case .mov:
            return "mov"
        }
    }
    
}
