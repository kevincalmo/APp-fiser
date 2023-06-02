import { Router } from "express";
import { JourneyService } from "./journey.service";

const JourneyController = Router();
const journey = new JourneyService();

JourneyController.get("/", async (req, res) => {
  const data = await journey.findAll();
  res.send({ data });
});

JourneyController.post("/", async (req, res) => {
  const data = req.body.data;

  console.log(req.body.data);

  //vérification des champs

  //création de la journée de collecte
  const newJourney = await journey.createJourney(data);

  if (newJourney) {
    res.send(newJourney);
  } else {
    res.sendStatus(500);
  }
});

JourneyController.put("/:id/edit", async (req, res) => {
  const data = req.body.data;

  const updatedJourney = await journey.updateJourney(data);

  if (updatedJourney) {
    res.send(updatedJourney);
  } else {
    res.sendStatus(500);
  }
});

JourneyController.delete("/:id", async (req, res) => {
  const id = Number(req.params.id);
  const deletedJourney = await journey.deleteJourney(id);
  if (deletedJourney) {
    res.send(deletedJourney);
  } else {
    res.sendStatus(500);
  }
});

export { JourneyController };
