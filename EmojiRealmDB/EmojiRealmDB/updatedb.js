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
      schemaVersion: 4,  // Increment schema version to ensure migration is applied
      migration: (oldRealm, newRealm) => {
        const oldObjects = oldRealm.objects("Emoji");
        const newObjects = newRealm.objects("Emoji");

        for (let i = 0; i < oldObjects.length; i++) {
          let oldObject = oldObjects[i];
          let newObject = newObjects[i];

          // Set each property explicitly during migration
          newObject.Emoji = oldObject.Emoji;
          newObject.Not_Known_Count = oldObject.Not_Known_Count ?? 0;
          newObject.Known_Count = oldObject.Known_Count ?? 0;
          newObject.English = oldObject.English;
          newObject.French = oldObject.French;
          newObject.Spanish = oldObject.Spanish;
          newObject.Japanese = oldObject.Japanese;
          newObject.frequency = oldObject.frequency ?? 0;
          newObject.Viewed = 0;  // Explicitly set `Viewed` to 0 for all records

          console.log(`Migrated Emoji: ${newObject.Emoji}, Viewed set to: ${newObject.Viewed}`);
        }
      },
    });

    console.log("Migration completed successfully.");

    // Update all Viewed values to 0
    realm.write(() => {
      const emojis = realm.objects("Emoji");
      for (let emoji of emojis) {
        emoji.Viewed = 0;
        console.log(`Setting ${emoji.Emoji} Viewed to 0`);
      }
      console.log("Committing write transaction...");
    });

    // Verify updated values
    const updatedEmojis = realm.objects("Emoji");
    for (let emoji of updatedEmojis) {
      console.log(`Verified ${emoji.Emoji} Viewed value after write: ${emoji.Viewed}`);
    }

    console.log("Successfully reset all 'Viewed' values to 0.");

  } catch (error) {
    console.error("Failed to update 'Viewed' field:", error);
  } finally {
    if (realm && !realm.isClosed) {
      realm.close();
      console.log("Realm instance closed properly.");
    }
  }
}

updateEmojiViewed().then(() => {
  console.log("Update process completed.");
}).catch((error) => {
  console.error("Error in update process:", error);
});