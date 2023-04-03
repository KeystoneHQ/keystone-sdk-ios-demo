//
//  SignETHView.swift
//  keystone-sdk-ios-demo
//
//  Created by LiYan on 4/3/23.
//

import SwiftUI
import KeystoneSDK

struct SignEthView: View {
    @StateObject private var viewModel: UnsignedDataViewModel
    private var timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    
    init(ethSignRequest: EthSignRequest){
        let keystoneSDK = KeystoneSDK()
        let qrCode = try! keystoneSDK.eth.generateSignRequest(ethSignRequest: ethSignRequest)
        self._viewModel = StateObject(wrappedValue: UnsignedDataViewModel(qrCode: qrCode))
    }

    var body: some View {
        Text("hello")
        VStack {
            Image(uiImage: UIImage(data: viewModel.content) ?? UIImage())
                .resizable()
                .frame(width: 200, height: 200)
                .padding()
        }.onReceive(timer) { _ in
            viewModel.updateQRCode()
        }
    }
}

struct SignETHView_Previews: PreviewProvider {
    static var previews: some View {
        let ethSignRequest = EthSignRequest(
            requestId: "6c3633c0-02c0-4313-9cd7-e25f4f296729",
            signData: "48656c6c6f2c204b657973746f6e652e",
            dataType: .personalMessage,
            chainId: 1,
            path: "m/44'/60'/0'/0/0",
            xfp: "F23F9FD2",
            origin: "MetaMask"
        )
        SignEthView(ethSignRequest: ethSignRequest)
    }
}
