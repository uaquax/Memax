const postService = require('../service/post-service')

class PostController {
    
    async createPost(req, res, next) { 
		try {
			const {title, description} = req.body

			const {picture} = req.files

			const post = await postService.createPost(req.user.id, title, description, picture)

			return res.status(200).json(post)
		} catch(e) {
			next(e)  
		}
	}

    async addView(req, res, next) {
        try {
            const {id} = req.body
            
            await postService.addView(id, req.user.id)
        } catch(e) {
            next(e)
        }
    }

    async changeLikeStatus(req, res, next) {
        try {
            const {id} = req.body 

            console.log(id)

            await postService.changeLikeStatus(id, req.user.id)
        } catch(e) {
            next(e)
        }
    }

    async getPosts(req, res, next) {
        try {
            const {page, limit} = req.query
            const posts = await postService.getPosts(page, limit)
            return res.json(posts)
        } catch(e) { 
            next(e)
        } 
    }

    async createComment(req, res, next) {
        try {
            const {body, fatherId} = req.body 
            const {picture} = req.files | null

            const id = await postService.createComment(fatherId, req.user.id, body, picture)

            return res.status(200).json(id)
        } catch(e) {
            next(e)
        }
    }

    async getComment(req, res, next) {
        try {
            const {id} = req.params

            const comment = await postService.getComment(id)

            return res.status(200).json(comment)
        } catch(e) {
            next(e)
        }
    }

    async getUserPosts(req, res, next) {
        try {
            const {id} = req.params
            const {page, limit} = req.query

            const posts = await postService.getPosts(page, limit, {author: id})

            return res.status(200).json(posts)
        } catch(e) {
            next(e)
        }
    }
}

module.exports = new PostController()