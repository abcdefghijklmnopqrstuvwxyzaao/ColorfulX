//
//  MetalLink.swift
//
//
//  Created by QAQ on 2023/12/4.
//

import Foundation
import MetalKit

class MetalLink: DisplayLinkDelegate {
    let metalDevice: MTLDevice
    let metalLayer: CAMetalLayer
    let commandQueue: MTLCommandQueue
    let displayLink: DisplayLink = .init()

    typealias SynchornizationUpdate = () -> Void
    var onSynchronizationUpdate: SynchornizationUpdate?

    var scaleFactor: Double = 1.0

    enum MetalError: Error {
        case missingQualifiedHardware
    }

    init() throws {
        guard let metalDevice = MTLCreateSystemDefaultDevice(),
              let commandQueue = metalDevice.makeCommandQueue()
        else {
            throw MetalError.missingQualifiedHardware
        }
        self.metalDevice = metalDevice
        self.commandQueue = commandQueue

        let metalLayer = CAMetalLayer()
        metalLayer.device = metalDevice
        metalLayer.framebufferOnly = false
        metalLayer.isOpaque = false
        self.metalLayer = metalLayer

        displayLink.delegatingObject(self)
    }

    deinit {
        metalLayer.removeFromSuperlayer()
    }

    func updateDrawableSize(withBounds bounds: CGRect) {
        guard metalLayer.frame != bounds else { return }

        metalLayer.frame = bounds
        var width = bounds.width * scaleFactor
        var height = bounds.height * scaleFactor
        if width <= 0 { width = 1 }
        if height <= 0 { height = 1 }
        if width > 8192 { width = 8192 }
        if height > 8192 { height = 8192 }
        metalLayer.drawableSize = CGSize(width: width, height: height)
    }

    func synchronization() { onSynchronizationUpdate?() }
}