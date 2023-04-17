//
//  MockData.swift
//  keystone-sdk-ios-demo
//
//  Created by LiYan on 4/13/23.
//

import Foundation
import KeystoneSDK

extension String {
    var hexadecimal: Data {
        var data = Data(capacity: count / 2)

        let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
        regex.enumerateMatches(in: self, range: NSRange(startIndex..., in: self)) { match, _, _ in
            let byteString = (self as NSString).substring(with: match!.range)
            let num = UInt8(byteString, radix: 16)!
            data.append(num)
        }
        guard data.count > 0 else { return Data() }
        return data
    }
}


class MockData {

    static let psbt = "70736274ff0100710200000001a6e52d0cf7bec16c454dc590966906f2f711d2ffb720bf141b41fd0cd3146a220000000000ffffffff02809698000000000016001473071357788c861241e6e991cc1f7933aa87444440ff100500000000160014d98f4c248e06e54d08bafdc213912aca80c0a34a000000000001011f00e1f50500000000160014f6de6edbdef5f0e62777c14e6e322ecb27c7824b22060341d94247fabfc265035f0a51bcfaca3b65709a7876698769a336b4142faa4bad18f23f9fd254000080000000800000008000000000000000000000220203ab7173024786ba14179c33db3b7bdf630039c24089409637323b560a4b1d025618f23f9fd2540000800000008000000080010000000000000000".hexadecimal

    static let ethSignRequest = EthSignRequest(
        requestId: "6c3633c0-02c0-4313-9cd7-e25f4f296729",
        signData: "48656c6c6f2c204b657973746f6e652e",
        dataType: .personalMessage,
        chainId: 1,
        path: "m/44'/60'/0'/0/0",
        xfp: "f23f9fd2",
        origin: "Metamask"
    )

    static let solSignRequest = SolSignRequest(
        requestId: "9b1deb4d-3b7d-4bad-9bdd-2b0d7b3dcb6d",
        signData: "01000103c8d842a2f17fd7aab608ce2ea535a6e958dffa20caf669b347b911c4171965530f957620b228bae2b94c82ddd4c093983a67365555b737ec7ddc1117e61c72e0000000000000000000000000000000000000000000000000000000000000000010295cc2f1f39f3604718496ea00676d6a72ec66ad09d926e3ece34f565f18d201020200010c0200000000e1f50500000000",
        path: "m/44'/501'/0'/0'",
        xfp: "f23f9fd2",
        signType: .transaction,
        origin: "OKX"
    )

    static let cosmosSignRequest = CosmosSignRequest(
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

    static let tronSignRequest = TronSignRequest(
        requestId: "9b1deb4d-3b7d-4bad-9bdd-2b0d7b3dcb6d",
        signData: "0a0207902208e1b9de559665c6714080c49789bb2c5aae01081f12a9010a31747970652e676f6f676c65617069732e636f6d2f70726f746f636f6c2e54726967676572536d617274436f6e747261637412740a1541c79f045e4d48ad8dae00e6a6714dae1e000adfcd1215410d292c98a5eca06c2085fff993996423cf66c93b2244a9059cbb0000000000000000000000009bbce520d984c3b95ad10cb4e32a9294e6338da300000000000000000000000000000000000000000000000000000000000f424070c0b6e087bb2c90018094ebdc03",
        path: "m/44'/195'/0'/0'",
        xfp: "f23f9fd2",
        tokenInfo: TokenInfo(
            name: "TONE", symbol: "TronOne", decimals: 8
        )
    )

    static let aptosSignRequest = AptosSignRequest(
        requestId: "7AFD5E09-9267-43FB-A02E-08C4A09417EC",
        signData: "4150544F530A6D6573736167653A207665726966795F77616C6C65740A6E6F6E63653A20373134363136353534363430333235393636333033313734",
        signType: .single,
        accounts: [
            AptosSignRequest.Account(path: "m/44'/637'/0'/0'/0'", xfp: "f23f9fd2")
        ],
        origin: "Petra"
    )
}
