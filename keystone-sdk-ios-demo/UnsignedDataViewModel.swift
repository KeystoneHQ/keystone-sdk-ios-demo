//
//  UnsignedDataViewModel.swift
//  keystone-sdk-ios-demo
//
//  Created by LiYan on 4/3/23.
//

import Foundation
import URKit
import UIKit


class UnsignedDataViewModel: ObservableObject {
    private var qrEncoder: UREncoder?
    @Published var content: Data = Data()

    init (qrCode: UREncoder) {
        if qrCode.isSinglePart {
            let qrContent = qrCode.nextPart()
            content = getQRCodeDate(from: qrContent) ?? Data()
        } else {
            qrEncoder = qrCode
        }
    }

    func getQRCodeDate(from string: String) -> Data? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 4, y: 4)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output).pngData()
            }
        }
        return "".data(using: .utf8)
    }

    public func updateQRCode(){
        if qrEncoder != nil {
            if !qrEncoder!.isSinglePart {
                let qrCode = qrEncoder!.nextPart()
                content = getQRCodeDate(from: qrCode) ?? Data()
            }
        }
    }
}
