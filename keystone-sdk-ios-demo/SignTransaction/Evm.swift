//
//  Evm.swift
//  keystone-sdk-ios-demo
//
//  Created by Renfeng Shi on 2023/7/17.
//

import SwiftUI
import KeystoneSDK
import URKit

struct Evm: View {
    private var encoder: UREncoder;
    private let parseFn = KeystoneSDK().evm.parseSignature
    @State var result = "";

    private func onScanSucceed(result: Signature){
        self.result = "Scan result: \(result)"
    }
    
    private func onScanFailed(error: String){
        self.result = "Scan failed: \(error)"
    }
    
    init(evmSignRequest: EvmSignRequest){
        let keystoneSDK = KeystoneSDK().evm;
        let qrCode = try! keystoneSDK.generateSignRequest(evmSignRequest: evmSignRequest);
        self.encoder = qrCode;
    }

    var body: some View {
        VStack {
            Text("Sign Evm Transaction")
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

struct Evm_Previews: PreviewProvider {
    static var previews: some View {
        Evm(evmSignRequest: MockData.evmSignRequest)
    }
}
