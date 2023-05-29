import React from 'react'
import { useEffect,useState } from 'react'
import { useNavigate } from 'react-router-dom';

import PermIdentityIcon from '@mui/icons-material/PermIdentity';
import { getallstories } from '../Apis/loginApi';
import NavBar from './NavBar';
export default function Home() {
  
    let token=localStorage.getItem("token");
    const [name, setname] = useState("");
    const [users, setusers] = useState([]);
    const [posts, setposts] = useState([]);
    const [stories, setstories] = useState([])
    const navigate=useNavigate();
    useEffect(() => {
      getuserdata("yunishpandit98@gmail.com")
      getallusers();
      getallposts();
      getallstories(setstories);
      if(token===null){
        navigate("/")
      }
    
     
    }, []);
    const getallusers=async()=>{
      try {
        let token=localStorage.getItem("token");
        const response=await fetch("http://localhost:5000/admin/allusers", {
          method: "GET",
          crossDomain: true,
         
          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
            "x-auth-token":token
            
          },
          
        });
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        const json = await response.json()
          setusers(json)
       
       
      
       } catch (e) {
        toast.error("Some Errors")
       }
    }
    const getuserdata=async(email)=>{
      try {
          let token=localStorage.getItem("token");
          const response=await fetch("http://localhost:5000/admin/getuserdata", {
            method: "POST",
            crossDomain: true,
           
            headers: {
              "Content-Type": "application/json",
              Accept: "application/json",
              "x-auth-token":token
              
            },
            body: JSON.stringify({
              email,
             
            }),
          });
          if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
          }
          const json = await response.json()
            
           setname(json.name);
         
        
         } catch (e) {
          toast.error("Some Errors")
         }
  }
  const getallposts=async(email)=>{
    try {
      
        const response=await fetch("http://localhost:5000/getposts", {
          method: "GET",
          crossDomain: true,
         
          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
            
            
          },
         
        });
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        const json = await response.json()
          
         setposts(json);
       
      
       } catch (e) {
        toast.error("Some Errors")
       }
}
  return (
   
    <div>
        <NavBar link="Home"/>
        <div className='px-28 py-5 pt-20'>
        <h1 className=' font-semibold text-xl'>Hello,{name}</h1>
        <p className='font-light text-sm'>CEO</p>
        </div>
      <hr className=' border-gray-400'/>
      <div className='flex flex-row justify-between p-10 ml-10'>
        <div className='bg-white rounded-lg w-[30%] p-10 h-56 cursor-pointer hover:border hover:border-green-600' onClick={()=>{
          navigate("/users");
        }}>
         <p className='text-3xl font-semibold '>Users</p>
         <div className='flex flex-wrap pt-4 gap-3'>
          <p className='font-medium text-base'>Total Users:</p>
          <p>{users.length}</p>
         </div>
        </div>
        <div className='bg-white rounded-lg w-[30%] p-10 h-56 cursor-pointer hover:border hover:border-green-600' onClick={()=>{
          navigate('/posts')
        }}>
        <p className='text-3xl font-semibold '>Posts</p>
         <div className='flex flex-wrap pt-4 gap-3'>
          <p className='font-medium text-base'>Total posts:</p>
          <p>{posts.length}</p>
         </div>
         </div>
         <div className='bg-white rounded-lg w-[30%] p-10 h-56 cursor-pointer hover:border hover:border-green-600'>
         <p className='text-3xl font-semibold '>Stories</p>
         <div className='flex flex-wrap pt-4 gap-3'>
          <p className='font-medium text-base'>Total stories:</p>
          <p>{stories.length}</p>
         </div>
         </div>
      </div>
        </div>
    
  )
}
