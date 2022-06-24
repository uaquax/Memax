const {Schema, model} = require('mongoose')

const UserSchema = new Schema({
	email: {type: String, unique: true, required: true},
	password: {type: String, required: true},
	username: {type: String, required: true},
	avatar: {type: String, default: 'default.jpg'},
	biography: {type: String, default: null},
	creationDate: {type: String, default: Date.now()},
	followers: {type: Array, default: []},
	isActivated: {type: Boolean, default: false},
	activationLink: {type: String}
})

module.exports = model('User', UserSchema)