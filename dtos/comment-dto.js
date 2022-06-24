const config = require('config')

module.exports = class CommentDto {
    id
    fatherId
    author
    body
    likes
    comments
    picture 

    constructor(model) {
        this.id = model.id
        this.fatherId = model.postId
        this.author = model.author
        this.body = model.body
        this.likes = model.likes
        this.comments = model.comments
        this.picture = model.picture && `${config.get('api_url')}/${model.picture}`
    }
}