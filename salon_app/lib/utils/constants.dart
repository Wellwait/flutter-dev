String BASE_URL = "http://localhost:5000";


// app.get('/booking/:panelId/:scheduled_date', (req, res) => {
// // Extract panelId and scheduled_date from URL parameters
// const { panelId, scheduled_date } = req.params;
//
// // Construct the SQL query
// const sqlQuery = `
// SELECT
// b.id,
// u.username,
// b.scheduled_date,
// s.name AS service_name,  -- Retrieve service name
// b.createdAt,
// b.updatedAt,
// b.panel_id,
// b.service_provider_id,
// b.status,
// b.price
// FROM
// Booking b
// JOIN
// User u ON b.userId = u.id
// JOIN
// Services s ON b.serviceId = s.id
// WHERE
// b.scheduled_date = ?
// AND b.panel_id = ?
// ORDER BY
// b.id ASC;
// `;
//
// // Execute the query with the provided parameters
// pool.query(sqlQuery, [scheduled_date, panelId], (error, results) => {
// if (error) {
// return res.status(500).json({ error: error.message });
// }
// res.json(results);  // Send the results as JSON
// });
// });