import * as functions from 'firebase-functions';
import * as cors from 'cors';
import * as admin from 'firebase-admin';

const db = admin.firestore();

exports.paymentResult = functions.https.onRequest((request: functions.Request, response: functions.Response) => {
    if (request.method === 'PUT') {
        response.status(403).send('Forbidden!');
        return;
    }
    console.log('masuk sini')

    cors({ origin: true })(request, response, async () => {
        const body = request.body;

        const status = body.data.attributes.status;
        const transactionId = body.data.attributes.referenceId;

        if (status.toLowerCase() !== 'paid' && status.toLowerCase() !== 'completed') {
            response.status(200).send(body);
            return;
        }

        const transactionObject = await db.doc('Transaction/' + transactionId).get();
        await transactionObject.ref.update({
            status: 'completed'
        });

        // TODO: create Asset from Collection

        response.status(200).send(body);
    });
});