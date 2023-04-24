//
//  Litecoin.swift
//  keystone-sdk-ios-demo
//
//  Created by LiYan on 4/21/23.
//

import SwiftUI
import KeystoneSDK
import URKit


struct Litecoin: View {
    private var encoder: UREncoder;
    private let parseFn = KeystoneSDK().ltc.parseSignResult;
    @State var result = "";

    private func onScanSucceed(result: TransactionSignResult){
        self.result = "Scan result: \(result)"
    }

    private func onScanFailed(error: String){
        self.result = "Scan failed: \(error)"
    }

    init(ltcSignRequest: KeystoneSignRequest<LitecoinTransaction>){
        let keystoneSDK = KeystoneSDK().ltc;
        let qrCode = try! keystoneSDK.generateSignRequest(keystoneSignRequest: ltcSignRequest);
        self.encoder = qrCode;
    }

    var body: some View {
        VStack {
            Text("Sign Litcoin Transaction")
            AnimatedQRCode(urEncoder: self.encoder)
            AnimatedScanner<TransactionSignResult>(
                parseFn: parseFn,
                onSucceed: onScanSucceed,
                onError: onScanFailed
            )
            Text(result)
        }
    }
}

struct Litecoin_Previews: PreviewProvider {
    static var previews: some View {
        Litecoin(ltcSignRequest: MockData.ltcSignRequest)
    }
}
