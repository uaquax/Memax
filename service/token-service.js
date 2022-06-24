const jwt = require('jsonwebtoken')
const tokenModel = require('../models/token-model')
const config = require('config')

class TokenService {
    generateTokens(payload) {
        const accessToken = jwt.sign(payload, config.get('jwt_access_secret'), {expiresIn: '15m'})
        const refreshToken = jwt.sign(payload, config.get('jwt_refresh_secret'), {expiresIn: '30d'})
        return {
            accessToken,
            refreshToken
        }
    }

    validateAccessToken(token) {
        try {
            const userData = jwt.verify(token, config.get('jwt_access_secret'))
            return userData
        } catch (e) { 
            return null
        }
    }

    validateRefreshToken(token) {
        try {
            const userData = jwt.verify(token, config.get('jwt_refresh_secret'))
            return userData
        } catch (e) {
            return null
        }
    }

    async saveToken(userId, refreshToken) {
        const tokenData = await tokenModel.findOne({user: userId})
        if (tokenData) {
            tokenData.refreshToken = refreshToken
            return tokenData.save()
        }
        const token = await tokenModel.create({user: userId, refreshToken})
        return token
    }

    async removeToken(refreshToken) {
        const tokenData = await tokenModel.deleteOne({refreshToken})
        return tokenData
    }

    async findToken(refreshToken) {
        const tokenData = await tokenModel.findOne({refreshToken})
        return tokenData
    }
}

module.exports = new TokenService()
