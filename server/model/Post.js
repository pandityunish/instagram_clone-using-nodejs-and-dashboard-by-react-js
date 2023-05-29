const mongoose=require("mongoose");
const comment = require("./Comment");

const postSchema=mongoose.Schema({
    title:{
        type:String,

    },
    username:{
        type:String,
        required:true,
    },
    userimage:{
        type:String,
        required:true,
    },
    userid:{
     type:String,
     required:true
    },
    useremail:{
        type:String,
        required:true
       },
    likes:[
        {
            type: String,
           
          },
    ],
    images:[
        {
            type: String,
            
          },

    ],
    video:{
        type:String,
        
    },
    date: {
        type: Date,
        required: true,
      },
      comment:[comment]
});
const Posts=mongoose.model("Posts",postSchema);
module.exports=Posts;