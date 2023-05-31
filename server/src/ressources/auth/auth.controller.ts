import bcrypt from "bcrypt";
import { Router } from "express";
import { JwtPayload } from "jsonwebtoken";
import { generateJWTAcessToken, generateJWTRefreshToken } from "~~/lib/jwt";
import { prisma } from "~~/lib/prisma";
import jwt from "jsonwebtoken";
import * as dotenv from "dotenv";
dotenv.config();

interface RequestBody {
  username: string;
  password: string;
  isAdmin?: string;
}

const APP_ENV = process.env.APP_ENV;

const AuthController = Router();

AuthController.post("/login", async (req, res) => {
  const { username, password }: RequestBody = req.body;
  console.log(APP_ENV);

  //l'une des deux valeurs n'est pas renseigner
  if (!username || !password) {
    return res.status(400).json({
      message: "Le nom d'utilisateur et le mot de passe sont obligatoire",
    });
  }

  const user = await prisma.user.findUnique({
    where: {
      email: username,
    },
  });
  // l'utilisateur n'a pas été trouver
  if (!user) {
    return res
      .status(401)
      .json({ message: "l'utilisateur n'exite pas en base de donnée" });
  }
  const matchPassword = await bcrypt.compare(password, user.password);
  if (matchPassword) {
    //création du jwt
    const accessToken = generateJWTAcessToken({
      id: user.id,
      username: user.email,
      roles: user.roles,
    } as JwtPayload);

    const refreshToken = generateJWTRefreshToken({
      id: user.id,
      username: user.email,
      roles: user.roles,
    } as JwtPayload);

    const userToSend = {
      user: {
        id: user.id,
        username: user.email,
        roles: user.roles,
      },
      accessToken,
      refreshToken
    };
    res.cookie("jwt", refreshToken, {
      httpOnly: true,
      maxAge: 24 * 60 * 60 * 1000, //un jour max
      sameSite: "none",
      secure: true,
    });
    //update du refreshToken dans ma base de donnée utilisateur
    try {
      await prisma.user.update({
        where: {
          email: username,
        },
        data: {
          refresh_token: refreshToken,
        },
      });
    } catch (error) {
      console.log(error);
    }
    return res
      .status(200)
      .json({ success: `User ${user} is logged in`, user: userToSend });
  } else {
    return res
      .status(401)
      .json({ message: "Le mot de passe ne correspond pas" });
  }
});

AuthController.post("/register", async (req, res) => {
  const { username, password, isAdmin }: RequestBody = req.body;
  if (!username || !password) {
    return res.status(400).json({
      message: "Le nom d'utilisateur et le mot de passe sont obligatoire",
    });
  }
  //check si le nom d'utilisateur est libre
  const foundUser = await prisma.user.findUnique({
    where: { email: username },
  });
  if (foundUser) {
    return res
      .status(401)
      .json({ message: "Ce nom d'utilisateur existe déja" });
  }

  const hashPassword = await bcrypt.hash(password, 10);
  const user = await prisma.user.create({
    data: {
      email: username,
      roles: {
        role_user: true,
        role_admin: isAdmin ? true : false,
      },
      password: hashPassword,
      refresh_token: "",
    },
  });
  const userToSend = { id: user.id, email: user.email, roles: user.roles };
  return res.status(200).json({
    sucess: "Utilisateur crée avec success",
    user: userToSend,
  });
});

AuthController.post("/refresh-token", async (req, res) => {
  const cookies = req.cookies;
  //check si le cookie existe
  if (!cookies?.jwt) {
    return res.sendStatus(401);
  }
  const refreshToken: string = cookies.jwt;
  const user = await prisma.user.findFirst({
    where: { refresh_token: refreshToken },
  });
  // l'utilisateur n'a pas été trouver
  if (!user) {
    return res.sendStatus(403);
  }

  jwt.verify(
    refreshToken,
    process.env.REFRESH_TOKEN_SECRET!,
    async (err, decoded: any) => {
      console.log(decoded);

      if (err || user.email !== decoded.username) {
        return res.sendStatus(403); //token invalide
      }

      const accessToken = generateJWTAcessToken({
        id: user.id,
        username: user.email,
        roles: user.roles,
      } as JwtPayload);
      const newRefreshToken = generateJWTRefreshToken({
        id: user.id,
        username: user.email,
        roles: user.roles,
      } as JwtPayload);
      await prisma.user.update({
        where: { email: user.email },
        data: {
          refresh_token: newRefreshToken,
        },
      });

      res.cookie("jwt", newRefreshToken, {
        httpOnly: true,
        maxAge: 24 * 60 * 60 * 1000, //un jour max
        sameSite: "none",
        secure: true,
      });

      return res.status(200).json({ accessToken });
    }
  );
});

AuthController.get("/logout", async (req, res) => {
  const cookies = req.cookies;
  
  if (!cookies?.jwt) {
    console.log("no cookie");
    
    return res.sendStatus(204);
  }

  const refreshToken = cookies.jwt;
  const user = await prisma.user.findFirst({
    where: { refresh_token: refreshToken },
  });
  if (!user) {
    console.log("no user");
    
    res.clearCookie("jwt", { httpOnly: true, maxAge: 24 * 60 * 60 * 1000,sameSite: "none",
    secure: true, });
    return res.sendStatus(204);
  }
  // Suppression du refreshToken
  await prisma.user.update({
    where: { email: user.email },
    data: {
      refresh_token: "",
    },
  });
  res.clearCookie("jwt", {
    httpOnly: true,
    maxAge: 24 * 60 * 60 * 1000,
    sameSite: "none",
    secure: true,
  });
  return res.sendStatus(204);
});

export { AuthController };
