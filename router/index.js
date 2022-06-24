const Router = require('express').Router
const userController = require('../controllers/user-controller')
const postController = require('../controllers/post-controller')
const router = new Router()
const {body} = require('express-validator')
const authMiddleware = require('../middlewares/auth-middleware')

router.post('/sign-up',
    body('email').isEmail(),
    body('password').isLength({min: 3, max: 32}),
    userController.signUp
)

router.post('/create-comment', authMiddleware, postController.createComment)
router.post('/create-post', authMiddleware, postController.createPost)
router.post('/sign-in', userController.signIn)
router.post('/logout', userController.logout) 
router.post('/add-view', authMiddleware, postController.addView)
router.post('/change-like-status', authMiddleware, postController.changeLikeStatus)
router.get('/comment/:id', authMiddleware, postController.getComment)
router.get('/activate/:link', userController.activate)
router.get('/refresh', userController.refresh)
router.get('/posts', authMiddleware, postController.getPosts)
router.get('/user/:id', authMiddleware, userController.getUserById)
router.get('/posts/user/:id', authMiddleware, postController.getUserPosts)
 
module.exports = router
