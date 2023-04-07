//
//  SignTransaction.swift
//  keystone-sdk-ios-demo
//
//  Created by LiYan on 3/28/23.
//

import SwiftUI
import KeystoneSDK
import URKit
import CodeScanner


struct SignTransaction: View {
    @State private var qrContent = Data()
    @State private var isPresentingScanner = false;
    @State private var signature:String?;
    @State private var errorMessage:String?;
    @StateObject private var viewModel: ViewModel
    private var keystoneSDK = KeystoneSDK()
    
    private var timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    
    init(solSignRequest: SolSignRequest) {
        self._viewModel = StateObject(wrappedValue: ViewModel(solSignRequest: solSignRequest))
    }

    var body: some View {
        Text("Scan the QR Code with your Keystone")
        VStack {
            Image(uiImage: UIImage(data: qrContent) ?? UIImage())
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
            if viewModel.errorMessage.isEmpty {
                qrContent = viewModel.nextQRCode() ?? Data()
            } else {
                errorMessage = "Error: \(viewModel.errorMessage)"
                timer.upstream.connect().cancel()
            }
        }.sheet(isPresented: $isPresentingScanner) {
            CodeScannerView(codeTypes: [.qr], scanMode: .continuous, scanInterval: 0, shouldVibrateOnSuccess: false)  { response in
                switch response {
                case .success(let result):
                    do {
                        let ur = try keystoneSDK.decodeQR(qrCode: result.string)
                        
                        if ur != nil {
                            let solSignature = try keystoneSDK.sol.parseSignature(cborHex: ur!.cbor)
                            signature = String(describing: solSignature)
                            isPresentingScanner = false
                        }
                    } catch {
                        errorMessage = "Error: \(error)"
                        isPresentingScanner = false
                    }
                case .failure(let error):
                    errorMessage = "Error: \(error)"
                    isPresentingScanner = false
                }
            }
        }
        
    }
}

struct SignTransaction_Previews: PreviewProvider {
    static var previews: some View {
//        let solSignRequest = SolSignRequest(
//            requestId: "9b1deb4d-3b7d-4bad-9bdd-2b0d7b3dcb6d",
//            signData: "01000103c8d842a2f17fd7aab608ce2ea535a6e958dffa20caf669b347b911c4171965530f957620b228bae2b94c82ddd4c093983a67365555b737ec7ddc1117e61c72e0000000000000000000000000000000000000000000000000000000000000000010295cc2f1f39f3604718496ea00676d6a72ec66ad09d926e3ece34f565f18d201020200010c0200000000e1f50500000000",
//            path: "m/44'/501'/0'/0'",
//            xfp: "707EED6C",
//            signType: .transaction,
//            origin: "OKX"
//        )

        let solSignRequest = SolSignRequest(
            requestId: "9b1deb4d-3b7d-4bad-9bdd-2b0d7b3dcb6d",
            signData: "48656c6c6f2c204b657973746f6e652e",
            path: "m/44'/501'/0'/0'",
            xfp: "F23F9FD2",
            signType: .message,
            origin: "Solflare"
        )
        SignTransaction(solSignRequest: solSignRequest)
    }
}


extension SignTransaction {
    final class ViewModel: ObservableObject {
        @Published var errorMessage: String = ""
        private var encoder: UREncoder?;

        init (solSignRequest: SolSignRequest) {
            let solSDK = KeystoneSDK().sol
            // change maxFragment to modify the qr code capacity, default 400
            KeystoneSDK.maxFragmentLen = 200
            do {
                self.encoder = try solSDK.generateSignRequest(solSignRequest: solSignRequest)
            } catch {
                errorMessage = error.localizedDescription
            }
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
        
        public func nextQRCode() -> Data?{
            if encoder != nil {
                let qrCode = encoder!.nextPart()
                return getQRCodeDate(from: qrCode)
            }
            return errorMessage.data(using: .utf8)
        }
    }
}
