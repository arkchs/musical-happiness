const express = require('express');
const mongoose = require('mongoose');

const app = express();
const PORT = 3000;
const MONGODB_URI = 'mongodb+srv://bookuser:bookpass123@bookcluster.1jfyhgm.mongodb.net/bookApp?retryWrites=true&w=majority&appName=bookcluster';
// MongoDB connection
mongoose.connect(MONGODB_URI, {

  dbName: "bookApp",
});

const db = mongoose.connection;
db.on('error', console.error.bind(console, 'MongoDB connection error:'));
db.once('open', () => {
  console.log('Connected to MongoDB');
});

// Book schema
const bookSchema = new mongoose.Schema({
  author: String,
  title: String,
//   summary: String,
  audio_url: String,
});


const Book = mongoose.model('Book', bookSchema, 'audio');


// async function testMongoDB() {
//   try {
//     await mongoose.connect(MONGODB_URI, {
//       dbName: "bookApp",
//     });

//     console.log("✅ Connected to MongoDB!");

//     // Find the first book
//     const book = await Book.findOne();

//     if (!book) {
//       console.log("❌ No book found in the collection.");
//     } else {
//       console.log("📘 Book found:");
//       console.log("Author: "+book.author);
//       console.log("Title: "+book.title);
//       console.log("Audio URL: "+book.audio_url);
//     }

//     await mongoose.disconnect();
//     console.log("🔌 Disconnected from MongoDB.");
//   } catch (err) {
//     console.error("❌ Error connecting to MongoDB:", err);
//   }
// }

// testMongoDB();


app.get('/book', async (req, res) => {
  try {
    const book = await Book.findOne();
    if (!book) {
      return res.status(404).json({ error: 'No book found' });
    }
    return res.json({
      writer: book.author,
      title: book.title,
    //   summary: book.summary,
      audioFile: book.audio_url,
    });
  } catch (err) {
    return res.status(500).json({ error: 'Server error' });
  }
});
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
