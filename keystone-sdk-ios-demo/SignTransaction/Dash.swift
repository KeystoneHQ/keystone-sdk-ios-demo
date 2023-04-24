//
//  Dash.swift
//  keystone-sdk-ios-demo
//
//  Created by LiYan on 4/21/23.
//

import SwiftUI
import KeystoneSDK
import URKit

struct Dash: View {
    private var encoder: UREncoder;
    private let parseFn = KeystoneSDK().dash.parseSignResult;
    @State var result = "";

    private func onScanSucceed(result: TransactionSignResult){
        self.result = "Scan result: \(result)"
    }

    private func onScanFailed(error: String){
        self.result = "Scan failed: \(error)"
    }

    init(dashSignRequest: KeystoneSignRequest<UtxoBaseTransaction>){
        let keystoneSDK = KeystoneSDK().dash;
        let qrCode = try! keystoneSDK.generateSignRequest(keystoneSignRequest: dashSignRequest);
        self.encoder = qrCode;
    }

    var body: some View {
        VStack {
            Text("Sign DigitalCash Transaction")
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

struct Dash_Previews: PreviewProvider {
    static var previews: some View {
        Dash(dashSignRequest: MockData.dashSignRequest)
    }
}
