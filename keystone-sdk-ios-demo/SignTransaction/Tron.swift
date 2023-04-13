//
//  Tron.swift
//  keystone-sdk-ios-demo
//
//  Created by LiYan on 4/13/23.
//

import SwiftUI
import KeystoneSDK
import URKit

struct Tron: View {
    private var encoder: UREncoder;
    private let parseFn = KeystoneSDK().tron.parseSignature;
    @State var result = "";

    private func onScanSucceed(result: Signature){
        self.result = "Scan result: \(result)"
    }
    
    private func onScanFailed(error: String){
        self.result = "Scan failed: \(error)"
    }
    
    init(tronSignRequest: TronSignRequest){
        let keystoneSDK = KeystoneSDK().tron
        let qrCode = try! keystoneSDK.generateSignRequest(tronSignRequest: tronSignRequest);
        self.encoder = qrCode;
    }

    var body: some View {
        VStack {
            Text("Sign Tron Transaction")
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

struct Tron_Previews: PreviewProvider {
    static var previews: some View {
        Tron(tronSignRequest: MockData.tronSignRequest)
    }
}
