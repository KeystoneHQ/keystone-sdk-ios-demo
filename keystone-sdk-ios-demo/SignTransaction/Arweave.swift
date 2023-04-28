//
//  Arweave.swift
//  keystone-sdk-ios-demo
//
//  Created by LiYan on 4/27/23.
//

import SwiftUI
import KeystoneSDK
import URKit


struct Arweave: View {
    private var encoder: UREncoder;
    private let parseFn = KeystoneSDK().arweave.parseSignature
    @State var result = "";

    private func onScanSucceed(result: Signature){
        self.result = "Scan result: \(result)"
    }
    
    private func onScanFailed(error: String){
        self.result = "Scan failed: \(error)"
    }
    
    init(arweaveSignRequest: ArweaveSignRequest){
        let keystoneSDK = KeystoneSDK().arweave;
        let qrCode = try! keystoneSDK.generateSignRequest(arweaveSignRequest: arweaveSignRequest);
        self.encoder = qrCode;
    }

    var body: some View {
        VStack {
            Text("Sign Arweave Transaction")
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

struct Arweave_Previews: PreviewProvider {
    static var previews: some View {
        Arweave(arweaveSignRequest: MockData.arweaveSignRequest)
    }
}
