const functions = require("firebase-functions");
const admin = require("firebase-admin")

admin.initializeApp();

exports.helloWorld = functions.https.onRequest((request, response) => {
    response.send("Hello Keepcoders!!");
});

exports.newMessage = functions.database.ref('/messages/{discussionId}/{messageId}').onWrite((event, context) => {

    const discussionId = context.params.discussionId;
    const messageId = context.params.messageId;

    const message = event.after.val();

    var value = message.type == "image" ? "Esto es un imagen..." : message.value;

    const payload = {
        notification: {
            title: message.displayName,
            body: value
        }
    }

    const sendMessagePromise = admin.messaging().sendToTopic("GENERAL", payload);
    const setNewLastMessageDiscussion = admin.database().ref(`/discussions/${discussionId}/lastMessage`).set(value);

    return Promise.all([sendMessagePromise, setNewLastMessageDiscussion]);
});
