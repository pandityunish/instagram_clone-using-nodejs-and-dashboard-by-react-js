import { toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';

export const loginuseradmin=async(email,password)=>{
    
    try {
        const res=await fetch("http://localhost:5000/admin/login",
        {
            method: 'POST',
        
            crossDomain:true,
            headers: {
                'Content-Type': 'application/json',
                Accept:'application/json'
            },
            body:JSON.stringify({email:email,password:password})
        },
         
        );
        console.log(res.body);

    } catch (e) {
        console.log(e)
    }
}

export const getallstories=async(setstories)=>{
    try {
      
        const response=await fetch("http://localhost:5000/getallstories", {
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
          
        setstories(json);
       
      
       } catch (e) {
        toast.error("Some Errors")
       }
    }