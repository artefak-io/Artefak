import * as functions from "firebase-functions";

exports.mintBasedOnTransaction = functions.firestore
    .document("Transaction/{transactionID}")
    .onUpdate((change, context) => {
        // Get an object representing the document
        const newValue = change.after.data();

        const previousValue = change.before.data();

        const prevStatus = previousValue.status;
        const newStatus = newValue.status;

        if (prevStatus == newStatus) {
            // Not interested in same status
            return;
        }

        if (newStatus != "Completed") {
            // Not interested if status is not Completed yet
            return;
        }

        // If we're here means we're shifting from X -> Completed
        // TODO: do minting here, call Tatum API
    });
