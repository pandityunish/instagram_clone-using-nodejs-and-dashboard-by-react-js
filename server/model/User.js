const mongoose=require("mongoose");

const userSchema=mongoose.Schema({
    name:{
        type:String,
        require:true,
        trim:true
    },
    email:{
        type:String,
        require:true,
        validate: {
            validator: (value) => {
              const re =
                /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
              return value.match(re);
            },
            message: "Please enter a valid email address",
          },
    },
    image:{
    type:String,

    },
    followers:[
      {
        type: String,
       
      },
    ],
    following:[
      {
        type: String,
       
      },
    ],
    password:{
        type:String,
        require:true,
        trim:true,

    },
    
});
const User=mongoose.model("Users",userSchema);
module.exports=User;