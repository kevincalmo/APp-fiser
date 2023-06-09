import { axiosPrivate } from "../../lib/axios";
import { useEffect } from "react";
import UseRefreshToken from "../useRefreshToken";
import { useAuth } from "../../context/userAuthContext";

const UseAxiosPrivate = () => {
  const refresh = UseRefreshToken();
  const context = useAuth();

  useEffect(() => {
    const requestIntercept = axiosPrivate.interceptors.request.use(
      (config) => {
        if (!config.headers["authorization"]) {
          config.headers["authorization"] = `Bearer ${context?.cookies.token}`;
        }
        return config;
      },
      (error) => Promise.reject(error)
    );

    const responseIntercept = axiosPrivate.interceptors.response.use(
      (response) => response,
      async (error) => {
        const prevRequest = error?.config;
        if (error?.response.status === 403 && !prevRequest.sent) {
          prevRequest.sent = true;
          const newAccessToken = await refresh();
          prevRequest.headers["authorization"] = `Bearer ${newAccessToken}`;
          return axiosPrivate(prevRequest);
        }
        return Promise.reject(error);
      }
    );

    return () => {
      axiosPrivate.interceptors.request.eject(requestIntercept);
      axiosPrivate.interceptors.response.eject(responseIntercept);
    };
  }, [context?.cookies.token, refresh]);
  return axiosPrivate;
};

export default UseAxiosPrivate;
