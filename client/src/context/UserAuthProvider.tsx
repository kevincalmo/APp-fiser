import { useMemo } from "react";
import { UserAuthContext } from "./userAuthContext";
import axios from "../lib/axios";
import { useCookies } from "react-cookie";

export default function UserAuthProvider({ children }: any) {
  const [cookies, setCookies, removeCookie] = useCookies();

  const login = async ({ email, password }: any) => {
    console.log(email);

    const res = await axios.post("/auth/login", {
      username: email,
      password: password,
    });
    console.log(res);
    
    setCookies("token", res.data.user.accessToken); // your token
    setCookies("jwt",res.data.user.refreshToken);//refreshToken
    setCookies("name", res.data.user.user.username); // optional data
  };

  const logout = async () => {
    await axios.get("/auth/logout",);
    ["token", "name"].forEach((obj) => removeCookie(obj)); // remove data save in cookies
  };

  const value = useMemo(
    () => ({
      cookies,
      login,
      logout,
    }),
    [cookies]
  );
  return (
    <UserAuthContext.Provider value={value}>
      {children}
    </UserAuthContext.Provider>
  );
}
