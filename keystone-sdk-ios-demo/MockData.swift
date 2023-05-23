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

extension Data {
    func hexEncodedString() -> String {
        return map { String(format: "%02hhx", $0) }.joined()
    }
}

func encodeJSON(data: Encodable) -> Data {
    let jsonEncoder = JSONEncoder()
    jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
    return try! jsonEncoder.encode(data)
}


class MockData {

    static let psbt = "70736274ff0100710200000001a6e52d0cf7bec16c454dc590966906f2f711d2ffb720bf141b41fd0cd3146a220000000000ffffffff02809698000000000016001473071357788c861241e6e991cc1f7933aa87444440ff100500000000160014d98f4c248e06e54d08bafdc213912aca80c0a34a000000000001011f00e1f505000000001600147ced797aa1e84df81e4b9dc8a46b8db7f4abae9122060341d94247fabfc265035f0a51bcfaca3b65709a7876698769a336b4142faa4bad18f23f9fd254000080000000800000008000000000000000000000220203ab7173024786ba14179c33db3b7bdf630039c24089409637323b560a4b1d025618f23f9fd2540000800000008000000080010000000000000000".hexadecimal

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
        signData: "0a0207902208e1b9de559665c6714080c49789bb2c5aae01081f12a9010a31747970652e676f6f676c65617069732e636f6d2f70726f746f636f6c2e54726967676572536d617274436f6e747261637412740a15418dfec1cde1fe6a9ec38a16c7d67073e3020851c0121541a614f803b6fd780986a42c78ec9c7f77e6ded13c2244a9059cbb0000000000000000000000009c0279f1bda9fc40a85f1b53c306602864533e73000000000000000000000000000000000000000000000000000000000098968070c0b6e087bb2c90018094ebdc03",
        path: "m/44'/195'/0'/0/0",
        xfp: "F23F9FD2",
        tokenInfo: TokenInfo(name: "TRON_USDT", symbol: "USDT", decimals: 6)
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
    
    static let suiSignRequest = SuiSignRequest(
        requestId: "9b1deb4d-3b7d-4bad-9bdd-2b0d7b3dcb6d",
        signData: "00000200201ff915a5e9e32fdbe0135535b6c69a00a9809aaf7f7c0275d3239ca79db20d6400081027000000000000020200010101000101020000010000ebe623e33b7307f1350f8934beb3fb16baef0fc1b3f1b92868eec3944093886901a2e3e42930675d9571a467eb5d4b22553c93ccb84e9097972e02c490b4e7a22ab73200000000000020176c4727433105da34209f04ac3f22e192a2573d7948cb2fabde7d13a7f4f149ebe623e33b7307f1350f8934beb3fb16baef0fc1b3f1b92868eec39440938869e803000000000000640000000000000000",
        signType: .single,
        accounts: [
            SuiSignRequest.Account(path: "m/44'/784'/0'/0'/0'", xfp: "f23f9fd2", address: "0xebe623e33b7307f1350f8934beb3fb16baef0fc1b3f1b92868eec39440938869")
        ],
        origin: "Sui Wallet"
    )

    static let ltcTransaction = LitecoinTransaction (
        fee: 2250,
        inputs: [
            LitecoinTransaction.Input(
                hash: "a59bcbaaae11ba5938434e2d4348243e5e392551156c4a3e88e7bdc0b2a8f663",
                index: 1,
                utxo: LitecoinTransaction.Input.Utxo(
                    publicKey: "035684d200e10bc1a3e2bd7d59e58a07f2f19ef968725e18f1ed65e13396ab9466",
                    value: 18519750
                ),
                ownerKeyPath: "m/49'/2'/0'/0/0"
            )
        ],
        outputs: [
            Output(address: "MUfnaSqZjggTrHA2raCJ9kxpP2hM6zezKw", value: 10000),
            Output(address: "MK9aTexgpbRuMPqGpMERcjJ8hLJbAS31Nx", value: 18507500, isChange: true, changeAddressPath: "M/49'/2'/0'/0/0")
        ]
    )
    static let ltcSignRequest = KeystoneSignRequest<LitecoinTransaction>(
        requestId: "cc946be2-8e4c-42be-a321-56a53a8cf516",
        signData: ltcTransaction,
        xfp: "F23F9FD2"
    )

    static let dashTransaction = UtxoBaseTransaction (
        fee: 2250,
        inputs: [
            Input(
                hash: "a59bcbaaae11ba5938434e2d4348243e5e392551156c4a3e88e7bdc0b2a8f663",
                index: 1,
                value: 18519750,
                pubkey: "03cf51a0e4f926e50177d3a662eb5cc38728828cec249ef42582e77e5503675314",
                ownerKeyPath: "m/44'/5'/0'/0/0"
            ),
        ],
        outputs: [
            Output(address: "XphpGezU3DUKHk87v2DoL4r7GhZUvCvvbm", value: 10000),
            Output(address: "XfmecwGwcPBR7pXTqrn26jTjNe8a4fvcSL", value: 18507500, isChange: true, changeAddressPath: "M/44'/5'/0'/0/0")
        ]
    )
    static let dashSignRequest = KeystoneSignRequest<UtxoBaseTransaction>(
        requestId: "cc946be2-8e4c-42be-a321-56a53a8cf516",
        signData: dashTransaction,
        xfp: "F23F9FD2"
    )

