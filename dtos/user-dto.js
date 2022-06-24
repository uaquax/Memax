const config = require('config')

module.exports = class UserDto {
	email
	id
	isActivated
	username
	avatar 
	followers
	biography
	creationDate
	hashtags

	constructor(model) {
		this.email = model.email 
		this.id = model._id 
		this.isActivated = model.isActivated
		this.username = model.username
		this.avatar = `${config.get('api_url')}/${model.avatar}`
		this.followers = model.followers
		this.biography = model.biography
		this.creationDate = model.creationDate
		this.hashtags = model.hashtags
	}
}