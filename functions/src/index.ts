import * as admin from 'firebase-admin';
admin.initializeApp(); // IMPORTANT TO DO THIS FIRST
const db = admin.firestore();

import * as functions from 'firebase-functions';
import axios from 'axios';

export * from './callback';

const TATUM_API_KEY = "52a0d1b3-06b7-4a87-a4d5-e7ba5eba6529";

exports.mintBasedOnTransaction = functions.firestore
    .document("Transaction/{transactionID}")
    .onUpdate(async (change: {
        after: {
            [x: string]: any; data: () => any;
        }; before: { data: () => any; };
    }, _: any) => {
        // Get an object representing the document
        const newValue = change.after.data();

        const previousValue = change.before.data();

        const prevStatus = previousValue.status;
        const newStatus = newValue.status;

        if (prevStatus == newStatus) {
            // Not interested in same status
            return;
        }

        if (newStatus.toLowerCase() != "completed") {
            // Not interested if status is not Completed yet
            return;
        }

        let buyer;

        if (newValue.testUserID != null) {
            // TODO: this is dumb, but I just want to test this
            buyer = await db.doc('User/' + newValue.testUserID).get();
        } else {
            if (typeof newValue.buyerId === 'string' || newValue.buyerId instanceof String) {
                buyer = await db.doc('User/' + newValue.buyerId).get();
            } else {
                buyer = await newValue.buyer.get();
            }
        }

        const buyerData = buyer.data();

        // If we're here means we're shifting from X -> Completed
        const mint = await mintNFTToBSC(
            "0xbbbbace6992147c0b16c49c3fb66e7d9268ac765e1deed0cb83c07e727ddceb8", // TODO: make Artefak minter ID
            buyerData['publicKey'], // TODO: get user's public address
            "artefak.io",
        );

        return await change.after.ref.set({
            blockchainTransactionAddress: mint['txId'],
        }, { merge: true });
    });

exports.createWalletOnAuth = functions.auth.user().onCreate(async (user: any) => {
    // TODO: change this index
    const index = 1;
    const bscWalletObject = await generateBSCWallet();
    const mnemonic = bscWalletObject['mnemonic'];

    const publicKeyObject = await generatePublicKey(bscWalletObject['xpub'], index);
    const privateKeyObject = await generatePrivateKey(mnemonic, index);


    const publicKey = publicKeyObject['address'];
    const privateKey = privateKeyObject['key'];

    return await db.doc('User/' + user.uid).set({
        mnemonic,
        publicKey,
        privateKey,
    });
});

// Documentation to create wallet: https://docs.tatum.io/guides/blockchain/how-to-create-a-blockchain-wallet
// returns { "mnemonic": <mnemonic> }
async function generateBSCWallet() {
    const response = await axios.get(
        "https://api-us-west1.tatum.io/v3/bsc/wallet?type=testnet",
        {
            headers: {
                "x-api-key": TATUM_API_KEY,
            }
        });

    return response.data;
}

// returns { "address": <public address> }
async function generatePublicKey(xpub: string, index: number) {
    const response = await axios.get(
        "https://api-us-west1.tatum.io/v3/bsc/address/" + xpub + "/" + index + "?type=testnet",
        {
            headers: {
                "x-api-key": TATUM_API_KEY,
            }
        });

    return response.data;
}

// returns { "key": <private key> }
async function generatePrivateKey(mnemonic: any, index: any) {
    const body = {
        "mnemonic": mnemonic,
        "index": index,
    };

    const response = await axios.post(
        "https://api-us-west1.tatum.io/v3/bsc/wallet/priv?type=testnet",
        body,
        {
            headers: {
                "x-api-key": TATUM_API_KEY,
                "Content-Type": "application/json"
            }
        });

    return response.data;
}

async function getBlockchainDetail(blockchain: string) {
    return await db.doc('Blockchain/' + blockchain).get();
}

// Tatum Documentation: https://docs.tatum.io/guides/blockchain/how-to-create-nft-token
async function mintNFTToBSC(fromPrivateKey: any, receiverAddress: any, externalURL: any) {
    const blockChainDetailObject = await getBlockchainDetail("BSC Testnet");
    const blockChainDetail = blockChainDetailObject.data()!;

    const body = {
        "chain": "BSC",
        "fromPrivateKey": fromPrivateKey,
        "to": receiverAddress,
        "url": externalURL,
        "tokenId": blockChainDetail['tokenId'] + "",
        "contractAddress": blockChainDetail['contractAddress'],
    };

    const response = await axios.post(
        "https://api-us-west1.tatum.io/v3/nft/mint?type=testnet",
        body,
        {
            headers: {
                "x-api-key": TATUM_API_KEY,
                "Content-Type": "application/json"
            }
        });

    await blockChainDetailObject.ref.update({
        tokenId: blockChainDetail['tokenId'] + 1,
    });

    return response.data;
}