const express = require('express');
const bodyParser = require('body-parser');
const oracledb = require('oracledb');

const app = express();
const PORT = 3000; // You can use any available port

// Configure Oracle Database connection (replace 'your_connection_string' with your actual connection string)
const dbConfig = {
    user: 'Kabeleswar',
    password: 'Kabilesh13',
    connectString: 'localhost:1521/xe'
};
oracledb.initOracleClient({ libDir: '' });

// Middleware to parse the request body
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

// Serve static files from the 'public' directory
app.use(express.static('public'));

// Route for serving the HTML file
app.get("/", (req, res) => {
    res.sendFile(__dirname + '/user_registration.html');
});

// Handle form submission
app.post('/register', async (req, res) => {
    // Extract user data from the request body
    const userData = {
        username: req.body['username'],
        email: req.body['email'],
        password: req.body['password'],
        confirmPassword: req.body['confirmPassword'],
    };

    // Connect to the Oracle Database
    let connection;
    try {
        connection = await oracledb.getConnection(dbConfig);

        // Insert user data into the database
        const result = await connection.execute(
            `INSERT INTO registration (USERNAME, EMAIL, PASSWORD, CONFIRMPASSWORD) VALUES (:username, :email, :password, :confirmPassword)`,
            userData
        );
        // Commit the transaction
        await connection.commit();

        console.log(result);

        res.send('User registered successfully');
    } catch (err) {
        console.error(err);
        res.status(500).send('Error registering user');
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
});

// Start the server
app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});