//
//  ContentView.swift
//  keystone-sdk-ios-demo
//
//  Created by LiYan on 3/28/23.
//

import SwiftUI
import KeystoneSDK

struct MainView: View {
    let solSignRequest = SolSignRequest(
        requestId: "9b1deb4d-3b7d-4bad-9bdd-2b0d7b3dcb6d",
        signData: "01000103c8d842a2f17fd7aab608ce2ea535a6e958dffa20caf669b347b911c4171965530f957620b228bae2b94c82ddd4c093983a67365555b737ec7ddc1117e61c72e0000000000000000000000000000000000000000000000000000000000000000010295cc2f1f39f3604718496ea00676d6a72ec66ad09d926e3ece34f565f18d201020200010c0200000000e1f50500000000",
        path: "m/44'/501'/0'/0'",
        xfp: "707EED6C",
        signType: .transaction,
        origin: "OKX"
    )

    var body: some View {
        NavigationView {
            VStack {
                Text("Keystone SDK demo App")
                    .font(.system(size: 20, weight: .bold))
                    .padding(50)
                VStack(spacing: 20) {
                    NavigationLink(destination: MultiAccountsView()) {
                        Text("Sync Accounts")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color.white)
                            .frame(width: 280, height: 50)
                            .background(Color.cyan)
                            .cornerRadius(12)
                    }
                    NavigationLink(destination: SignTransaction(solSignRequest: solSignRequest)) {
                        Text("Sign Transaction")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color.white)
                            .frame(width: 280, height: 50)
                            .background(Color.cyan)
                            .cornerRadius(12)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
