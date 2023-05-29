const express=require("express");
const mongoose=require("mongoose");
const authrouter = require("./router/auth");
const postRoute = require("./router/post");
const adminrouter = require("./router/admin");
const cors = require("cors");
const storiesRouter = require("./router/stories");

const app=express();
const PORT=5000;
app.use(express.json());
app.use(cors());
app.use(authrouter);
app.use(postRoute);
app.use(storiesRouter);
app.use(adminrouter);

 let db="mongodb+srv://yunishpandit:yunish1234@cluster0.gpbcphl.mongodb.net/?retryWrites=true&w=majority";

mongoose.set('strictQuery', false);
mongoose.connect(db).then(()=>{
    console.log("Conected successfully")
}).catch((e)=>{
    console.log(e);
});
app.listen(PORT,"0.0.0.0",()=>{
    console.log("Connected to "+PORT);
})
