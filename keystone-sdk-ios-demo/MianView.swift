//
//  ContentView.swift
//  keystone-sdk-ios-demo
//
//  Created by LiYan on 3/28/23.
//

import SwiftUI
import KeystoneSDK

struct ChainView: Identifiable {
    let id = UUID()
    let name: String
    let view: AnyView
}

struct MainView: View {
    
    let chains: [ChainView] = [
        ChainView(name: "Connect Wallet (MultiAccounts)", view: AnyView(MultiAccountsView())),
        ChainView(name: "Connect Wallet (ArweaveAccount)", view: AnyView(ArweaveAccountView())),
        ChainView(name: "Bitcoin", view: AnyView(Bitcoin(psbt: MockData.psbt))),
        ChainView(name: "Ethereum", view: AnyView(Ethereum(ethSignRequest: MockData.ethSignRequest))),
        ChainView(name: "Solana", view: AnyView(Solana(solSignRequest: MockData.solSignRequest))),
        ChainView(name: "Cosmos", view: AnyView(Cosmos(cosmosSignRequest: MockData.cosmosSignRequest))),
        ChainView(name: "Tron", view: AnyView(Tron(tronSignRequest: MockData.tronSignRequest))),
        ChainView(name: "Aptos", view: AnyView(Aptos(aptosSignRequest: MockData.aptosSignRequest))),
        ChainView(name: "Litecoin", view: AnyView(Litecoin(ltcSignRequest: MockData.ltcSignRequest))),
        ChainView(name: "DigitalCash", view: AnyView(Dash(dashSignRequest: MockData.dashSignRequest))),
        ChainView(name: "BitcoinCash", view: AnyView(Bch(bchSignRequest: MockData.bchSignRequest))),
        ChainView(name: "Near", view: AnyView(Near(nearSignRequest: MockData.nearSignRequest))),
        ChainView(name: "Arweave", view: AnyView(Arweave(arweaveSignRequest: MockData.arweaveSignRequest))),
        ChainView(name: "Sui", view: AnyView(Sui(suiSignRequest: MockData.suiSignRequest))),
        ChainView(name: "Cardano", view: AnyView(Cardano(cardanoSignRequest: MockData.cardanoSignRequest))),
    ]

    var body: some View {
        NavigationView {
            VStack {
                NavigationView {
                    List(chains) { chain in
                        NavigationLink(
                            destination: chain.view,
                            label: {
                                Text(chain.name)
                                    .padding(.vertical, 10)
                            }
                        )
                    }
                }.navigationTitle("Keystone SDK Demo")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
