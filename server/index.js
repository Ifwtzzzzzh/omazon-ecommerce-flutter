// IMPORTS PACKAGES
const express = require('express')
const mongoose = require('mongoose')
const authRouter = require('./routes/auth.js')
const adminRouter = require('./routes/admin.js')

// INITIALIZE
const PORT = 3000
const app = express()
const DB = "mongodb+srv://rahmandanosa:01022005nosa@cluster0.ydidirg.mongodb.net/?retryWrites=true&w=majority"

// MIDDLEWARE
app.use(express.json())
app.use(authRouter)
app.use(adminRouter)

// CREATING AN API
app.get('/', (req, res) => {
    res.json({name: "Nosa Rahmanda"})
})

app.get('/hello-world', (req, res) => {
    res.json({hi: "Hello world"})
})

// CONNECTION
mongoose.connect(DB).then(() => {
    console.log('Connection succesful')
}).catch(e => {
    console.log(e)
})

app.listen(PORT, "0.0.0.0", () => {
    console.log(`Connected at port ${PORT}`)
})