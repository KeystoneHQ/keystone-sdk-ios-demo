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
    
    let psbt = "70736274ff01007102000000011f907e04bf09d19c9aa9a6a3146f8ffb1fc9e23b581cb40a36f28c0128554d930100000000ffffffff02e80300000000000016001491428416b0f516840b67e56b58c17f2938b843863bc004000000000016001442e7376b213643a36241071463132c77d94b223e000000000001011f45c9040000000000160014192864cd17c8bbc87b24bf812d7eb55a1b05797f22060292dc856a817be4507fd231dcdb3eecfc87ed363b144f28ab332b2c0adce03bb718f23f9fd22c00008000000080000000800000000000000000220603945b57ad4bae8836cca9a54dde4c759f5b4ceb0e55478031294dcefe363eabae18707eed6c540000800000008000000080010000001e0000000000220202af541bcb89e5384ad417cb2f25c7dab06ff47ad18f7e30ea3dae2b769bec77e418707eed6c540000800000008000000080010000001f00000000"

    let ethSignRequest = EthSignRequest(
        requestId: "6c3633c0-02c0-4313-9cd7-e25f4f296729",
        signData: "48656c6c6f2c204b657973746f6e652e",
        dataType: .personalMessage,
        chainId: 1,
        path: "m/44'/60'/0'/0/0",
        xfp: "12345678",
        origin: "Metamask"
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
                    NavigationLink(destination: SignBitcoinTxView(psbt: psbt.hexadecimal!)) {
                        Text("Sign PSBT")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color.white)
                            .frame(width: 280, height: 50)
                            .background(Color.cyan)
                            .cornerRadius(12)
                    }
                    NavigationLink(destination: SignEthView(ethSignRequest: ethSignRequest)) {
                        Text("Sign ETH Message")
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
