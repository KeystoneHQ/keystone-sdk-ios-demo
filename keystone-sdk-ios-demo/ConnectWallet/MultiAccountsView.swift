//
//  MultiAccounts.swift
//  keystone-sdk-ios-demo
//
//  Created by LiYan on 4/13/23.
//

import SwiftUI
import KeystoneSDK
import URKit

struct MultiAccountsView: View {
    @State var result = "";
    private let parseFn = KeystoneSDK().parseMultiAccounts;
    
    private func onScanSucceed(result: MultiAccounts){
        self.result = "Scan result: \(result)"
        print("============= \(result)")
    }
    
    private func onScanFailed(error: String){
        self.result = "Scan failed: \(error)"
    }

    var body: some View {
        VStack {
            Text("Sync MultiAccounts")
            AnimatedScanner<MultiAccounts>(
                parseFn: parseFn,
                onSucceed: onScanSucceed,
                onError: onScanFailed
            )
            Text(result)
        }
    }
}

struct MultiAccounts_Previews: PreviewProvider {
    static var previews: some View {
        MultiAccountsView()
    }
}
