//
//  Cardano.swift
//  keystone-sdk-ios-demo
//
//  Created by LiYan on 5/22/23.
//

import SwiftUI
import KeystoneSDK
import URKit

struct Cardano: View {
    private var encoder: UREncoder;
    private let parseFn = KeystoneSDK().cardano.parseSignature
    @State var result = "";

    private func onScanSucceed(result: CardanoSignature){
        self.result = "Scan result: \(result)"
    }

    private func onScanFailed(error: String){
        self.result = "Scan failed: \(error)"
    }

    init(cardanoSignRequest: CardanoSignRequest){
        let keystoneSDK = KeystoneSDK().cardano;
        let qrCode = try! keystoneSDK.generateSignRequest(cardanoSignRequest: cardanoSignRequest);
        self.encoder = qrCode;
    }

    var body: some View {
        VStack {
            Text("Sign Cardano Transaction")
            AnimatedQRCode(urEncoder: self.encoder)
            AnimatedScanner<CardanoSignature>(
                parseFn: parseFn,
                onSucceed: onScanSucceed,
                onError: onScanFailed
            )
            Text(result)
        }
    }
}

struct Cardano_Previews: PreviewProvider {
    static var previews: some View {
        Cardano(cardanoSignRequest: MockData.cardanoSignRequest)
    }
}
