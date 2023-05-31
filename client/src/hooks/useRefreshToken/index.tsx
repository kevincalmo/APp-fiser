import axios from '../../lib/axios'

function UseRefreshToken() {
  const refresh = async()=>{
    const response = await axios.post("auth/refresh-token");
    return response.data.accessToken;
  }
  return refresh;
}

export default UseRefreshToken