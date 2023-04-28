//
//  ArweaveAccountView.swift
//  keystone-sdk-ios-demo
//
//  Created by LiYan on 4/28/23.
//

import SwiftUI
import KeystoneSDK
import URKit

struct ArweaveAccountView: View {
    @State var result = "";
    private let parseFn = KeystoneSDK().arweave.parseAccount;
    
    private func onScanSucceed(result: ArweaveAccount){
        self.result = "Scan result: \(result)"
    }
    
    private func onScanFailed(error: String){
        self.result = "Scan failed: \(error)"
    }

    var body: some View {
        VStack {
            Text("Sync MultiAccounts")
            AnimatedScanner<ArweaveAccount>(
                parseFn: parseFn,
                onSucceed: onScanSucceed,
                onError: onScanFailed
            )
            Text(result)
        }
    }
}

struct ArweaveAccountView_Previews: PreviewProvider {
    static var previews: some View {
        ArweaveAccountView()
    }
}
