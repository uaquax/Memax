const config = require('config')
const express = require('express')
const cors = require('cors')
const cookieParser = require('cookie-parser')
const mongoose = require('mongoose')
const router = require('./router/index')
const fileUpload = require('express-fileupload')
const errorMiddleware = require('./middlewares/error-middleware')
const path = require('path')

const PORT = config.get('port')
const DB_URL = config.get('db_url')
const app = express()


app.use(express.static(path.join(__dirname, '/static')))
app.use(fileUpload())
app.use(express.json())
app.use(cookieParser())
app.use(cors({ 
    credentials: true,
    origin: config.get('client_url')
}))
app.use('/api', router)
app.use(errorMiddleware)

const start = async () => {
    try {
        await mongoose.connect(DB_URL, {
            useNewUrlParser: true,
            useUnifiedTopology: true
        })
        app.listen(PORT, () => console.log(`App has been started on port ${PORT}`))
    } catch (e) {
        console.log(e)
    }
}

start()
