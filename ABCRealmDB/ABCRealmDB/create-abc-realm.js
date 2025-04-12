const Realm = require("realm");
const fs = require("fs");
const path = require("path");

// Define the Alphabet schema
const AlphabetSchema = {
  name: "Alphabet",
  properties: {
    Letter: "string",
    English_Known_Count: "string",
    French_Known_Count: "string",
    Viewed: { type: "int", default: 0 }
  },
  primaryKey: "Letter"
};

async function createAlphabetDatabase() {
  const realmPath = path.join(__dirname, "ABCRealmDB.realm");
  
  // Delete existing file if it exists
  if (fs.existsSync(realmPath)) {
    console.log(`Deleting existing database at ${realmPath}`);
    fs.unlinkSync(realmPath);
  }

  let realm;

  try {
    realm = await Realm.open({
      schema: [AlphabetSchema],
      path: realmPath,
      schemaVersion: 0  // Try with 0 instead of 1
    });

    console.log("Database created successfully.");

    const alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split('');
    
    realm.write(() => {
      alphabet.forEach(letter => {
        realm.create("Alphabet", {
          Letter: letter,
          English_Known_Count: "0",
          French_Known_Count: "0",
          Viewed: 0
        });
        console.log(`Added letter: ${letter}`);
      });
    });

    console.log("Successfully added all 26 letters to the database.");

    // Verify data
    const letters = realm.objects("Alphabet");
    console.log(`Total letters added: ${letters.length}`);
    
    if (letters.length > 0) {
      console.log("Sample entries:");
      console.log(letters[0]);
      console.log(letters[25]);
    }

  } catch (error) {
    console.error("Failed to create Alphabet database:", error);
  } finally {
    if (realm && !realm.isClosed) {
      realm.close();
      console.log("Realm instance closed properly.");
    }
  }
}

createAlphabetDatabase()
  .then(() => {
    console.log("Database creation process completed.");
  })
  .catch((error) => {
    console.error("Error in database creation process:", error);
  });
