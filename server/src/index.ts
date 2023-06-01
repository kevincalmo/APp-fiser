import cors from "cors";
import express from "express";
import { config } from "~/config";
import { PetsController } from "~/ressources/pets/pets.controller";
import { ExceptionsHandler } from "~/middlewares/exception.handler";
import { UnknownRoutesHandler } from "~/middlewares/unknowRoutes.handler";
import { AuthController } from "./ressources/auth/auth.controller";
import { verifyJwt } from "./middlewares/verifyJwt.handler";
import cookieParser from "cookie-parser";
import { credentials } from "./middlewares/credentials.handler";
import { corsOptions } from "./config/corsOptions";
import { ExtractController } from "./ressources/extraction/extraction.controller";

/**
 * On créé une nouvelle "application" express
 */
const app = express();

/**
 * On dit à Express que l'on souhaite parser le body des requêtes en JSON
 *
 * @example app.post('/', (req) => req.body.prop)
 */
app.use(express.json());

//middle pour les cookies
app.use(cookieParser());

app.use(credentials)

/**
 * On dit à Express que l'on souhaite autoriser tous les noms de domaines
 * à faire des requêtes sur notre API.
 */
app.use(cors(corsOptions));

/**
 * Toutes les routes CRUD pour les animaux seronts préfixées par `/pets`
 */
//app.use("/api",verifyJwt);
app.use("/api/pets", PetsController);
app.use("/api/extraction", ExtractController)
app.use("/auth", AuthController);

/**
 * Homepage (uniquement necessaire pour cette demo)
 */
app.get("/", (req, res) => res.send("Home🏠"));

/**
 * Pour toutes les autres routes non définies, on retourne une erreur
 */
app.all("*", UnknownRoutesHandler);

/**
 * Gestion des erreurs
 * /!\ Cela doit être le dernier `app.use`
 */
app.use(ExceptionsHandler);

/**
 * On demande à Express d'ecouter les requêtes sur le port défini dans la config
 */
app.listen(config.API_PORT, () => console.log("Silence, ça tourne."));
