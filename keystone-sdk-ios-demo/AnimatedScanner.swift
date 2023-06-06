//
//  AnimatedScanner.swift
//  keystone-sdk-ios-demo
//
//  Created by LiYan on 4/13/23.
//

import SwiftUI
import KeystoneSDK
import URKit
import CodeScanner

struct AnimatedScanner<T>: View {
    private var parseFn: (UR) throws -> T;
    private var onSucceed: (T) -> ()
    private var onError: (String) -> ()

    private let keystoneSDK = KeystoneSDK();
    @State var isPresentingScanner: Bool = false;
    
    init(parseFn: @escaping (UR)throws -> T, onSucceed: @escaping (T) -> (), onError: @escaping (String) -> ()) {
        self.parseFn = parseFn;
        self.onSucceed = onSucceed;
        self.onError = onError;
    }

    var body: some View {
        VStack {
            Button {
                isPresentingScanner = true
            } label: {
                Text("Scan Keystone")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color.white)
                    .frame(width: 280, height: 50)
                    .background(Color.cyan)
                    .cornerRadius(12)
            }
        }.sheet(isPresented: $isPresentingScanner) {
            CodeScannerView(codeTypes: [.qr], scanMode: .continuous, scanInterval: 0, shouldVibrateOnSuccess: false)  { response in
                switch response {
                case .success(let result):
                    do {
                        let result = try keystoneSDK.decodeQR(qrCode: result.string)

                        print("==============> progress: \(result.progress)")

                        if result.progress == 100 {
                            let scanResult = try parseFn(result.ur!)
                            isPresentingScanner = false
                            onSucceed(scanResult)
                        }
                    } catch QRCodeError.invalidQRCode {
                        isPresentingScanner = false
                        onError("invalid QR Code")
                    } catch QRCodeError.unexpectedQRCode {
                        isPresentingScanner = false
                        onError("unexpected QR Code")
                    } catch {
                        isPresentingScanner = false
                        onError("unknown error")
                    }
                case .failure(let error):
                    isPresentingScanner = false
                    onError(error.localizedDescription)
                }
            }
        }
    }
}

struct AnimatedScanner_Previews: PreviewProvider {
    
    static func onScanSucceed(multiAccounts: MultiAccounts){
        let accountsStr = String(describing: multiAccounts)
        print("Scan result: \(accountsStr)")
    }
    
    static func onScanFailed(error: String){
        print("Scan failed: \(error)")
    }
    
    static var previews: some View {
        let parseFn = KeystoneSDK().parseMultiAccounts
        AnimatedScanner<MultiAccounts>(parseFn: parseFn, onSucceed: onScanSucceed, onError: onScanFailed)
    }
}
