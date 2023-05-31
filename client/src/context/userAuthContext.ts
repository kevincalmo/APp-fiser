import { createContext, useContext } from "react";



interface UserContextType {
    cookies: any; // Define the type for cookies here
    login: (arg: any) => Promise<void>; // Define the type for the argument here
    logout: () => void;
  }

export const UserAuthContext = createContext<UserContextType | undefined>(undefined);

export const useAuth = () => {
    return useContext(UserAuthContext)
};

