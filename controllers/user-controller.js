const userService = require('../service/user-service')
const {validationResult} = require('express-validator')
const config = require('config')
const ApiError = require('../exceptions/api-error')

class UserController {
    async signUp(req, res, next) {
        try {
            const errors = validationResult(req)
            if (!errors.isEmpty()) {
                return next(ApiError.BadRequest('Ошибка при валидации', errors.array()))
            }
            const {email, password, username} = req.body
            const userData = await userService.signUp(email, password, username)
            res.cookie('refreshToken', userData.refreshToken, {maxAge: 30 * 24 * 60 * 60 * 1000, httpOnly: true})
            return res.json(userData)
        } catch (e) {
            next(e)
        }
    }

    async signIn(req, res, next) {
        try {
            const {email, password} = req.body
            const userData = await userService.signIn(email, password)
            res.cookie('refreshToken', userData.refreshToken, {maxAge: 30 * 24 * 60 * 60 * 1000, httpOnly: true})
            return res.json(userData)
        } catch (e) {
            next(e)
        }
    }

    async logout(req, res, next) {
        try {
            const {refreshToken} = req.cookies
            const token = await userService.logout(refreshToken)
            res.clearCookie('refreshToken')
            return res.json(token)
        } catch (e) {
            next(e)
        }
    }

    async activate(req, res, next) {
        try {
            const activationLink = req.params.link
            await userService.activate(activationLink)
            return res.redirect(config.get('client_url'))
        } catch (e) {
            next(e)
        }
    }

    async refresh(req, res, next) {
        try {
            const {refreshToken} = req.cookies
            const userData = await userService.refresh(refreshToken)
            res.cookie('refreshToken', userData.refreshToken, {maxAge: 30 * 24 * 60 * 60 * 1000, httpOnly: true})
            return res.json(userData)
        } catch (e) {
            next(e)
        }
    }

    async getUserById(req, res, next) {
        try { 
            const {id} = req.params 
            const userData = await userService.getUserById(id)
            return res.status(200).json(userData)
        } catch(e) {
            next(e) 
        }
    }

    async followUser(req, res, next) {
        try {

        } catch(e) {
            next(e)
        }
    }
}


module.exports = new UserController() 
