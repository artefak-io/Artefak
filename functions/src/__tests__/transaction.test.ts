const firebase = require("firebase-functions-test");
const admin = require("firebase-admin")

const testEnv = firebase({ projectId: "artefak-io" }, "./service-account.json");

const { mintBasedOnTransaction } = require('../index.js');
const wrapped = testEnv.wrap(mintBasedOnTransaction);

test("Test Transaction", async () => {
    const before = {
        status: 'Pending',
    };
    const after = {
        status: 'Completed',
    };

    const beforeSnap = testEnv.firestore.makeDocumentSnapshot(before, '/Transaction/1234');
    const afterSnap = testEnv.firestore.makeDocumentSnapshot(after, '/Transaction/1234');
    const change = testEnv.makeChange(beforeSnap, afterSnap);
    wrapped(change);

    expect(1).toBe(1);
})
