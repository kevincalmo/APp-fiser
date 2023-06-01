import { Router } from "express";
import { request } from "http";
import { Extraction } from "./extraction.service";
import xlsx from "xlsx";
import path from "path";

const ExtractController = Router();

const Extract = new Extraction();

ExtractController.post("/container-mouvement", async (req, res) => {
  const { start_date, end_date } = req.body;

  //Vérification des entrées

  //récupération des mouvements
  const data = await Extract.extractContainerMouvement(start_date, end_date);

  //formatage des données
  const jsonData = data.map((item) => {
    const {
      date,
      tonnage,
      container_type,
      operation_type,
      outlet,
      flux,
      truck,
      worksite,
    } = item;
    return {
      date,
      tonnage,
      contenant: container_type?.name,
      type_operation: operation_type?.name,
      exutoire: outlet?.name,
      flux: flux?.name,
      camion: truck?.registration,
      chantier: worksite?.name,
    };
  });

  /* Création de la feuille de calcul */
  const worksheet = xlsx.utils.json_to_sheet(jsonData);
  const workbook = xlsx.utils.book_new();
  xlsx.utils.book_append_sheet(workbook, worksheet, "Sheet1");
  xlsx.writeFile(workbook, path.resolve("./file.xlsx"));
  return res.sendFile(path.resolve("./file.xlsx"));
  
  //return res.json({ jsonData });
});

export { ExtractController };
