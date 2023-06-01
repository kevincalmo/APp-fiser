import { INSPECT_MAX_BYTES } from "buffer";
import { prisma } from "~~/lib/prisma";

export class Extraction {
  async extractContainerMouvement(start_date: string, end_date: string) {
    //Récupération de la data
    const data = await prisma.container_mouvement.findMany({
      orderBy: [{ date: "asc" }],
      select: {
        date: true,
        tonnage: true,
        container_type: { select: { name: true } },
        operation_type: { select: { name: true } },
        outlet: { select: { name: true } },
        flux: { select: { name: true } },
        truck: { select: { registration: true } },
        worksite: { select: { name: true } },
      },
      where: {
        date: {
          lte: new Date(end_date).toISOString(),
          gte: new Date(start_date).toISOString(),
        },
      },
    });
    return data;
  }
}
