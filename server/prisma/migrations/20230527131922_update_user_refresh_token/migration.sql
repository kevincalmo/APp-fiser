/*
  Warnings:

  - You are about to alter the column `refresh_token` on the `user` table. The data in that column could be lost. The data in that column will be cast from `VarChar(255)` to `VarChar(191)`.

*/
-- AlterTable
ALTER TABLE `user` MODIFY `refresh_token` VARCHAR(191) NOT NULL;
