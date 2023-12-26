const express = require('express');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');

const app = express();
const PORT = 3000;

// Configure MongoDB connection (replace 'your_connection_string' with your actual connection string)
mongoose.connect('mongodb://localhost:27017/order', { useNewUrlParser: true, useUnifiedTopology: true });

// Define a schema for user registration
const registrationSchema = new mongoose.Schema({
    username: String,
    email: String,
    password: String,
    confirmPassword: String,
});

const Registration = mongoose.model('Registration', registrationSchema);

// Middleware to parse the request body
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

// Serve static files from the 'public' directory
app.use(express.static('public'));

// Route for serving the HTML file
app.get("/", (req, res) => {
    res.sendFile(__dirname + '/userreg.html');
});

// Handle form submission
app.post('/submit-user-registration', async (req, res) => {
    // Extract user data from the request body
    const userData = {
        username: req.body['username'],
        email: req.body['email'],
        password: req.body['password'],
        confirmPassword: req.body['confirmPassword'],
    };

    // Create a new registration document
    const newRegistration = new Registration(userData);

    try {
        // Save the registration to the MongoDB
        const savedRegistration = await newRegistration.save();
        res.send('User registered successfully');
    } catch (err) {
        console.error(err);
        res.status(500).send('Error registering user');
    }
});

// Start the server
app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
