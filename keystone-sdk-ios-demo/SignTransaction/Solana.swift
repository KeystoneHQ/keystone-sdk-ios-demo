//
//  Solana.swift
//  keystone-sdk-ios-demo
//
//  Created by LiYan on 4/13/23.
//

import SwiftUI
import KeystoneSDK
import URKit

struct Solana: View {
    private var encoder: UREncoder;
    private let parseFn = KeystoneSDK().sol.parseSignature;
    @State var result = "";

    private func onScanSucceed(result: Signature){
        self.result = "Scan result: \(result)"
    }
    
    private func onScanFailed(error: String){
        self.result = "Scan failed: \(error)"
    }
    
    init(solSignRequest: SolSignRequest){
        let keystoneSDK = KeystoneSDK().sol;
        let qrCode = try! keystoneSDK.generateSignRequest(solSignRequest: solSignRequest);
        self.encoder = qrCode;
    }

    var body: some View {
        VStack {
            Text("Sign Solana Transaction")
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

struct Solana_Previews: PreviewProvider {
    static var previews: some View {
        Solana(solSignRequest: MockData.solSignRequest)
    }
}
