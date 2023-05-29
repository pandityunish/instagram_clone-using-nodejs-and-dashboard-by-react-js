const mongoose=require("mongoose");

const storiesSchema=mongoose.Schema({
    username:{
        type:String,
        required:true
    },
    useremail:{
        type:String,
        required:true
    },
    userimage:{
        type:String,
        required:true
    },
    images:[
        {
            type: String,
            
          },
    ],
    userid:{
        type:String,
        required:true
    }
});
const Stories= mongoose.model("Stories",storiesSchema);
module.exports=Stories;