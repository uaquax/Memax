const config = require('config')

module.exports = class PostDto {
    author
    title
    description
    comments
    views
    likes
    picture
    id

	constructor(model) {
        this.author = model.author
        this.title = model.title
        this.description = model.description
        this.comments = model.comments
        this.views = model.views
        this.likes = model.likes
        this.picture = `${config.get('api_url')}/${model.picture}`
        this.id = model.id 
	}
}