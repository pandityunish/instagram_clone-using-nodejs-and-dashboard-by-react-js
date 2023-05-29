

import React from 'react'
import {
    createBrowserRouter,
    
  } from "react-router-dom";
import Login from '../components/Login';
import Home from '../components/Home';
import Users from '../components/Users';
import UserDetails from '../components/UserDetails';
import Posts from '../components/Posts';
export const router=createBrowserRouter([
    {
        path: "/",
        element: <Login/>,
      },
      {
        path: "/home",
        element: <Home/>,
      },
      {
        path: "/users",
        element: <Users/>,
      },
      {
        path: "/userdetails",
        element: <UserDetails/>,
      },
      {
        path: "/posts",
        element: <Posts/>,
      },
])  
  

