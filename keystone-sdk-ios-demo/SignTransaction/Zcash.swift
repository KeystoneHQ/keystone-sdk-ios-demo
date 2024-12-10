//
//  Bitcoin.swift
//  keystone-sdk-ios-demo
//
//  Created by LiYan on 4/13/23.
//

import SwiftUI
import KeystoneSDK
import URKit

struct Zcash: View {
    private var encoder: UREncoder;
    private let parseFn = KeystoneZcashSDK().parseZcashPczt;
    @State var result = "";

    private func onScanSucceed(result: Data){
        self.result = "Scan result: \(result)"
    }
    
    private func onScanFailed(error: String){
        self.result = "Scan failed: \(error)"
    }
    
    init(pczt: Data){
        let keystoneSDK = KeystoneZcashSDK();
        let qrCode = try! keystoneSDK.generateZcashPczt(pczt_hex: pczt);
        self.encoder = qrCode;
    }

    var body: some View {
        VStack {
            Text("Sign Zcash Transaction")
            AnimatedQRCode(urEncoder: self.encoder)
            AnimatedScanner<Data>(
                parseFn: parseFn,
                onSucceed: onScanSucceed,
                onError: onScanFailed
            )
            Text(result)
        }
    }
}

struct Zcash_Previews: PreviewProvider {
    static var previews: some View {
        Zcash(pczt: MockData.pczt)
    }
}
