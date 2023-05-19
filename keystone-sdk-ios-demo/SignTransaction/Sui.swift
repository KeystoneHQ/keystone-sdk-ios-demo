//
//  Sui.swift
//  keystone-sdk-ios-demo
//
//  Created by Renfeng Shi on 2023/5/18.
//

import SwiftUI
import KeystoneSDK
import URKit

struct Sui: View {
    private var encoder: UREncoder;
    private let parseFn = KeystoneSDK().sui.parseSignature
    @State var result = "";

    private func onScanSucceed(result: SuiSignature){
        self.result = "Scan result: \(result)"
    }

    private func onScanFailed(error: String){
        self.result = "Scan failed: \(error)"
    }

    init(suiSignRequest: SuiSignRequest){
        let keystoneSDK = KeystoneSDK().sui;
        let qrCode = try! keystoneSDK.generateSignRequest(suiSignRequest: suiSignRequest);
        self.encoder = qrCode;
    }

    var body: some View {
        VStack {
            Text("Sign Sui Transaction")
            AnimatedQRCode(urEncoder: self.encoder)
            AnimatedScanner<SuiSignature>(
                parseFn: parseFn,
                onSucceed: onScanSucceed,
                onError: onScanFailed
            )
            Text(result)
        }
    }
}

struct Sui_Previews: PreviewProvider {
    static var previews: some View {
        Sui(suiSignRequest: MockData.suiSignRequest)
    }
}
