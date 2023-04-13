//
//  Bitcoin.swift
//  keystone-sdk-ios-demo
//
//  Created by LiYan on 4/13/23.
//

import SwiftUI
import KeystoneSDK
import URKit

struct Bitcoin: View {
    private var encoder: UREncoder;
    private let parseFn = KeystoneSDK().btc.parsePSBT;
    @State var result = "";

    private func onScanSucceed(result: Data){
        self.result = "Scan result: \(result)"
    }
    
    private func onScanFailed(error: String){
        self.result = "Scan failed: \(error)"
    }
    
    init(psbt: Data){
        let keystoneSDK = KeystoneSDK().btc;
        let qrCode = try! keystoneSDK.generatePSBT(psbt: psbt);
        self.encoder = qrCode;
    }

    var body: some View {
        VStack {
            Text("Sign Bitcoin Transaction")
            AnimatedQRCode(urEncoder: self.encoder)
            AnimatedScanner<Data>(
                parseFn: parseFn,
                onSucceed: onScanSucceed,
                onError: onScanFailed
            )
            Text(result)
        }
    }
}

struct Bitcoin_Previews: PreviewProvider {
    static var previews: some View {
        Bitcoin(psbt: MockData.psbt)
    }
}
