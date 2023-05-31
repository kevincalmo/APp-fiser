import jwt, { JwtPayload } from "jsonwebtoken";
import * as dotenv from "dotenv";
dotenv.config();

const ACCESS_TOKEN = process.env.ACCESS_TOKEN_SECRET;
const REFRESH_TOKEN = process.env.REFRESH_TOKEN_SECRET;

export const generateJWTAcessToken = (payload: JwtPayload) => {
  return jwt.sign(payload, ACCESS_TOKEN!, { expiresIn: "10s" });
};

export const generateJWTRefreshToken = (payload: JwtPayload) => {
  return jwt.sign(payload, REFRESH_TOKEN!, { expiresIn: "1d" });
};
