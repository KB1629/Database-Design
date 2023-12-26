const express = require('express');
const oracledb = require('oracledb');
const bodyParser = require('body-parser');
const app = express();
const port = 3000;
 
// Oracle DB Thin Driver Configuration
oracledb.initOracleClient({ libDir: '' });
 
// Oracle DB Configuration
const dbConfig = {
    user: 'Kabeleswar',
    password: 'Kabilesh13',
    connectString: 'localhost:1521/xe'
};
 
// Middleware for parsing request bodies
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json()); // For parsing application/json
 
app.get('/', (req, res) => {
    res.send(`
<!DOCTYPE html>
<html>
<head>
<title>Submit, Fetch, Update, and Delete Names</title>
<script>
                    function submitName() {
                        const name = document.getElementById('name').value;
                        fetch('/submit-name', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/x-www-form-urlencoded',
                            },
                            body: 'name=' + encodeURIComponent(name)
                        })
                        .then(response => response.text())
                        .then(data => {
                            alert(data);
                            document.getElementById('name').value = ''; // Clear the input field
                        })
                        .catch(error => console.error('Error:', error));
                        return false; // Prevent traditional form submission
                    }
 
                    function fetchNames() {
                        fetch('/fetch-names')
                            .then(response => response.json())
                            .then(data => {
                                const table = document.getElementById('namesTable');
                                table.innerHTML = '<tr><th>ID</th><th>Name</th><th>Actions</th></tr>'; // Clear and set headers
                                data.forEach(item => {
                                    const row = table.insertRow(-1);
                                    row.insertCell(0).textContent = item.ID;
                                    row.insertCell(1).textContent = item.NAME;
                                    const actionCell = row.insertCell(2);
                                    actionCell.innerHTML = '<button onclick="editName(' + item.ID + ')">Edit</button>' +
                                                           '<button onclick="deleteName(' + item.ID + ')">Delete</button>';
                                });
                            })
                            .catch(error => console.error('Error:', error));
                    }
 
                    function editName(id) {
                        const newName = prompt('Enter the new name:');
                        if (newName) {
                            fetch('/update-name', {
                                method: 'PUT',
                                headers: {
                                    'Content-Type': 'application/json',
                                },
                                body: JSON.stringify({ id, name: newName })
                            })
                            .then(response => response.text())
                            .then(data => {
                                alert(data);
                                fetchNames(); // Refresh the names list
                            })
                            .catch(error => console.error('Error:', error));
                        }
                    }
 
                    function deleteName(id) {
                        if (confirm('Are you sure you want to delete this name?')) {
                            fetch('/delete-name', {
                                method: 'DELETE',
                                headers: {
                                    'Content-Type': 'application/json',
                                },
                                body: JSON.stringify({ id })
                            })
                            .then(response => response.text())
                            .then(data => {
                                alert(data);
                                fetchNames(); // Refresh the names list
                            })
                            .catch(error => console.error('Error:', error));
                        }
                    }
</script>
</head>
<body>
<form onsubmit="return submitName()">
<label for="name">Name:</label>
<input type="text" id="name" name="name" required>
<input type="submit" value="Submit">
</form>
<button onclick="fetchNames()">Fetch Names</button>
<table id="namesTable" border="1">
<tr><th>ID</th><th>Name</th><th>Actions</th></tr>
</table>
</body>
</html>
    `);
});
 
app.post('/submit-name', async (req, res) => {
    const name = req.body.name;
    try {
        await insertNameIntoDatabase(name);
        res.send('Name inserted successfully');
    } catch (error) {
        console.error('Error:', error);
        res.status(500).send('Error occurred while inserting name');
    }
});
 
app.get('/fetch-names', async (req, res) => {
    try {
        const names = await fetchNamesFromDatabase();
        res.json(names);
    } catch (error) {
        console.error('Error:', error);
        res.status(500).send('Error occurred while fetching names');
    }
});
 
app.put('/update-name', async (req, res) => {
    try {
        const { id, name } = req.body;
        await updateNameInDatabase(id, name);
        res.send('Name updated successfully');
    } catch (error) {
        console.error('Error:', error);
        res.status(500).send('Error occurred while updating name');
    }
});
 
app.delete('/delete-name', async (req, res) => {
    try {
        const { id } = req.body;
        await deleteNameFromDatabase(id);
        res.send('Name deleted successfully');
    } catch (error) {
        console.error('Error:', error);
        res.status(500).send('Error occurred while deleting name');
    }
});
 
async function insertNameIntoDatabase(name) {
    let connection;
    try {
        connection = await oracledb.getConnection(dbConfig);
        const sql = `INSERT INTO users (name) VALUES (:name)`;
        const result = await connection.execute(sql, [name], { autoCommit: true });
        console.log("Row inserted:", result.rowsAffected);
    } catch (err) {
        throw err;
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
}
 
async function fetchNamesFromDatabase() {
    let connection;
    try {
        connection = await oracledb.getConnection(dbConfig);
        const sql = `SELECT id, name FROM users ORDER BY id`;
        const result = await connection.execute(sql, [], { outFormat: oracledb.OUT_FORMAT_OBJECT });
        return result.rows.map(row => ({ ID: row.ID, NAME: row.NAME }));
    } catch (err) {
        throw err;
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
}
 
async function updateNameInDatabase(id, name) {
    let connection;
    try {
        connection = await oracledb.getConnection(dbConfig);
        const sql = `UPDATE users SET name = :name WHERE id = :id`;
        const result = await connection.execute(sql, { name, id }, { autoCommit: true });
        console.log("Row updated:", result.rowsAffected);
    } catch (err) {
        throw err;
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
}
 
async function deleteNameFromDatabase(id) {
    let connection;
    try {
        connection = await oracledb.getConnection(dbConfig);
        const sql = `DELETE FROM users WHERE id = :id`;
        const result = await connection.execute(sql, { id }, { autoCommit: true });
        console.log("Row deleted:", result.rowsAffected);
    } catch (err) {
        throw err;
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
}
 
app.listen(port, () => {
    console.log(`Server running on http://localhost:${port}`);
});
