import { Request, Response, NextFunction } from "express";
import { allowedOrigins } from "~/config/allowedOrigin";

const credentials = (req: Request, res: Response, next: NextFunction) => {
  const origin = req.headers.origin!;
  if (allowedOrigins.includes(origin)) {
    res.header("Access-Control-Allow-Credentials", String(true));
    res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept');
  }
  next();
};

export {credentials};
