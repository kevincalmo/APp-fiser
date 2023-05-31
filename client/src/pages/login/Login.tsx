import React, { useState } from 'react';
import { useAuth } from '../../context/userAuthContext'; 
import { useNavigate } from 'react-router-dom';

export default function Login() {
    const [cnpj, setCnpj] = useState('');
    const [password, setPassword] = useState('');
    const context = useAuth();
    const navigate = useNavigate();

    const handleLogin = async() => {
        
        await context?.login({ email:cnpj, password });
        navigate('/');
    }

    return (
        <div>
            <input onChange={e => setCnpj(e.target.value)} placeholder="Email"/>
            <input onChange={e => setPassword(e.target.value)} placeholder="Password"/>
            <button onClick={handleLogin} type="submit">Login</button>
        </div>
    )
}