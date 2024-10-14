const Realm = require("realm");
const path = require("path");

// Define the Emoji schema
const EmojiSchema = {
  name: "Emoji",
  properties: {
    Emoji: "string",
    Not_Known_Count: { type: "int", default: 0 },
    Known_Count: { type: "int", default: 0 },
    English: "string?",
    French: "string?",
    Spanish: "string?",
    Japanese: "string?",
    frequency: { type: "int", default: 0 },
    Viewed: { type: "int", optional: true, default: 0 },  // Correctly define optional int
  },
  primaryKey: "Emoji",
};

async function updateEmojiViewed() {
  const realmPath = path.join(__dirname, "EmojiRealmDB.realm");
  let realm;

  try {
    realm = await Realm.open({
      schema: [EmojiSchema],
      path: realmPath,
      schemaVersion: 3,
      migration: (oldRealm, newRealm) => {
        const oldObjects = oldRealm.objects("Emoji");
        const newObjects = newRealm.objects("Emoji");

        for (let i = 0; i < oldObjects.length; i++) {
          newObjects[i].English = oldObjects[i].English;
          newObjects[i].Viewed = oldObjects[i].Viewed ?? 0;
          newObjects[i].Not_Known_Count = oldObjects[i].Not_Known_Count ?? 0;
          newObjects[i].Known_Count = oldObjects[i].Known_Count ?? 0;
          newObjects[i].frequency = oldObjects[i].frequency ?? 0;
        }
      },
    });

    console.log("Migration completed successfully.");

    // Update all Viewed values to 0
    realm.write(() => {
      const emojis = realm.objects("Emoji");
      for (let emoji of emojis) {
        emoji.Viewed = 0;
      }
    });

    console.log("Successfully reset all 'Viewed' values to 0.");

  } catch (error) {
    console.error("Failed to update 'Viewed' field:", error);
  } finally {
    if (realm) {
      realm.close();
    }
  }
}

updateEmojiViewed().then(() => {
  console.log("Update process completed.");
}).catch((error) => {
  console.error("Error in update process:", error);
});