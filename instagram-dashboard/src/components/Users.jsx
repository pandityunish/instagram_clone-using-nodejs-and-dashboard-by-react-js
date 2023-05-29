import React,{useState,useEffect} from 'react'
import NavBar from './NavBar'
import { useNavigate } from 'react-router-dom'
import UserModalComponent from '../modal/userModal';
export default function Users() {
  const [users, setusers] = useState([]);
  const [modalOpen, setmodalOpen] = useState(false)

  const navigate=useNavigate();
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
  useEffect(() => {
    getallusers()
  
   
  }, [])
  
  return (
    <div>
      <NavBar link="User"/>
      <div className='px-28 mt-5 pt-14'>
      <p className='text-3xl font-semibold '>Users:</p>
      <div className="flex flex-col mt-10">
  <div className="-my-2 overflow-x-auto sm:-mx-6 lg:-mx-8">
    <div className="py-2 align-middle inline-block min-w-full sm:px-6 lg:px-8">
      <div className="shadow overflow-hidden border-b border-gray-200 sm:rounded-lg">
        <table className="min-w-full divide-y divide-gray-200">
          <thead className="bg-gray-50">
            <tr>
            <th scope="col" className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Profile
              </th>
              <th scope="col" className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Name
              </th>
              <th scope="col" className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
              Email
              </th>
              <th scope="col" className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Role
              </th>
              <th scope="col" className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Followers
              </th>
              <th scope="col" className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Following
              </th>
              <th scope="col" className="relative px-6 py-3">
                <span className="sr-only">Edit</span>
              </th>
            </tr>
          </thead>
          {users.map((user,index)=>{
            console.log(user['image'])
            return <tbody className="bg-white divide-y divide-gray-200" key={index} >
            <tr>
            <td className="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900 cursor-pointer" onClick={()=>{
              navigate('/userdetails',{state:{id:user['_id'],name:user['name'],email:user['email'],followers:user['followers'].length
              ,following:user['following'].length,image:user['image']}});
            }}>
                <img src={user['image']===""?'https://res.cloudinary.com/dsqtxanz6/image/upload/v1682761190/zu41cdfdrp95xzvq9o6o.png':user['image']} alt='https://res.cloudinary.com/dsqtxanz6/image/upload/v1682761190/zu41cdfdrp95xzvq9o6o.png' 
                className='h-8 w-8 rounded-full  object-cover'
                />
              </td>
              <td className="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900 cursor-pointer" onClick={()=>{
             navigate('/userdetails',{state:{id:user['_id'],name:user['name'],email:user['email'],followers:user['followers'].length,following:user['following'].length,image:user['image']}});
            }}>
                {user["name"]}
              </td>
              <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500 cursor-pointer">
                {user["email"]}
              </td>
              <td className="px-6 py-4 whitespace-nowrap">
                <span className="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
                  Users
                </span>
              </td>
              <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                {user["followers"].length}
              </td>
              <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
              {user["following"].length}
              </td>
              <UserModalComponent modalOpen={modalOpen} setModalOpen={setmodalOpen}/>
              <td className="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                <a href="#" className="text-indigo-600 hover:text-indigo-900" onClick={()=>{
                  setmodalOpen(true)
                }}>Edit</a>
              </td>
            </tr>

           

          </tbody>
          })}
          
        </table>
      </div>
    </div>
  </div>
</div>

      </div>
    </div>
  )
}
