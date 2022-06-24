const {Schema, model} = require('mongoose')
const mongoosePaginate = require('mongoose-paginate-v2')

const PostSchema = new Schema({
    author: {type: String, required: true},
    title: {type: String, required: true},
    description: {type: String, required: true},
    comments: {type: Array, default: []},
    views: {type: Array, default: []},
    reactions: {type: Array, default: []},
    rewards: {type: Array, default: []},
    likes: {type: Array, default: []},
    picture: {type: String, required: true},
    creationDate: {type: String, default: Date.now},
    hashtags: {type: [], default: []}
}) 

PostSchema.plugin(mongoosePaginate)

module.exports = model('Post', PostSchema)