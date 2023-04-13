//
//  AnimatedQRCode.swift
//  keystone-sdk-ios-demo
//
//  Created by LiYan on 4/13/23.
//

import SwiftUI
import KeystoneSDK
import URKit
import UIKit


struct AnimatedQRCode: View {
    @StateObject private var viewModel: ViewModel
    private var timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    
    init(urEncoder: UREncoder){
        self._viewModel = StateObject(wrappedValue: ViewModel(urEncoder: urEncoder))
    }

    var body: some View {
        Image(uiImage: UIImage(data: viewModel.content) ?? UIImage())
            .resizable()
            .frame(width: 250, height: 250)
            .padding()
            .onReceive(timer) { _ in
                if viewModel.errorMessage.isEmpty {
                    viewModel.nextQRCode()
                } else {
                    timer.upstream.connect().cancel()
                }
            }
    }
}

struct AnimatedQRCode_Previews: PreviewProvider {
    static var previews: some View {
        let keystoneSDK = KeystoneSDK()
        KeystoneSDK.maxFragmentLen = 200 // default 400
        let qrCode: UREncoder = try! keystoneSDK.btc.generatePSBT(psbt: MockData.psbt)
        return AnimatedQRCode(urEncoder: qrCode)
    }
}

extension AnimatedQRCode {
    final class ViewModel: ObservableObject {
        @Published var content: Data = Data()
        @Published var errorMessage: String = ""
        private var encoder: UREncoder;

        init (urEncoder: UREncoder) {
            self.encoder = urEncoder;
            self.content = getNextQRCode();
        }

        func getQRCodeDate(from string: String) -> Data? {
            let data = string.data(using: String.Encoding.ascii)

            if let filter = CIFilter(name: "CIQRCodeGenerator") {
                filter.setValue(data, forKey: "inputMessage")
                let transform = CGAffineTransform(scaleX: 4, y: 4)

                if let output = filter.outputImage?.transformed(by: transform) {
                    return UIImage(ciImage: output).pngData()
                }
            }
            return "".data(using: .utf8)
        }
        
        func getNextQRCode() -> Data{
            let qrCode = encoder.nextPart()
            return getQRCodeDate(from: qrCode) ?? Data();
        }
        
        public func nextQRCode(){
            if(encoder.isSinglePart){
                return;
            }
            self.content = getNextQRCode();
        }
    }
}
