const mongoose=require("mongoose");

const comment=mongoose.Schema({
    username:{
        type:String,
        required:true
    },
    userimage:{
        type:String,
        required:true
    },
    userid:{
    type:String,
    required:true
    },
    title:{
        type:String,
        required:true
    },
    
    
});
module.exports=comment;