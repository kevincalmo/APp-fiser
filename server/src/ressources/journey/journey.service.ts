import { prisma } from "~~/lib/prisma";
import { FastReportInterface } from "~~/types/FastReportInterface";
import { JourneyInterface } from "~~/types/JourneyInterface";
import { ReportMorning } from "~~/types/ReportMorningInterface";

export class JourneyService {
  async findAll() {
    const data = await prisma.collecte.findMany({
      orderBy: [{ date: "desc" }],
    });
    return data;
  }

  async createJourney(data: JourneyInterface) {
    const newJourney = await prisma.collecte.create({
      data: {
        date: new Date(data.date).toISOString(),
        observation: data.observation,
        is_valid: data.is_valid,
      },
    });

    return newJourney;
  }

  async updateJourney(data: JourneyInterface) {
    const { id, date, observation, is_valid } = data;

    const updatedJourney = await prisma.collecte.update({
      where: { id },
      data: {
        date: new Date(data.date).toISOString(),
        observation,
        is_valid,
      },
    });

    return updatedJourney;
  }

  async deleteJourney(id: number) {
    const deletedJourney = await prisma.collecte.delete({ where: { id } });
    return deletedJourney;
  }

  async findAllReportPerJourney(id: number) {
    const reports = await prisma.report.findMany({
      where: { collecte_id: id },
    });
  }

  async createMorningReport(data: ReportMorning, id: number) {
    const newReport = await prisma.report.create({
      data: {
        collecte_id: id,
        date: new Date(data.date).toISOString(),
        truck_id: data.truck,
        circuit_id: data.circuit,
        geoloc_id: data.tablet,
        observation: data.observation,
        total_bac_collected: 0,
        total_bac_rejected: 0,
      },
    });
    return newReport;
  }

  async updateMorningReport(data: ReportMorning, id: number) {
    const updateReport = await prisma.report.update({
      where: { id },
      data: {
        date: new Date(data.date).toISOString(),
        truck_id: data.truck,
        circuit_id: data.circuit,
        geoloc_id: data.tablet,
        observation: data.observation,
      },
    });
  }

  async updateFastReport(data: FastReportInterface, id: number) {
    const updatedReport = await prisma.report.update({
      where: { id },
      data: {
        total_bac_collected: Number(data.total_bac_collected),
        total_bac_rejected: Number(data.total_bac_rejected),
        tonnage: Number(data.tonnage),
        tonnage2: Number(data.tonnage2) ?? null,
        tonnage3: Number(data.tonnage3) ?? null,
        tonnage4: Number(data.tonnage4) ?? null,
        visited_outlet_id: Number(data.visited_outlet) ?? null,
        visited_outlet2_id: Number(data.visited_outlet2) ?? null,
        visited_outlet3_id: Number(data.visited_outlet3) ?? null,
        visited_outlet4_id: Number(data.visited_outlet4) ?? null,
        default_outlet_id: Number(data.default_outlet) ?? null,
        default_outlet2_id: Number(data.default_outlet2) ?? null,
        default_outlet3_id: Number(data.default_outlet3) ?? null,
        default_outlet4_id: Number(data.default_outlet4) ?? null,
      },
    });
    return updatedReport;
  }

  async deleteReport(id: number) {
    const deletedJourney = await prisma.report.delete({ where: { id } });
    return deletedJourney;
  }
}
