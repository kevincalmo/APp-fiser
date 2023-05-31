import { Navigate, Route, BrowserRouter as Router, Routes } from "react-router-dom"
import Login from "./pages/login/Login"
import { ProtectRoutes } from "./hooks/protectRoutes/protecRoutes"
import Dashboard from "./pages/dashboard/Dashboard"
function App() {

  return (
    <Router>
      <Routes>
      <Route path='/login' element={ <Login /> } />
      <Route element={ <ProtectRoutes /> }>
        <Route path='/' element={ <Dashboard /> } />
      </Route>
      </Routes>
    </Router>
  )
}

export default App