    static let bchTransaction = UtxoBaseTransaction (
        fee: 2250,
        inputs: [
            Input(
                hash: "a59bcbaaae11ba5938434e2d4348243e5e392551156c4a3e88e7bdc0b2a8f663",
                index: 1,
                value: 18519750,
                pubkey: "025ad49879cc8f1f91a210c6a2762fe4904ef0d4f17fd124b11b86135e4cb9143d",
                ownerKeyPath: "m/44'/145'/0'/0/0"
            ),
        ],
        outputs: [
            Output(address: "bitcoincash:qzrxqxsx0lfzyk4ht60a5hwwtr2xjvtxmu0qhkusnx", value: 10000),
            Output(address: "bitcoincash:qpgw8p85ysnjutpsk6u490ytydmgdlmc6vzxu680su", value: 18507500, isChange: true, changeAddressPath: "M/44'/145'/0'/0/0")
        ]
    )
    static let bchSignRequest = KeystoneSignRequest<UtxoBaseTransaction>(
        requestId: "cc946be2-8e4c-42be-a321-56a53a8cf516",
        signData: bchTransaction,
        xfp: "F23F9FD2"
    )
    
    static let nearSignRequest = NearSignRequest(
        requestId: "9b1deb4d-3b7d-4bad-9bdd-2b0d7b3dcb6d",
        signData: ["4000000039666363303732306130313664336331653834396438366231366437313339653034336566633438616464316337386633396333643266303065653938633037009FCC0720A016D3C1E849D86B16D7139E043EFC48ADD1C78F39C3D2F00EE98C07823E0CA1957100004000000039666363303732306130313664336331653834396438366231366437313339653034336566633438616464316337386633396333643266303065653938633037F0787E1CB1C22A1C63C24A37E4C6C656DD3CB049E6B7C17F75D01F0859EFB7D80100000003000000A1EDCCCE1BC2D3000000000000"],
        path: "m/44'/397'/0'",
        xfp: "F23F9FD2"
    )

    static let arweaveTransaction = ArweaveTransaction(
        format: 2,
        id: "",
        lastTx: "gTH4F1aPYXv91JpKkn9IS6hHwQZ1AYyIeCRy2QiOeAETwIEMMXxxnFj0ekBFlq99",
        owner: "",
        target: "kyiw1Y4ylryGVRwtTatsG-IN9ew88GMlY-y_LG3FxGA",
        quantity: "1000000000",
        reward: "9107574386"
    )

    static let arweaveSignRequest = ArweaveSignRequest(
        masterFingerprint: "F23F9FD2",
        requestId: "9b1deb4d-3b7d-4bad-9bdd-2b0d7b3dcb6d",
        signData: encodeJSON(data: arweaveTransaction).hexEncodedString(),
        saltLen: .zero,
        signType: .transaction,
        origin: "arconnect"
    )

    static let cardanoSignRequest = CardanoSignRequest(
        requestId: "9b1deb4d-3b7d-4bad-9bdd-2b0d7b3dcb6d",
        signData: "84a400828258204e3a6e7fdcb0d0efa17bf79c13aed2b4cb9baf37fb1aa2e39553d5bd720c5c99038258204e3a6e7fdcb0d0efa17bf79c13aed2b4cb9baf37fb1aa2e39553d5bd720c5c99040182a200581d6179df4c75f7616d7d1fd39cbc1a6ea6b40a0d7b89fea62fc0909b6c370119c350a200581d61c9b0c9761fd1dc0404abd55efc895026628b5035ac623c614fbad0310119c35002198ecb0300a0f5f6",
        utxos: [
            CardanoSignRequest.Utxo(
                transactionHash: "4e3a6e7fdcb0d0efa17bf79c13aed2b4cb9baf37fb1aa2e39553d5bd720c5c99",
                index: 3,
                amount: 10000000,
                xfp: "73c5da0a",
                hdPath: "m/1852'/1815'/0'/0/0",
                address: "addr1qy8ac7qqy0vtulyl7wntmsxc6wex80gvcyjy33qffrhm7sh927ysx5sftuw0dlft05dz3c7revpf7jx0xnlcjz3g69mq4afdhv"
            ),
            CardanoSignRequest.Utxo(
                transactionHash: "4e3a6e7fdcb0d0efa17bf79c13aed2b4cb9baf37fb1aa2e39553d5bd720c5c99",
                index: 4,
                amount: 18020000,
                xfp: "73c5da0a",
                hdPath: "m/1852'/1815'/0'/0/1",
                address: "addr1qyz85693g4fr8c55mfyxhae8j2u04pydxrgqr73vmwpx3azv4dgkyrgylj5yl2m0jlpdpeswyyzjs0vhwvnl6xg9f7ssrxkz90"
            )
        ],
        certKeys: [
            CardanoSignRequest.CertKey(
                keyHash: "e557890352095f1cf6fd2b7d1a28e3c3cb029f48cf34ff890a28d176", xfp: "73c5da0a", keyPath: "m/1852'/1815'/0'/2/0"
            )
        ],
        origin: "cardano-wallet"
    )
}
