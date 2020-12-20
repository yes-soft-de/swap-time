var msg = {
    "message": {
        "token": "ctKhnxIvSIac3Oq8Q46SQE:APA91bFqiQAXq6lwlwZX2hFbzcm7OZtsBSM3gwHI6vkLHnqd4s1A2bUjLDJ_QTyo4GUaFAqq5Zo9lytmeRimYuVHE8WV5UzF5hnLiV43ilRr5KBEcaMMo3Nf3nVWg",
        "notification": {
            "title": "Portugal vs. Denmark",
            "body": "great match!"
        }
    }
};

var admin = require('firebase-admin');
var serviceAccount = require("../fireconfig.json");
admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: "https://yes-soft-6866a.firebaseio.com"
});

var messaging = admin.messaging();

messaging.sendToDevice(
    "ctKhnxIvSIac3Oq8Q46SQE:APA91bFqiQAXq6lwlwZX2hFbzcm7OZtsBSM3gwHI6vkLHnqd4s1A2bUjLDJ_QTyo4GUaFAqq5Zo9lytmeRimYuVHE8WV5UzF5hnLiV43ilRr5KBEcaMMo3Nf3nVWg-vBDsQ8zvsaJLL0", {
        "notification": {
            "title": "Portugal vs. Denmark",
            "body": "great match!"
        }
    }).then((s) => {
    console.log(s);
}).catch((e) => {
    console.log('Error: ' + e.body);
});