//
//  SignCosmosView.swift
//  keystone-sdk-ios-demo
//
//  Created by Renfeng Shi on 2023/4/6.
//

import SwiftUI
import KeystoneSDK
import CodeScanner

struct SignCosmosView: View {
    @State private var isPresentingScanner = false
    @StateObject private var viewModel: UnsignedDataViewModel
    private var timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    private var sdk = KeystoneSDK()
    @State private var signature: String?
    @State private var errorMessage:String?;
    
    init(cosmosSignRequest: CosmosSignRequest){
        let keystoneSDK = KeystoneSDK()
        KeystoneSDK.maxFragmentLen = 500
        let qrCode = try! keystoneSDK.cosmos.generateSignRequest(cosmosSignRequest: cosmosSignRequest)
        self._viewModel = StateObject(wrappedValue: UnsignedDataViewModel(qrCode: qrCode))
    }

    var body: some View {
        Text("Cosmos Sign Request")
        VStack {
            Image(uiImage: UIImage(data: viewModel.content) ?? UIImage())
                .resizable()
                .frame(width: 200, height: 200)
                .padding()
            Button {
                isPresentingScanner = true
            } label: {
                Text("Get Signature")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color.white)
                    .frame(width: 280, height: 50)
                    .background(Color.cyan)
                    .cornerRadius(12)
            }
            Text(signature ?? "")
            Text(errorMessage ?? "")
        }.onReceive(timer) { _ in
            viewModel.updateQRCode()
        }
        .sheet(isPresented: $isPresentingScanner) {
            CodeScannerView(codeTypes: [.qr], scanMode: .continuous, scanInterval: 2, shouldVibrateOnSuccess: true)  { response in
                switch response {
                case .success(let result):
                    do {
                        let ur = try sdk.decodeQR(qrCode: result.string)
                        if ur != nil {
                            let sig = try sdk.cosmos.parseSignature(cborHex: ur!.cbor)
                            isPresentingScanner = false
                            signature = String(describing: sig)
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

struct SignCosmosView_Previews: PreviewProvider {
    static var previews: some View {
        let cosmosSignRequest = CosmosSignRequest(
            requestId: "7AFD5E09-9267-43FB-A02E-08C4A09417EC",
            signData: "7B226163636F756E745F6E756D626572223A22323930353536222C22636861696E5F6964223A226F736D6F2D746573742D34222C22666565223A7B22616D6F756E74223A5B7B22616D6F756E74223A2231303032222C2264656E6F6D223A22756F736D6F227D5D2C22676173223A22313030313936227D2C226D656D6F223A22222C226D736773223A5B7B2274797065223A22636F736D6F732D73646B2F4D736753656E64222C2276616C7565223A7B22616D6F756E74223A5B7B22616D6F756E74223A223132303030303030222C2264656E6F6D223A22756F736D6F227D5D2C2266726F6D5F61646472657373223A226F736D6F31667334396A7867797A30306C78363436336534767A767838353667756C64756C6A7A6174366D222C22746F5F61646472657373223A226F736D6F31667334396A7867797A30306C78363436336534767A767838353667756C64756C6A7A6174366D227D7D5D2C2273657175656E6365223A2230227D",
            dataType: .amino,
            accounts: [
                CosmosSignRequest.Account(
                    path: "m/44'/118'/0'/0/0",
                    xfp: "f23f9fd2",
                    address: "4c2a59190413dff36aba8e6ac130c7a691cfb79f"
                )
            ]
        )
        SignCosmosView(cosmosSignRequest: cosmosSignRequest)
    }
}
