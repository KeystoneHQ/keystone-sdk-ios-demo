//
//  Aptos.swift
//  keystone-sdk-ios-demo
//
//  Created by LiYan on 4/17/23.
//

import SwiftUI
import KeystoneSDK
import URKit

struct Aptos: View {
    private var encoder: UREncoder;
    private let parseFn = KeystoneSDK().aptos.parseSignature
    @State var result = "";

    private func onScanSucceed(result: AptosSignature){
        self.result = "Scan result: \(result)"
    }

    private func onScanFailed(error: String){
        self.result = "Scan failed: \(error)"
    }

    init(aptosSignRequest: AptosSignRequest){
        let keystoneSDK = KeystoneSDK().aptos;
        let qrCode = try! keystoneSDK.generateSignRequest(aptosSignRequest: aptosSignRequest);
        self.encoder = qrCode;
    }

    var body: some View {
        VStack {
            Text("Sign Aptos Transaction")
            AnimatedQRCode(urEncoder: self.encoder)
            AnimatedScanner<AptosSignature>(
                parseFn: parseFn,
                onSucceed: onScanSucceed,
                onError: onScanFailed
            )
            Text(result)
        }
    }
}

struct Aptos_Previews: PreviewProvider {
    static var previews: some View {
        Aptos(aptosSignRequest: MockData.aptosSignRequest)
    }
}
