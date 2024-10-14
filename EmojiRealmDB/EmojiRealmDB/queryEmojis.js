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
    Viewed: { type: "int", optional: true, default: 0 },
  },
  primaryKey: "Emoji",
};

async function queryFirstTenRecords() {
  const realmPath = path.join(__dirname, "EmojiRealmDB.realm");

  try {
    // Get the current schema version
    const currentSchemaVersion = await Realm.schemaVersion(realmPath);
    console.log(`Current schema version: ${currentSchemaVersion}`);

    // Open the Realm with the current schema version
    const realm = await Realm.open({
      schema: [EmojiSchema],
      path: realmPath,
      schemaVersion: currentSchemaVersion,
    });

    const emojis = realm.objects("Emoji");
    const firstTen = emojis.slice(0, 10);

    console.log("First 10 Emoji records:");
    firstTen.forEach((emoji, index) => {
      console.log(`\nRecord ${index + 1}:`);
      console.log(`Emoji: ${emoji.Emoji}`);
      console.log(`English: ${emoji.English || 'N/A'}`);
      console.log(`Not Known Count: ${emoji.Not_Known_Count}`);
      console.log(`Known Count: ${emoji.Known_Count}`);
      console.log(`Frequency: ${emoji.frequency}`);
      console.log(`Viewed: ${emoji.Viewed}`);
    });

    console.log(`\nTotal number of records: ${emojis.length}`);

    // Close the Realm when done
    realm.close();

  } catch (error) {
    console.error("Failed to query records:", error);
  }
}

queryFirstTenRecords().then(() => {
  console.log("Query completed.");
}).catch((error) => {
  console.error("Error in query process:", error);
});