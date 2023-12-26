// Import necessary modules
const express = require('express');
const bodyParser = require('body-parser');
const oracledb = require('oracledb');

// Create an Express app
const app = express();
const PORT = 3000;

// Configure Oracle Database connection
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
    res.sendFile(__dirname + '/menu.html');
});

// API endpoint to handle order creation
app.post('/api/order1', async (req, res) => {
    const {
        dishId,
        restaurantId,
        itemName,
        itemPrice,
        itemDescription
    } = req.body;

    console.log('Received order:', {
        dishId,
        restaurantId,
        itemName,
        itemPrice,
        itemDescription
    });

    // Connect to the Oracle Database
    let connection;
    try {
        connection = await oracledb.getConnection(dbConfig);

        // Insert order data into the database
        const result = await connection.execute(
            `INSERT INTO orders1 (DISH_ID, RESTAURANT_ID, ITEM_NAME, ITEM_PRICE, ITEM_DESCRIPTION) 
            VALUES (:dishId, :restaurantId, :itemName, :itemPrice, :itemDescription)`,
            {
                dishId,
                restaurantId,
                itemName,
                itemPrice,
                itemDescription
            },
            { autoCommit: true } // Commit the transaction
        );

        console.log(result);

        res.json({ success: true, message: 'Order saved successfully' });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Error saving order to the database' });
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
