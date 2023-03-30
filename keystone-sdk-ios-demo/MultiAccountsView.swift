//
//  MultiAccountsView.swift
//  keystone-sdk-ios-demo
//
//  Created by LiYan on 3/28/23.
//

import SwiftUI
import CodeScanner
import KeystoneSDK

struct MultiAccountsView: View {
    @State private var isPresentingScanner = true
    @State private var accounts: String?
    @State private var errorMessage:String?;
    private var sdk = KeystoneSDK()
    
    var body: some View {
        VStack(spacing: 10) {
            Text(accounts ?? "")
            Text(errorMessage ?? "")
        }
        .sheet(isPresented: $isPresentingScanner) {
            CodeScannerView(codeTypes: [.qr], scanMode: .continuous, scanInterval: 2, shouldVibrateOnSuccess: true)  { response in
                switch response {
                case .success(let result):
                    do {
                        let ur = try sdk.decodeQR(qrCode: result.string)
                        if ur != nil {
                            let multiAccounts = try sdk.parseMultiAccounts(cborHex: ur!.cbor)
                            isPresentingScanner = false
                            accounts = String(describing: multiAccounts)
                        }
                    } catch {
                        errorMessage = "Error: \(error)"
                        sdk.resetQRDecoder()
                        isPresentingScanner = false
                    }
                    
                case .failure(let error):
                    errorMessage = "Error: \(error)"
                    sdk.resetQRDecoder()
                    isPresentingScanner = false
                }
            }
        }
    }
}

struct MultiAccountsView_Previews: PreviewProvider {
    static var previews: some View {
        MultiAccountsView()
    }
}
