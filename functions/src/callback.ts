import * as functions from 'firebase-functions';
import * as cors from 'cors';
import * as admin from 'firebase-admin';

const db = admin.firestore();

exports.paymentResult = functions.https.onRequest(async (request: functions.Request, response: functions.Response) => {
    if (request.method === 'PUT') {
        response.status(403).send('Forbidden!');
        return;
    }

    cors({ origin: true })(request, response, async () => {
        const body = JSON.parse(request.body.toString());
        const status = body.data.attributes.status;
        const transactionId = body.data.attributes.paymentMethod.referenceId;


        if (status.toLowerCase() !== 'paid' && status.toLowerCase() !== 'completed') {
            response.status(200).send(body);
            return;
        }

        console.log('changing Transaction status so we can start minting!');

        const transactionObject = await db.doc('Transaction/' + transactionId).get();
        await transactionObject.ref.update({
            status: 'completed'
        });

        response.status(200).send(body);
        return;
    });
});