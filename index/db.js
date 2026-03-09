const mysql = require ("mysql2/promise")

const pool = mysql.createPool({
    host: "localhost", user:"root", password: "5ZbiEudpP,743DnY",
    waitForConnections: true, connectionLimit: 10,
    queueLimit: 0
});

async function testConnection(){
    try{
const connection = await pool.getConnection();
console.log("Base de données connectée");
connection.release();
} catch (error) {
    console.error("Erreur connexion DB :", error.message);
}}
testConnection();
module.export = pool;