import React,{useState,useEffect} from 'react'
import NavBar from './NavBar'
import { useNavigate } from 'react-router-dom';
import ModalComponent from '../modal';
import { formatDistance } from 'date-fns';
import { toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';

import MessageIcon from '@mui/icons-material/Message';
import MoreHorizIcon from '@mui/icons-material/MoreHoriz';
import FavoriteBorderIcon from '@mui/icons-material/FavoriteBorder';
// import PopupMenuBar from '../modal/popupbar';
export default function Posts() {
    const [posts, setposts] = useState([]);
    const [modalOpen, setmodalOpen] = useState(false);
    
  
    const navigate=useNavigate();
    const getallusers=async()=>{
      try {
        let token=localStorage.getItem("token");
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
          setposts(json)
     
       
      
       } catch (e) {
        toast.error("Some Errors")
       }
    }
    const deletepost=async(id)=>{
        try {
            let token=localStorage.getItem("token");
            console.log(token);
            const response=await fetch("http://localhost:5000/admin/deletepost", {
              method: "POST",
              crossDomain: true,
             
              headers: {
                "Content-Type": "application/json",
                Accept: "application/json",
                "x-auth-token":token
                
              },
              body: JSON.stringify({
                id,
               
              }),
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
    useEffect(() => {
      getallusers()
    
     
    }, [])
  return (
    <div>
        <NavBar/>
        <div className='px-28 mt-5 pt-14'>
      <p className='text-3xl font-semibold '>Posts:</p>
      <div className='items-center flex flex-col '>
      {posts.map((post,index)=>{
        const date = new Date(post['date']);
        const formattedTime = formatDistance(date, new Date(), { addSuffix: true });
        return <div className="max-w-sm rounded overflow-hidden shadow-lg p-5 bg-white items-center m-3" key={index}>
            <div className='flex items-center justify-between'>

            
        <div className='flex items-center'>
        <img src="https://images.unsplash.com/photo-1610088441520-4352457e7095?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fG1lbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60" 
                      alt="" className='h-8 w-8 rounded-full  object-cover'/>
                      <p className='text-sm pl-3 font-semibold'>{post["username"]}</p>
                      <p className='text-xs pl-3'>{formattedTime }</p>
        </div>
        {/* <PopupMenuBar/> */}
<MoreHorizIcon className='cursor-pointer' onClick={()=>{
  console.log(post["_id"]);
}}/>
        </div>
        <img src={post['images'][0]} alt="" className='pt-3'/>
        <div className='space-x-3 mt-3'>
            <FavoriteBorderIcon/>
            <MessageIcon/>
        </div>
        <p className='text-sm pt-2 font-semibold'>{post["likes"].length} likes</p>
        <p className='text-sm  font-normal'><span className='text-sm  font-semibold'>{post['username'].toLowerCase()}</span> {post['title']}</p>
        <p className='text-sm text-gray-400 font-normal'>{post["comment"].length} comment</p>
        </div>
    })}
      </div>
      </div>
    </div>
  )
}
