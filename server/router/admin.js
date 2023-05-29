const express=require("express");
const Admin = require("../model/Admin");
const jwt = require("jsonwebtoken");
const bycript=require("bcryptjs");
const auth = require("../middleware/adminmiddleware");
const User = require("../model/User");
const Posts = require("../model/Post");

const adminrouter=express.Router();


adminrouter.post("/admin/createadmin",async(req,res)=>{
    try {
        const {name,email,password}=req.body;
        let existinguser=await Admin.findOne({email});
        if(existinguser){
            return res.statusCode(400).json({mes:"User already exist"})
           }
           const salt=await bycript.genSalt(10);
           const secpassword=await bycript.hash(password,salt);
           let user=Admin({
               email:email,name:name,
               password:secpassword,
              
           });
          user=await user.save();
          res.json(user);
    } catch (e) {
        res.status(401).json({mes:e.message})
    }
});
adminrouter.post("/admin/login",async(req,res)=>{
    try {
        const { email, password } = req.body;

        const user = await Admin.findOne({ email });
        if (!user) {
          return res
            .status(400)
            .json({ msg: "User with this email does not exist!" });
        }
    
        const isMatch = await bycript.compare(password, user.password);
        if (!isMatch) {
          return res.status(400).json({ msg: "Incorrect password." });
        }
    
        const token = jwt.sign({ id: user._id }, "passwordKey");
        res.json({ token, ...user._doc });
    } catch (e) {
        res.status(401).json({mes:e.message}) 
    }
});

adminrouter.post("/admin/getuserdata",auth,async(req,res)=>{
    try {
        const {email}=req.body;
        let user=await Admin.findOne({email});
        res.json(user);
    } catch (e) {
        res.status(401).json({mes:e.message}) 
    }
});
adminrouter.get("/admin/allusers",auth,async(req,res)=>{
    try {
        let users=await User.find({});
        res.json(users);
    } catch (e) {
        
    }
});
adminrouter.post('/admin/deletepost',auth,async(req,res)=>{
    try {
        const {postid}=req.body;
      let post=await Posts.findByIdAndDelete({_id:postid});
     
      post=await post.save();
      res.json(post);
    } catch (e) {
        res.status(401).json({mes:e.message}) 
    }
})

module.exports=adminrouter;