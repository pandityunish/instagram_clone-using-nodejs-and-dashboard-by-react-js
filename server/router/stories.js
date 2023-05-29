const express=require("express");
const Stories = require("../model/Stories");

const storiesRouter=express.Router();

storiesRouter.post("/poststories",async(req,res)=>{
    try {
        const {userid,userimage,username,images,useremail}=req.body;

        let stories=await Stories({
            username,useremail,userimage,images,userid
        });
        stories=await stories.save();
        res.json(stories);
    } catch (e) {
        res.status(401).json({mes:e.message});
    }
});

storiesRouter.get("/getallstories",async(req,res)=>{
    try {
        let stories=await Stories.find({});
        res.json(stories);
    } catch (e) {
        res.status(401).json({mes:e.message})
    }
})


module.exports=storiesRouter;

