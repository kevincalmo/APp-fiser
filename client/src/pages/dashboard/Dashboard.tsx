import { useEffect, useState } from "react";
import { useAuth } from "../../context/userAuthContext";
import { useNavigate } from "react-router-dom";
import UseRefreshToken from "../../hooks/useRefreshToken";
import UseAxiosPrivate from "../../hooks/UseAxiosPrivate";

interface Pet {
  id: number;
  name: string;
  type: string;
}

export default function Dashboard() {
  const context = useAuth();
  const [items, setItems] = useState<Pet | undefined>(undefined);
  const refresh = UseRefreshToken();
  const axiosPrivate = UseAxiosPrivate();

  useEffect(() => {
    let isMounted = true;
    const controller = new AbortController();

    const getItems = async () => {
      try {
        const res = await axiosPrivate.get("/api/pets");
        console.log(res.data);
      } catch (error) {
        console.log(error);
      }
    };

    getItems();

    return () => {
      isMounted = false;
      controller.abort();
    };
  }, [context?.cookies.token]);

  const navigate = useNavigate();
  function handleLogout() {
    context?.logout();
    navigate("/login");
  }
  return (
    <div>
      <p>Dashboard</p>
      <button onClick={handleLogout}>deconnection</button>
      <div>
        <button onClick={refresh}>refresh</button>
      </div>
    </div>
  );
}
