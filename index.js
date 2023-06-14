/**START: Import dependencies */
const express = require("express");
const bodyParser = require("body-parser");
const mysql = require("mysql");
/**END: Import dependencies */

/**START: Declare necessary variables */
const app = express();
const port = 3000;
const connectionAttemptDelay = 2000;
const db_name = process.env.MYSQL_DATABASE;
const table_name = process.env.MYSQL_TABLE;
const db_username = process.env.MYSQL_USER;
const db_password = process.env.MYSQL_PASSWORD;
const db_service_uri = process.env.MYSQL_DB_HOST;
const jsonParser = bodyParser.json();
/**END: Declare necessary variables */

/**START: Initiate MySQL DB Connection */
const createConnection = () =>
  mysql.createConnection({
    host: db_service_uri,
    user: db_username,
    password: db_password,
    database: db_name,
  });

const openConnection = (con) => {
  return new Promise((resolve, reject) => {
    con.connect((err) => {
      if (err) reject(err);
      else resolve();
    });
  });
};

/**END: Initiate MySQL DB Connection */

/**START: DB Connection */
const initiateConnection = (attempts, connection) => {
  // Initiate a connection once for one connection attempts cycle
  const con = connection || createConnection();
  return new Promise((resolve) => {
    openConnection(con).then(
      () => {
        console.log(`DB Connection ready, remaining attempts: ${attempts}`);
        resolve(con);
      },
      (err) => {
        console.log(`DB connection error, remaining attempt:${attempts}`);
        if (attempts === 0) {
          console.log(err);
          reject(err);
        }
        // Attempt a retry if remaining attempts.
        if (attempts >= 1)
          setTimeout(
            () => initiateConnection(attempts - 1, con),
            connectionAttemptDelay
          );
      }
    );
  });
};

/**END: DB Connection */

/**START: Set API Level config/response headers */
app.listen(port, (err) => {
  if (err) return console.log(`Error : ${err}`);
  console.log(`server running on ${port}`);
});

app.options("*", (req, res) => {
  res.setHeader("Content-Type", "application/json");
});

app.use((req, res, next) => {
  res.setHeader("Content-Type", "application/json");
  next();
});
/**END: Set API Level config/response headers */

/**
 * HttpGET For POD Health check
 * Use by readiness probe for Rolling update
 */
app.get("/", (req, res) => {
  res.send({ status: "READY", message: "Hello There! Have a nice day." });
});

/**
 * Http GET API to fetch movies from the DB
 */
app.get("/movies", jsonParser, async (req, res) => {
  let result;
  let err;
  result = await getMovies().catch((ex) => {
    err = "Error occured while procesing your request!";
  });
  res.send({
    result: result || null,
    status: err ? "ERROR" : "SUCCESS",
    error: err || null,
  });
});

/**
 * Retrieves all the movies from the movies table
 * @returns Promise that resolves to an array of movies
 */
function getMovies() {
  return new Promise(async (resolve, reject) => {
    // Start a DB connection
    const con = await initiateConnection(2).catch(() => {
      reject("Unable to process request");
    });
    if (con) {
      con.query(`SELECT * FROM ${table_name}`, (err, result) => {
        if (err) {
          reject(err);
        } else {
          resolve(result);
        }
        // Destroy the connection when done processing to avoid any side effects
        con.end();
      });
    }
  });
}
