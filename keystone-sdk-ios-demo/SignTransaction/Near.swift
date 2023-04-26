//
//  Near.swift
//  keystone-sdk-ios-demo
//
//  Created by Renfeng Shi on 2023/4/26.
//

import SwiftUI
import KeystoneSDK
import URKit

struct Near: View {
    private var encoder: UREncoder;
    private let parseFn = KeystoneSDK().near.parseSignature;
    @State var result = "";

    private func onScanSucceed(result: NearSignature){
        self.result = "Scan result: \(result)"
    }
    
    private func onScanFailed(error: String){
        self.result = "Scan failed: \(error)"
    }
    
    init(nearSignRequest: NearSignRequest){
        let keystoneSDK = KeystoneSDK().near;
        let qrCode = try! keystoneSDK.generateSignRequest(nearSignRequest: nearSignRequest);
        self.encoder = qrCode;
    }

    var body: some View {
        VStack {
            Text("Sign Near Transaction")
            AnimatedQRCode(urEncoder: self.encoder)
            AnimatedScanner<NearSignature>(
                parseFn: parseFn,
                onSucceed: onScanSucceed,
                onError: onScanFailed
            )
            Text(result)
        }
    }
}

struct Near_Previews: PreviewProvider {
    static var previews: some View {
        Near(nearSignRequest: MockData.nearSignRequest)
    }
}
