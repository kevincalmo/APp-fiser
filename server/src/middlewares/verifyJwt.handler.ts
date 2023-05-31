import { NextFunction, Request, Response } from "express";
import * as dotenv from "dotenv";
dotenv.config();
import jwt from "jsonwebtoken";

const verifyJwt = (req:Request, res:Response, next:NextFunction)=>{
    const authHeader = req.headers['authorization'];
    if(!authHeader) return res.sendStatus(401);
    console.log(authHeader);
    const token = authHeader.split(' ')[1];
    jwt.verify(token, process.env.ACCESS_TOKEN_SECRET!, (err, decoded) => {
        if (err) {
          return res.sendStatus(403); //token invalide
        }
        console.log(decoded);
        next()
      });
}

export {verifyJwt};