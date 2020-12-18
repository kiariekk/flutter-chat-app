import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

export const updateLastMessage = functions.firestore
  .document("chats/{chatId}/messages/{messageId}")
  .onCreate((snapshot, context) => {
    const chatId = context.params.chatId;
    const newMessageData = snapshot.data();
    return admin
      .firestore()
      .doc(`chats/${chatId}`)
      .update({
        lastMessage: {
          content:
            newMessageData.content ||
            `${newMessageData.senderEmail} shared a location`,
          createdAt: newMessageData.createdAt,
        },
      });
  });
