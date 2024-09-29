const Realm = require("realm");

const EmojiSchema = {
  name: "Emoji",
  properties: {
    Emoji: "string?", // Removed the primary key designation
    Not_Known_Count: "int?",
    Known_Count: "int?",
    English: "string?",
    French: "string?",
    Spanish: "string?",
    Japanese: "string?"
  }
};

const config = {
  path: "/Users/edmiidz/Projects/GitHub/RapidEmoji-Race/EmojiRealmDB/EmojiRealmDB/EmojiRealmDB_doesnotwork.realm",
  schema: [EmojiSchema],
  schemaVersion: 1, // Adjust this based on the current schema version of your Realm database
  migration: (oldRealm, newRealm) => {
    // Define any data migration logic here, if necessary
  }
};

Realm.open(config).then(realm => {
  console.log("Realm opened successfully, schema updated.");
  realm.close();
}).catch(error => {
  console.error("Failed to update Realm schema:", error);
});
