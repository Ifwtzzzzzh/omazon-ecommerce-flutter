/* Importing the necessary dependencies and modules for the product router. */
const express = require("express")
const auth = require("../middlewares/auth")
const {Product} = require("../models/product")
const productRouter = express.Router()

/* Defines a GET route for retrieving products from the server. */
productRouter.get('/api/products/', auth, async (req, res) => {
    /* Uses the`Product` model to find products that match the specified category. */
    try {
        const products = await Product.find({category: req.query.category})
        res.json(products)
    } /* Used to handle any errors that occur within the `try` block. */
    catch (e) {
        res.status(500).json({error: e.message})
    }
})

/* Defining a route for searching products by name. */
productRouter.get('/api/products/search/:name', auth, async (req, res) => {
    /* Performing a search for products by name using regular expressions. */
    try {
        const products = await Product.find({
            name: {$regex: req.params.name, $options: "i"},
        })
        res.json(products)
    } /* Used to handle any errors that occur within the `try` block. */
    catch (e) {
        res.status(500).json({error: e.message})
    }
})

/* For rating a product. */
productRouter.post('/api/rate-product', auth, async (req, res) => {
    /* Responsible for rating a product. */
    try {
        /* `Allows you to directly access these properties without havingto use `req.body.id` and `req.body.rating`. */
        const {id, rating} = req.body
        let product = await Product.findById(id)

        /* Essentially removing any existing rating by the current user for the specified product before adding a new rating. */
        for (let i = 0; i < product.ratings.length; i++) {
            if (product.ratings[i].userId == req.user) {
                product.ratings.splice(i, 1)
                break
            }
        }

        /* Object has two properties: `userId` and `rating`. */
        const ratingSchema = {
            userId: req.user,
            rating,
        }

        /* Adding a new rating to the `ratings` array
        of the `product` object. */
        product.ratings.push(ratingSchema)
        product = await product.save()
        res.json(products)
    } catch (e) { /* Used to handle any errors that occur within the `try` block. */
        res.status(500).json({error: e.message})
    }
})

// This API endpoint fetches all products and returns the one with the highest average rating as the "deal of the day".
productRouter.get('/api/deal-of-day', auth, async (req, res) => {
    try {
        let products = await Product.find({})
        
        // Sort the products by average rating in descending order
        products.sort((a, b) => {
            let aSum = 0;
            let bSum = 0;

            for (let i = 0; i < a.ratings.length; i++) {
                aSum += a.ratings[i].rating;
            }

            for (let i = 0; i < b.ratings.length; i++) {
                bSum += b.ratings[i].rating;
            }
            return aSum < bSum ? 1 : -1
        })
        // Return the product with the highest average rating
        res.json(products[0])
    } catch (e) {
        res.status(500).json({error: e.message})
    }
})

/* This allows other files to import and use the `productRouter` object. */
module.exports = productRouter