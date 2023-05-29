import React from 'react'
import { useNavigate } from 'react-router-dom';
import GridViewIcon from '@mui/icons-material/GridView';
import ControlPointIcon from '@mui/icons-material/ControlPoint';
import MenuIcon from '@mui/icons-material/Menu';
import NotificationsNoneIcon from '@mui/icons-material/NotificationsNone';
import PeopleIcon from '@mui/icons-material/People';
export default function NavBar({link}) {
const navigate=useNavigate();
  return (
    <div className='flex justify-between p-4 bg-white w-[100%] items-start fixed top-0'>
            <h1 className='font-bold text-2xl pl-24'>DashBoard</h1>
            <div className='flex gap-5 items-center'>
            <input type="text" placeholder='Search Here' id="search" name="search"
         
        className='w-52 h-7 border border-gray-300 rounded-[5px] pl-3 pb-1 text-xs'/>
                 <ControlPointIcon className='cursor-pointer'/>
                 <GridViewIcon className='cursor-pointer'/>
                 <NotificationsNoneIcon className='cursor-pointer'/>
                
                  <img src="https://images.unsplash.com/photo-1610088441520-4352457e7095?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fG1lbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60" 
                  alt="" className='h-8 w-8 rounded-full  object-cover'/>
              
            </div>
            <div className='sidebar h-[100vh] bg-white w-[55px] flex flex-col fixed left-0 top-0 items-center border border-t-0 pt-6'>
          <MenuIcon className='cursor-pointer'/>
         <div className='mt-7 flex flex-col gap-6 items-center'> 
         <div className={`${link==="Home"?'bg-blue-500 text-white':'bg-white'} hover:bg-blue-500 w-[55px] cursor-pointer hover:text-white h-12 flex items-center justify-center`} onClick={()=>{
            navigate('/home')
         }}>
         <GridViewIcon className='cursor-pointer '/>
         </div>
         <div className={`${link==="User"?'bg-blue-500 text-white':'bg-white'} hover:bg-blue-500 w-[55px] cursor-pointer hover:text-white h-12 flex items-center justify-center`} onClick={()=>{
            navigate('/users')
         }}>
         <PeopleIcon className='cursor-pointer'/>
         </div>
          
         </div>
        </div>
        </div>
  )
}
