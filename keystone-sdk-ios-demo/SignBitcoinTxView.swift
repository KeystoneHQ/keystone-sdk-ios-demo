//
//  SignBitcoinTxView.swift
//  keystone-sdk-ios-demo
//
//  Created by LiYan on 3/31/23.
//

import SwiftUI
import Foundation
import KeystoneSDK
import URKit

struct SignBitcoinTxView: View {
    @State private var qrContent: String
    private var timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    private var qrEncoder: UREncoder?;

    init(psbt: Data) {
        do {
            let keystoneSDK = KeystoneSDK()
            KeystoneSDK.maxFragmentLen = 200 // default 400
            let qrCode = try keystoneSDK.btc.generatePSBT(psbt: psbt)
            qrContent = qrCode.nextPart()
            if qrCode.isSinglePart {
                qrContent = qrCode.nextPart()
            } else {
                // change the QR code content every little piece of time
                qrEncoder = qrCode
            }
        } catch {
            qrContent = String()
            print("Error: \(error)")
        }
    }

    func getQRCodeData(from string: String) -> Data? {
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

    var body: some View {
        Text("Scan the QR Code with your Keystone")
        VStack {
            Image(uiImage: UIImage(data: getQRCodeData(from: qrContent)!) ?? UIImage())
                .resizable()
                .frame(width: 200, height: 200)
                .padding()
        }.onReceive(timer) { _ in
            if qrEncoder != nil {
                qrContent = qrEncoder!.nextPart()
            }
        }
    }
}

extension String {
    /// Create `Data` from hexadecimal string representation
    ///
    /// This creates a `Data` object from hex string. Note, if the string has any spaces or non-hex characters (e.g. starts with '<' and with a '>'), those are ignored and only hex characters are processed.
    ///
    /// - returns: Data represented by this hexadecimal string.
    var hexadecimal: Data? {
        var data = Data(capacity: count / 2)
        
        let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
        regex.enumerateMatches(in: self, range: NSRange(startIndex..., in: self)) { match, _, _ in
            let byteString = (self as NSString).substring(with: match!.range)
            let num = UInt8(byteString, radix: 16)!
            data.append(num)
        }
        guard data.count > 0 else { return nil }
        return data
    }
}

struct SignBitcoinTxView_Previews: PreviewProvider {
    static var previews: some View {
        let psbt = "70736274ff0100710200000001a6e52d0cf7bec16c454dc590966906f2f711d2ffb720bf141b41fd0cd3146a220000000000ffffffff02809698000000000016001473071357788c861241e6e991cc1f7933aa87444440ff100500000000160014d98f4c248e06e54d08bafdc213912aca80c0a34a000000000001011f00e1f50500000000160014f6de6edbdef5f0e62777c14e6e322ecb27c7824b22060341d94247fabfc265035f0a51bcfaca3b65709a7876698769a336b4142faa4bad18f23f9fd254000080000000800000008000000000000000000000220203ab7173024786ba14179c33db3b7bdf630039c24089409637323b560a4b1d025618f23f9fd2540000800000008000000080010000000000000000"
        SignBitcoinTxView(psbt: psbt.hexadecimal!)
    }
}
