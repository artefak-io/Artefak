const firebase = require("firebase-functions-test");
const testEnv = firebase({ projectId: "artefak-io" }, "./service-account.json");

const { mintBasedOnTransaction, createWalletOnAuth } = require('../index.js');
const wrappedMint = testEnv.wrap(mintBasedOnTransaction);
const wrappedWallet = testEnv.wrap(createWalletOnAuth);

describe("Test trigger", () => {
    test("Test Transaction", async () => {
        const before = {
            status: 'Pending',
        };
        const after = {
            status: 'Completed',
            testUserID: 'UnitTestAuth',
        };

        const beforeSnap = testEnv.firestore.makeDocumentSnapshot(before, '/Transaction/1234');
        const afterSnap = testEnv.firestore.makeDocumentSnapshot(after, '/Transaction/1234');

        const change = testEnv.makeChange(beforeSnap, afterSnap);
        await wrappedMint(change);

        expect(1).toBe(1);
    });

    test("Test Wallet Creation", async () => {
        const auth = {
            uid: 'UnitTestAuth',
            authType: 'USER'
        };

        await wrappedWallet(auth);

        expect(1).toBe(1);
    });
});
