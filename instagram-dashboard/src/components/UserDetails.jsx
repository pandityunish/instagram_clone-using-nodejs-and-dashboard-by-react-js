import React,{useState,useEffect} from 'react'
import NavBar from './NavBar'
import { useLocation } from 'react-router-dom'
import { formatDistance } from 'date-fns';
import MessageIcon from '@mui/icons-material/Message';
import MoreHorizIcon from '@mui/icons-material/MoreHoriz';
import FavoriteBorderIcon from '@mui/icons-material/FavoriteBorder';
import ModalComponent from '../modal';
export default function UserDetails() {
    const locaion=useLocation();
    const [modalOpen, setmodalOpen] = useState(false)
    const [userposts, setuserposts] = useState([]);
    const getuserdata=async()=>{
        try {
           
            const response=await fetch("http://localhost:5000/getuserposts", {
              method: "POST",
              crossDomain: true,
             
              headers: {
                "Content-Type": "application/json",
                Accept: "application/json",
                
                
              },
              body: JSON.stringify({
                userid:locaion.state.id,
               
              }),
            });
            if (!response.ok) {
              throw new Error(`HTTP error! status: ${response.status}`);
            }
            const json = await response.json()
              
             setuserposts(json);
           console.log(json);
          
           } catch (e) {
            toast.error("Some Errors")
           }
    }

    useEffect(() => {
        getuserdata()
    
      
    }, [])
    
  return (
    <div>
        <NavBar/>
        <div className='px-28 mt-5 pt-14'>
        <div className="bg-white shadow-md rounded-md p-6 flex flex-col md:flex-row md:items-center md:justify-between">
      <div className="flex items-center mb-6 md:mb-0">
        <img
          src={locaion.state.image===""?'https://res.cloudinary.com/dsqtxanz6/image/upload/v1682761190/zu41cdfdrp95xzvq9o6o.png':locaion.state.image}
          alt="Profile"
          className="w-20 h-20 rounded-full object-cover border-2 border-gray-300"
        />
        <div className="ml-6">
          <h2 className="text-2xl font-semibold">{locaion.state.name}</h2>
          <p className="text-gray-600">{locaion.state.email}</p>
         
        </div>
      </div>
      <div className="flex items-center">
        <div className="text-center">
          <p className="text-2xl font-semibold">{locaion.state.followers}</p>
          <p className="text-gray-600">Followers</p>
        </div>
        <div className="text-center mx-8">
          <p className="text-2xl font-semibold">{userposts.length}</p>
          <p className="text-gray-600">Posts</p>
        </div>
        <div className="text-center">
          <p className="text-2xl font-semibold">{locaion.state.following}</p>
          <p className="text-gray-600">Following</p>
        </div>
      </div>
    </div>
    <div className='items-center flex flex-col '>

   
    {userposts.map((post,index)=>{
        const date = new Date(post['date']);
        const formattedTime = formatDistance(date, new Date(), { addSuffix: true });
        return <div className="max-w-sm rounded overflow-hidden shadow-lg p-5 bg-white items-center m-3">
            <div className='flex items-center justify-between'>

            
        <div className='flex items-center'>
        <img src="https://images.unsplash.com/photo-1610088441520-4352457e7095?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fG1lbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60" 
                      alt="" className='h-8 w-8 rounded-full  object-cover'/>
                      <p className='text-sm pl-3 font-semibold'>{locaion.state.name}</p>
                      <p className='text-xs pl-3'>{formattedTime }</p>
        </div>
        <ModalComponent modalOpen={modalOpen} setModalOpen={setmodalOpen}/>
<MoreHorizIcon className='cursor-pointer' onClick={()=>{
  setmodalOpen(true);
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





