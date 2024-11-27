//
//  ZcashAccountsView.swift
//  keystone-sdk-ios-demo
//
//  Created by Sora Li on 2024/11/26.
//

import SwiftUI
import KeystoneSDK
import URKit

struct ZcashAccountsView: View {
    @State var result = "";
    private let parseFn = KeystoneSDK().parseZcashAccounts;
    
    private func onScanSucceed(result: ZcashAccounts){
        self.result = "Scan result: \(result)"
        print("============= \(result)")
    }
    
    private func onScanFailed(error: String){
        self.result = "Scan failed: \(error)"
    }

    var body: some View {
        VStack {
            Text("Sync ZcashAccounts")
            AnimatedScanner<ZcashAccounts>(
                parseFn: parseFn,
                onSucceed: onScanSucceed,
                onError: onScanFailed
            )
            Text(result)
        }
    }
}

struct ZcashAccounts_Preview: PreviewProvider {
    static var previews: some View {
        ZcashAccountsView()
    }
}
