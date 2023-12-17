// Import packages
const express = require("express")
const auth = require("../middlewares/auth")
const User = require("../models/user")
const { Product } = require("../models/product")
const userRouter = express.Router()

// Adds an item to the user's shopping cart (requires authentication)
userRouter.post("/api/add-to-cart", auth, async (req, res) => {
    // Add product to user's cart, increment quantity if already exists
    try {
        // Extract product ID from request body and fetch both product and user
        const {id} = req.body
        const product = await Product.findById(id)
        let user = await User.findById(req.user)

        // Add product to cart if empty, setting quantity to 1.
        if (user.cart.length == 0) {
            user.cart.push({product, quantity: 1})
        } else {
            // Check if a product exists in the user's cart using its ID
            let isProductFound = false
            for (let i = 0; i < user.cart.length; i++) {
                if (user.cart[i].product._id.equals(product._id)) {
                    isProductFound = true
                }
            }

            // Increase quantity of product in user cart if already exists
            if (isProductFound) {
                let producttt = user.cart.find((productt) => 
                    productt.product._id.equals(product._id)
                )
                producttt.quantity += 1
            } else { // Adds product to user's cart with quantity 1 unless cart is empty.
                user.cart.push({product, quantity: 1})
            }
        }
        // Saves the user and returns it in the response.
        user = await user.save()
        res.json(user)
    } catch (e) { // Used to handle any errors that occur within the `try` block.
        res.status(500).json({error: e.message})
    }
})

// Removes product from user cart 
userRouter.delete("/api/remove-from-cart/:id", auth, async (req, res) => {
    // Removes product from user cart, updating quantity if not removing entirely.
    try {
        // Extract product by ID, then fetch user from request, possibly for authorization or personalization.
        const {id} = req.params
        const product = await Product.findById(id)
        let user = await User.findById(req.user)

        // Remove or decrease one product from user cart
        for (let i = 0; i < user.cart.length; i++) {
            if (user.cart[i].product._id.equals(product._id)) {
                if (user.cart[i].quantity == 1) {
                    user.cart.splice(i, 1)
                } else {
                    user.cart[i].quantity -= 1
                }
            }
        }
        // Saves the user and returns it in the response.
        user = await user.save()
        res.json(user)
    } catch (e) { // Used to handle any errors that occur within the `try` block.
        res.status(500).json({error: e.message})
    }
})

// Exports userRouter
module.exports = userRouter