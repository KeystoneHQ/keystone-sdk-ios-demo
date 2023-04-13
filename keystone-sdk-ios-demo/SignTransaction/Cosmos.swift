//
//  Cosmos.swift
//  keystone-sdk-ios-demo
//
//  Created by LiYan on 4/13/23.
//

import SwiftUI
import KeystoneSDK
import URKit

struct Cosmos: View {
    private var encoder: UREncoder;
    private let parseFn = KeystoneSDK().cosmos.parseSignature
    @State var result = "";

    private func onScanSucceed(result: CosmosSignature){
        self.result = "Scan result: \(result)"
    }
    
    private func onScanFailed(error: String){
        self.result = "Scan failed: \(error)"
    }
    
    init(cosmosSignRequest: CosmosSignRequest){
        let keystoneSDK = KeystoneSDK().cosmos;
        let qrCode = try! keystoneSDK.generateSignRequest(cosmosSignRequest: cosmosSignRequest);
        self.encoder = qrCode;
    }

    var body: some View {
        VStack {
            Text("Sign Cosmos Transaction")
            AnimatedQRCode(urEncoder: self.encoder)
            AnimatedScanner<CosmosSignature>(
                parseFn: parseFn,
                onSucceed: onScanSucceed,
                onError: onScanFailed
            )
            Text(result)
        }
    }
}

struct Cosmos_Previews: PreviewProvider {
    static var previews: some View {
        Cosmos(cosmosSignRequest: MockData.cosmosSignRequest)
    }
}
