const Realm = require('realm');
const path = require('path');

// Define the schema exactly as it appears in the Realm file
const EmojiSchema = {
  name: 'Emoji',
  primaryKey: 'Emoji',  // 'Emoji' is the primary key
  properties: {
    Emoji: 'string',         // The emoji itself is the primary key and a string
    Not_Known_Count: 'int',  // Integer field
    Known_Count: 'int',      // Integer field
    English: 'string?',      // Optional string field (migration will handle optional/required)
    French: 'string?',       // Optional string field
    Spanish: 'string?',      // Optional string field
    Japanese: 'string?',     // Optional string field
    frequency: 'int',        // Integer field
    Viewed: 'int?'           // Optional integer field
  }
};

// Helper function to open Realm with the correct schema and handle migration
async function openRealmWithSchemaVersion() {
  let realm;

  try {
    console.log('Opening Realm with schema version 4, migration allowed');
    // Open Realm with schema version 4 and handle migration
    realm = await Realm.open({
      path: path.resolve(__dirname, 'EmojiRealmDB.realm'),
      schema: [EmojiSchema], // Include the existing schema for the Emoji table
      schemaVersion: 4,      // Set the schema version to match the file version (version 4)
      migration: (oldRealm, newRealm) => {
        const oldObjects = oldRealm.objects('Emoji');
        const newObjects = newRealm.objects('Emoji');

        // Migration logic: Handle optional/required changes
        for (let i = 0; i < oldObjects.length; i++) {
          // Ensure English is not null
          if (newObjects[i].English === null) {
            newObjects[i].English = ''; // Set default value for English if it was null
          }
        }
      }
    });

    return realm; // Successfully opened the Realm
  } catch (error) {
    throw new Error(`Failed to open Realm: ${error.message}`);
  }
}

async function getFirst10Emojis() {
  try {
    // Open the Realm with schema version 4
    const realm = await openRealmWithSchemaVersion();

    // Query the first 10 objects in the Emoji table
    const emojis = realm.objects('Emoji').slice(0, 10);

    // Log the result
    emojis.forEach((emoji, index) => {
      console.log(`Emoji ${index + 1}: ${JSON.stringify(emoji)}`);
    });

    realm.close(); // Close the Realm after querying
  } catch (err) {
    console.error('Error reading the Realm database:', err);
  }
}

getFirst10Emojis();
