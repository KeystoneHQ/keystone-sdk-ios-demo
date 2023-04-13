//
//  Ethereum.swift
//  keystone-sdk-ios-demo
//
//  Created by LiYan on 4/13/23.
//

import SwiftUI
import KeystoneSDK
import URKit

struct Ethereum: View {
    private var encoder: UREncoder;
    private let parseFn = KeystoneSDK().eth.parseSignature
    @State var result = "";

    private func onScanSucceed(result: Signature){
        self.result = "Scan result: \(result)"
    }
    
    private func onScanFailed(error: String){
        self.result = "Scan failed: \(error)"
    }
    
    init(ethSignRequest: EthSignRequest){
        let keystoneSDK = KeystoneSDK().eth;
        let qrCode = try! keystoneSDK.generateSignRequest(ethSignRequest: ethSignRequest);
        self.encoder = qrCode;
    }

    var body: some View {
        VStack {
            Text("Sign Ethereum Transaction")
            AnimatedQRCode(urEncoder: self.encoder)
            AnimatedScanner<Signature>(
                parseFn: parseFn,
                onSucceed: onScanSucceed,
                onError: onScanFailed
            )
            Text(result)
        }
    }
}

struct Ethereum_Previews: PreviewProvider {
    static var previews: some View {
        Ethereum(ethSignRequest: MockData.ethSignRequest)
    }
}
