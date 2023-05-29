const express=require("express");
const Posts = require("../model/Post");

const postRoute=express.Router();

postRoute.post("/post",async(req,res)=>{
try {
    const {username,userimage,title,images,video,likes,userid,comment,useremail}=req.body;
    let post=await Posts({
        title:title,username:username,userimage:userimage,
        likes:likes,images:images,video:video,date:Date.now(),userid:userid,comment:comment,useremail:useremail,
    });
  post=await  post.save();
  res.json(post);
} catch (e) {
    res.status(401).json({mes:e.message});
}
});
postRoute.get("/getposts",async(req,res)=>{
    try {
        let posts=await Posts.find({}).sort({'date':-1});
        res.json(posts);
    } catch (e) {
        res.status(401).json({mes:e.message});
    }
});
postRoute.post("/addlikes",async(req,res)=>{
    try {
        const {postid,userid}=req.body;
        let post=await Posts.findOneAndUpdate(
            {
             "_id": postid
            },{
            $addToSet:{
                likes:userid
            }
        });
       
    post=await  post.save()
         res.json(post);
        } catch (e) {
        res.status(401).json({mes:e.message})
    }
});
postRoute.post("/addcomment",async(req,res)=>{
    try {
        const {username,userimage,title,postid,userid}=req.body;
        let post=await Posts.findOneAndUpdate({
            "_id":postid
        },
        
      {
        $push:{
            comment:{
                "username":username,
                "userimage":userimage,
                "title":title,
                "userid":userid
            }
        }
        });
        post=await post.save();
        res.json(post);
    } catch (e) {
        res.status(401).json({mes:e.message})
    }
});
postRoute.post("/removelikes",async(req,res)=>{
    try {
        const {postid,userid}=req.body;
        let post=await Posts.findOneAndUpdate({
            "_id":postid
        },
        {
            $pull:{
                likes:userid
            }
        }
        );
        post=await post.save();
        res.json(post);
    } catch (e) {
        res.status(401).json({mes:e.message})
    }
});
postRoute.post("/getuserposts",async(req,res)=>{
    try {
        const {userid}=req.body;
        let post=(await Posts.find({userid:userid}));
        res.json(post);
    } catch (e) {
        res.status(401).json({mes:e.message}) 
    }
})
module.exports=postRoute;