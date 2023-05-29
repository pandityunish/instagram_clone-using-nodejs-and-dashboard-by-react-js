const express=require("express");
const User = require("../model/User");
const bycript=require("bcryptjs")
const authrouter=express.Router();

authrouter.post("/createuser",async(req,res)=>{
    try {
        const {email,name,password,image,followers,following}=req.body;
        let existinguser=await User.findOne({email});
        if(existinguser){
         return res.statusCode(400).json({mes:"User already exist"})
        }
        const salt=await bycript.genSalt(10);
        const secpassword=await bycript.hash(password,salt);
        let user=User({
            email:email,name:name,
            password:secpassword,
            image:image,
            followers:followers,
            following:following
        });
       user=await user.save();
       res.json(user);
    } catch (e) {
        res.status(401).json({mes:e.message})
    }
});
authrouter.post("/loginuser",async(req,res)=>{
    try {
        const {email,password}=req.body;
        let user=await User.findOne({email});
        if (!user) {
            return res
              .status(400)
              .json({mes: "Please try to login with valid credentials" });
          }
          const passowrdcompare=await bycript.compare(password,user.password);
          if (!passowrdcompare) {
            return res
              .status(400)
              .json({ mes: "Please try to login with valid credentials" });
          }
          res.json(user);
    } catch (e) {
        res.status(401).json({mes:e.message})
    }
});

authrouter.post("/getuserdata",async(req,res)=>{
    try {
        const {email}=req.body;
        let user=await User.findOne({email});
        res.json(user);
    } catch (e) {
        res.status(401).json({mes:e.message})
    }
});
authrouter.post("/updateuserprofile",async(req,res)=>{
    try {
        const {userid,userimage}=req.body;
        let user=await User.findByIdAndUpdate({
            "_id":userid
        },{
           "image":userimage
        });
    user=await user.save();
    res.json(user);
    } catch (e) {
        res.status(401).json({mes:e.message})
    }
});
authrouter.post("/removeuserprofile",async(req,res)=>{
    try {
        const {userid}=req.body;
        let user=await User.findByIdAndUpdate({
            "_id":userid
        },{
           "image":""
        });
    user=await user.save();
    res.json(user);
    } catch (e) {
        res.status(401).json({mes:e.message})
    }
});
authrouter.post("/follow",async(req,res)=>{
    try {
        const {followid,userid}=req.body;
        let user=await User.findOneAndUpdate(
            {
             "_id": userid
            },{
            $addToSet:{
                following:followid
            }
        });
        let user1=await User.findOneAndUpdate(
            {
             "_id": followid
            },{
            $addToSet:{
                followers:userid
            }
        });
        user=await  user.save();
        user1=await user1.save();
         res.json(user);
        } catch (e) {
        res.status(401).json({mes:e.message})
    }
});
authrouter.post("/unfollow",async(req,res)=>{
    try {
        const {followid,userid}=req.body;
        let user=await User.findOneAndUpdate(
            {
             "_id": userid
            },{
            $pull:{
                following:followid
            }
        });
        let user1=await User.findOneAndUpdate(
            {
             "_id": followid
            },{
            $pull:{
                followers:userid
            }
        });
        user=await  user.save();
        user1=await user1.save();
         res.json(user);
        } catch (e) {
        res.status(401).json({mes:e.message})
    }
});
authrouter.get("/getalluser",async(req,res)=>{
    try {
        let users=await User.find({});
        res.json(users);
    } catch (e) {
        res.status(401).json({mes:e.message})
    }
})
module.exports=authrouter;