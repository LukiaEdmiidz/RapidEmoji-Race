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
    English: 'string',       // Required string field (non-optional, as seen in error)
    French: 'string?',       // Optional string field
    Spanish: 'string?',      // Optional string field
    Japanese: 'string?',     // Optional string field
    frequency: 'int',        // Integer field
    Viewed: 'int?'           // Optional integer field
  }
};

// Helper function to open Realm with the correct schema
async function openRealmWithSchemaVersion() {
  let realm;

  try {
    console.log('Opening Realm with schema version 2 and provided schema');
    // Open Realm with schema version 2 and include the Emoji schema
    realm = await Realm.open({
      path: path.resolve(__dirname, 'EmojiRealmDB.realm'),
      schema: [EmojiSchema], // Include the existing schema for the Emoji table
      schemaVersion: 2,      // Set the schema version to match the file version
    });

    return realm; // Successfully opened the Realm
  } catch (error) {
    throw new Error(`Failed to open Realm: ${error.message}`);
  }
}

async function getFirst10Emojis() {
  try {
    // Open the Realm with schema version 2
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
