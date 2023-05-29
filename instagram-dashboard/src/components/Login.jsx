import React,{useState,useEffect} from 'react'
import { toast } from 'react-toastify';
import {useNavigate} from 'react-router-dom'
import 'react-toastify/dist/ReactToastify.css';
export default function Login() {
  const navigate=useNavigate();
  let token=localStorage.getItem("token");
  const [showPassword, setShowPassword] = useState(false);
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const togglePasswordVisibility = () => {
    setShowPassword(!showPassword);
  }
  useEffect(() => {
    if(token!==null){
      navigate("/home")
    }
  
   
  }, [])
  

async function handleSubmit (e) {
  
  e.preventDefault();

  console.log(email, password);
 try {
  const response=await fetch("http://localhost:5000/admin/login", {
    method: "POST",
    crossDomain: true,
   
    headers: {
      "Content-Type": "application/json",
      Accept: "application/json",
      
    },
    body: JSON.stringify({
      email,
      password,
    }),
  });
  if (!response.ok) {
    throw new Error(`HTTP error! status: ${response.status}`);
  }
  const json = await response.json()
 
    console.log(json.token);
    localStorage.setItem("token",json.token)
navigate("/home");
    toast.success("Login Successfull");

 } catch (e) {
  toast.error("Some Errors")
 }
}

  return (
    <div>
  <form onSubmit={handleSubmit}>
    <div className='m-auto w-[40%] mt-32 flex justify-center flex-col items-center'>
      <h1 className='text-2xl font-bold'>Login Into Your Account </h1>
        <input type="text" placeholder='Enter your email' id="email" name="email"
         onChange={(e)=>setEmail(e.target.value)} 
        className='w-[50%] h-14 border border-gray-400 rounded-lg p-4 mt-7'/>
        <div className='relative flex items-center w-[50%]'>
          <p className='absolute z-10 right-3 top-7 cursor-pointer'
           onClick={togglePasswordVisibility}>{showPassword? "Hide":"Show"}</p>
        <input type={showPassword?"text": "password"} id="password" name="password"
         onChange={(e)=>setPassword(e.target.value)}  placeholder='Enter your password' className='w-[100%] h-14 border border-gray-400 rounded-lg p-4 mt-3'/>
        </div>
        <button className='h-12 w-[50%] bg-blue-500 text-white rounded-lg mt-4' >
            Login
        </button>
    </div>
    </form>
    </div>
    
  )
}
