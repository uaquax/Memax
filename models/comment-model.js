const {Schema, model} = require('mongoose')

const CommentSchema = new Schema({
    fatherId: {type: String, required: true},
    author: {type: String, required: true},
    body: {type: String, required: true},
    likes: {type: Array, default: []},
    comments: {type: Array, default: []}, 
    picture: {type: String, required: false}
}) 

module.exports = model('Comment', CommentSchema) 