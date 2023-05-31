import { Outlet, Navigate } from 'react-router-dom';
import { useAuth } from '../../context/userAuthContext'; 

export const ProtectRoutes = () => {
    const context = useAuth();

    return context?.cookies.token ? <Outlet/> : <Navigate to='/login' />
};
