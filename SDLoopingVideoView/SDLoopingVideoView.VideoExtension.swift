//
//  SDLoopingVideoView.VideoType.swift
//  SDLoopingVideoViewExample
//
//  Created by ZuluAlpha on 3/21/20.
//  Copyright © 2020 Solsma Dev Inc. All rights reserved.
//

import Foundation

extension SDLoopingVideoView {
    
    public enum SDVideoExtension {
        case mpg
        case wmv
        case avi
        case mkv
        case rmvb
        case rm
        case mp4
        case custom(fileExtension: String)
    }
    
}

extension SDLoopingVideoView.SDVideoExtension {
    
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
        }
    }
    
}
