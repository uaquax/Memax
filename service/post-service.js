const PostModel = require('../models/post-model')
const CommentModel = require('../models/comment-model')
const PostDto = require('../dtos/post-dto')
const CommentDto = require('../dtos/comment-dto')
const fileService = require('./file-service')

class PostService {

    async createPost(author, title, description, picture) {

        const creationDate = new Date().toISOString().slice(0, 10)

        const pictureWay = fileService.saveFile(picture)

        const post = await PostModel.create({
            author, title, description, picture: pictureWay, creationDate
        })

        const postDto = new PostDto(post)

        return {
            post: postDto
        }
    }

    async addView(postId, userId) {
        const post = await PostModel.findById(postId) 

        if(!post.views.includes(userId)) {
            post.views.push(userId)
            await post.save()
        }
    }

    async changeLikeStatus(postId, userId) {
        const post = await PostModel.findById(postId)

        if(post.likes.includes(userId)) {
            post.likes.remove(userId)
        } else {
            post.likes.push(userId)
        }

        return post.save()
    }

    async getPosts(page, limit, author = {}){
        const postsFromDb = await PostModel.paginate(author, {page, limit})
        const posts = []
    
        await Promise.all(postsFromDb.docs.map( async (post) => {
            const postDto = new PostDto(post) 
    
            posts.push(postDto)
        }))

        return {
            ...postsFromDb,
            posts
        } 
    }

    async createComment(fatherId, author, body, picture = null) {
        const comment = await CommentModel.create({
            fatherId, 
            author, 
            body,
            picture: picture && picture
        })
 
        const father = await PostModel.findById(fatherId) || await CommentModel.findById(fatherId)

        father.comments.push(comment._id)

        await father.save()

        return comment._id
    }

    async getComment(id) {
        const comment = await CommentModel.findById(id)

        const commentDto = new CommentDto(comment)

        return commentDto
    }
}

module.exports = new PostService()