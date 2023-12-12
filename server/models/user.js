// Import packages
const mongoose = require('mongoose')
const { productSchema } = require('./product')

// Defining Mongoose schema for a user
const userSchema = mongoose.Schema({
    // Required string field with whitespace trimmed.
    name: {
        require: true,
        type: String,
        trim: true,
    },
    // Validates and trims email address using regular expression
    email: {
        require: true,
        type: String,
        trim: true,
        validate: {
            validator: (value) => {
                const re = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i
                return value.match(re)
            },
            message: "Please enter a valid email addres",
        },
    },
    // Minimum password length of 6 characters is required.
    password: {
        required: true,
        type: String,
        validate: {
            validator: (value) => {
                return value.length > 6
            },
            message: "Please enter a long password",
        },
    },
    // String address field with empty string as default.
    address: {
        type: String,
        default: '',
    },
    // String address field with empty string as default.
    type: {
        type: String,
        default: 'user',
    },
    // Array of cart items, each containing a product and required quantity.
    cart: [
        {
            product: productSchema,
            quantity: {
                type: Number,
                require: true,
            }
        }
    ],
})

// Export User model
const User = mongoose.model("User", userSchema)
module.exports = User