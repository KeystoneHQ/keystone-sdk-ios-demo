//
//  Bch.swift
//  keystone-sdk-ios-demo
//
//  Created by LiYan on 4/21/23.
//

import SwiftUI
import KeystoneSDK
import URKit

struct Bch: View {
    private var encoder: UREncoder;
    private let parseFn = KeystoneSDK().bch.parseSignResult;
    @State var result = "";

    private func onScanSucceed(result: TransactionSignResult){
        self.result = "Scan result: \(result)"
    }

    private func onScanFailed(error: String){
        self.result = "Scan failed: \(error)"
    }

    init(bchSignRequest: KeystoneSignRequest<UtxoBaseTransaction>){
        let keystoneSDK = KeystoneSDK().bch;
        let qrCode = try! keystoneSDK.generateSignRequest(keystoneSignRequest: bchSignRequest);
        self.encoder = qrCode;
    }

    var body: some View {
        VStack {
            Text("Sign Bch Transaction")
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

struct Bch_Previews: PreviewProvider {
    static var previews: some View {
        Bch(bchSignRequest: MockData.bchSignRequest)
    }
}
