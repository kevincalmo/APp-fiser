-- CreateTable
CREATE TABLE `anomaly` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `way_id` INTEGER NULL,
    `date` DATE NOT NULL,
    `type` VARCHAR(255) NULL,
    `is_collected` VARCHAR(255) NOT NULL,
    `regularization_date` DATE NULL,
    `description` LONGTEXT NULL,
    `report_id` INTEGER NULL,
    `manual_town` VARCHAR(255) NULL,
    `manual_way` VARCHAR(255) NULL,
    `manual_flux` VARCHAR(255) NULL,
    `manual_truck` VARCHAR(255) NULL,
    `type_anomaly_id` INTEGER NULL,

    INDEX `IDX_F9F975634BD2A4C0`(`report_id`),
    INDEX `IDX_F9F975638C803113`(`way_id`),
    INDEX `IDX_F9F97563A7FAA19E`(`type_anomaly_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `circuit` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `default_outlet_id` INTEGER NULL,
    `name` VARCHAR(255) NOT NULL,

    INDEX `IDX_1325F3A65B9F0545`(`default_outlet_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `collecte` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `date` DATE NOT NULL,
    `observation` LONGTEXT NOT NULL,
    `is_valid` BOOLEAN NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `collecte_observation` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `collecte_id` INTEGER NULL,
    `description` LONGTEXT NOT NULL,

    INDEX `IDX_AAFE21C4710A9AC6`(`collecte_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `container_mouvement` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `worksite_id` INTEGER NULL,
    `driver_id` INTEGER NULL,
    `truck_id` INTEGER NULL,
    `flux_id` INTEGER NULL,
    `outlet_id` INTEGER NULL,
    `description` LONGTEXT NOT NULL,
    `tonnage` DOUBLE NOT NULL,
    `operation_type_id` INTEGER NULL,
    `container_type_id` INTEGER NULL,
    `date` DATE NOT NULL,

    INDEX `IDX_F45314375B3408DE`(`container_type_id`),
    INDEX `IDX_F4531437668D0C5E`(`operation_type_id`),
    INDEX `IDX_F4531437A47737E7`(`worksite_id`),
    INDEX `IDX_F4531437C3423909`(`driver_id`),
    INDEX `IDX_F4531437C6957CCE`(`truck_id`),
    INDEX `IDX_F4531437C85926E`(`flux_id`),
    INDEX `IDX_F4531437CAFD2DE2`(`outlet_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `container_type` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `doctrine_migration_versions` (
    `version` VARCHAR(191) NOT NULL,
    `executed_at` DATETIME(0) NULL,
    `execution_time` INTEGER NULL,

    PRIMARY KEY (`version`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `driver` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `last_name` VARCHAR(255) NOT NULL,
    `first_name` VARCHAR(255) NOT NULL,
    `type` VARCHAR(255) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `flux` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `circuit_id` INTEGER NULL,

    INDEX `IDX_7252313ACF2182C8`(`circuit_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `messenger_messages` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `body` LONGTEXT NOT NULL,
    `headers` LONGTEXT NOT NULL,
    `queue_name` VARCHAR(190) NOT NULL,
    `created_at` DATETIME(0) NOT NULL,
    `available_at` DATETIME(0) NOT NULL,
    `delivered_at` DATETIME(0) NULL,

    INDEX `IDX_75EA56E016BA31DB`(`delivered_at`),
    INDEX `IDX_75EA56E0E3BD61CE`(`available_at`),
    INDEX `IDX_75EA56E0FB7336F0`(`queue_name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `operation_type` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `outlet` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `replacement_team` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `substitute_driver_id` INTEGER NULL,
    `substitute_ripper1_id` INTEGER NULL,
    `substitute_ripper2_id` INTEGER NULL,

    INDEX `IDX_D7177897A0946D28`(`substitute_ripper2_id`),
    INDEX `IDX_D7177897B221C2C6`(`substitute_ripper1_id`),
    INDEX `IDX_D7177897FC53B99F`(`substitute_driver_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `report` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `default_outlet_id` INTEGER NULL,
    `visited_outlet_id` INTEGER NULL,
    `flux_id` INTEGER NULL,
    `truck_id` INTEGER NULL,
    `date` DATE NOT NULL,
    `manual_circuit` VARCHAR(255) NULL,
    `total_bac_collected` INTEGER NOT NULL,
    `total_bac_rejected` INTEGER NOT NULL,
    `tonnage` DOUBLE NULL,
    `tonnage2` DOUBLE NULL,
    `default_outlet2_id` INTEGER NULL,
    `visited_outlet2_id` INTEGER NULL,
    `default_outlet3_id` INTEGER NULL,
    `visited_outlet3_id` INTEGER NULL,
    `default_outlet4_id` INTEGER NULL,
    `visited_outlet4_id` INTEGER NULL,
    `tonnage3` DOUBLE NULL,
    `tonnage4` DOUBLE NULL,
    `circuit_id` INTEGER NULL,
    `collecte_id` INTEGER NULL,
    `observation` LONGTEXT NULL,
    `geoloc_id` INTEGER NULL,

    INDEX `IDX_C42F77841C45811C`(`visited_outlet4_id`),
    INDEX `IDX_C42F7784392EDEC0`(`visited_outlet2_id`),
    INDEX `IDX_C42F77845B9F0545`(`default_outlet_id`),
    INDEX `IDX_C42F7784710A9AC6`(`collecte_id`),
    INDEX `IDX_C42F77847A88CF02`(`default_outlet3_id`),
    INDEX `IDX_C42F77848192B9A5`(`visited_outlet3_id`),
    INDEX `IDX_C42F778495A5C71A`(`visited_outlet_id`),
    INDEX `IDX_C42F7784C234A867`(`default_outlet2_id`),
    INDEX `IDX_C42F7784C6957CCE`(`truck_id`),
    INDEX `IDX_C42F7784C85926E`(`flux_id`),
    INDEX `IDX_C42F7784CF2182C8`(`circuit_id`),
    INDEX `IDX_C42F7784E75FF7BB`(`default_outlet4_id`),
    INDEX `IDX_C42F7784EF390162`(`geoloc_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ripper` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `last_name` VARCHAR(255) NOT NULL,
    `first_name` VARCHAR(255) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `sinister` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `truck_id` INTEGER NULL,
    `driver_id` INTEGER NULL,
    `date` DATE NOT NULL,
    `place` VARCHAR(255) NOT NULL,
    `opposing_vehicule` VARCHAR(255) NULL,
    `opposing_driver` VARCHAR(255) NULL,
    `circumstance` LONGTEXT NULL,
    `status` VARCHAR(255) NOT NULL,
    `observation` LONGTEXT NULL,

    INDEX `IDX_73FC7B36C3423909`(`driver_id`),
    INDEX `IDX_73FC7B36C6957CCE`(`truck_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `tablet` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `label` VARCHAR(255) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `team` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `driver_id` INTEGER NULL,
    `flux_id` INTEGER NULL,
    `ripper1_id` INTEGER NULL,
    `ripper2_id` INTEGER NULL,
    `truck_id` INTEGER NULL,
    `replacement_team_id` INTEGER NULL,
    `name` VARCHAR(255) NOT NULL,
    `manual_circuit` VARCHAR(255) NULL,
    `manual_tablet` VARCHAR(255) NULL,

    UNIQUE INDEX `UNIQ_C4E0A61FC3423909`(`driver_id`),
    UNIQUE INDEX `UNIQ_C4E0A61FAB72E537`(`ripper1_id`),
    UNIQUE INDEX `UNIQ_C4E0A61FB9C74AD9`(`ripper2_id`),
    UNIQUE INDEX `UNIQ_C4E0A61FFA281DAB`(`replacement_team_id`),
    INDEX `IDX_C4E0A61FC6957CCE`(`truck_id`),
    INDEX `IDX_C4E0A61FC85926E`(`flux_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `town` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `circuit_id` INTEGER NULL,
    `name` VARCHAR(255) NOT NULL,
    `postal_code` INTEGER NOT NULL,

    INDEX `IDX_4CE6C7A4CF2182C8`(`circuit_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `truck` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `registration` VARCHAR(255) NOT NULL,
    `type` VARCHAR(255) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `type_anomaly` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `email` VARCHAR(180) NOT NULL,
    `roles` JSON NOT NULL,
    `password` VARCHAR(255) NOT NULL,

    UNIQUE INDEX `UNIQ_8D93D649E7927C74`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `way` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `town_id` INTEGER NULL,
    `name` VARCHAR(255) NOT NULL,
    `type` VARCHAR(255) NULL,

    INDEX `IDX_FBC034B975E23604`(`town_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `worksite` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `town_id` INTEGER NULL,
    `name` VARCHAR(255) NOT NULL,
    `adress` VARCHAR(255) NULL,

    INDEX `IDX_5E46478275E23604`(`town_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `anomaly` ADD CONSTRAINT `FK_F9F975634BD2A4C0` FOREIGN KEY (`report_id`) REFERENCES `report`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `anomaly` ADD CONSTRAINT `FK_F9F975638C803113` FOREIGN KEY (`way_id`) REFERENCES `way`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `anomaly` ADD CONSTRAINT `FK_F9F97563A7FAA19E` FOREIGN KEY (`type_anomaly_id`) REFERENCES `type_anomaly`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `circuit` ADD CONSTRAINT `FK_1325F3A65B9F0545` FOREIGN KEY (`default_outlet_id`) REFERENCES `outlet`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `collecte_observation` ADD CONSTRAINT `FK_AAFE21C4710A9AC6` FOREIGN KEY (`collecte_id`) REFERENCES `collecte`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `container_mouvement` ADD CONSTRAINT `FK_F45314375B3408DE` FOREIGN KEY (`container_type_id`) REFERENCES `container_type`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `container_mouvement` ADD CONSTRAINT `FK_F4531437668D0C5E` FOREIGN KEY (`operation_type_id`) REFERENCES `operation_type`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `container_mouvement` ADD CONSTRAINT `FK_F4531437A47737E7` FOREIGN KEY (`worksite_id`) REFERENCES `worksite`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `container_mouvement` ADD CONSTRAINT `FK_F4531437C3423909` FOREIGN KEY (`driver_id`) REFERENCES `driver`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `container_mouvement` ADD CONSTRAINT `FK_F4531437C6957CCE` FOREIGN KEY (`truck_id`) REFERENCES `truck`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `container_mouvement` ADD CONSTRAINT `FK_F4531437C85926E` FOREIGN KEY (`flux_id`) REFERENCES `flux`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `container_mouvement` ADD CONSTRAINT `FK_F4531437CAFD2DE2` FOREIGN KEY (`outlet_id`) REFERENCES `outlet`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `flux` ADD CONSTRAINT `FK_7252313ACF2182C8` FOREIGN KEY (`circuit_id`) REFERENCES `circuit`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `replacement_team` ADD CONSTRAINT `FK_D7177897A0946D28` FOREIGN KEY (`substitute_ripper2_id`) REFERENCES `ripper`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `replacement_team` ADD CONSTRAINT `FK_D7177897B221C2C6` FOREIGN KEY (`substitute_ripper1_id`) REFERENCES `ripper`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `replacement_team` ADD CONSTRAINT `FK_D7177897FC53B99F` FOREIGN KEY (`substitute_driver_id`) REFERENCES `driver`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `report` ADD CONSTRAINT `FK_C42F77841C45811C` FOREIGN KEY (`visited_outlet4_id`) REFERENCES `outlet`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `report` ADD CONSTRAINT `FK_C42F7784392EDEC0` FOREIGN KEY (`visited_outlet2_id`) REFERENCES `outlet`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `report` ADD CONSTRAINT `FK_C42F77845B9F0545` FOREIGN KEY (`default_outlet_id`) REFERENCES `outlet`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `report` ADD CONSTRAINT `FK_C42F7784710A9AC6` FOREIGN KEY (`collecte_id`) REFERENCES `collecte`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `report` ADD CONSTRAINT `FK_C42F77847A88CF02` FOREIGN KEY (`default_outlet3_id`) REFERENCES `outlet`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `report` ADD CONSTRAINT `FK_C42F77848192B9A5` FOREIGN KEY (`visited_outlet3_id`) REFERENCES `outlet`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `report` ADD CONSTRAINT `FK_C42F778495A5C71A` FOREIGN KEY (`visited_outlet_id`) REFERENCES `outlet`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `report` ADD CONSTRAINT `FK_C42F7784C234A867` FOREIGN KEY (`default_outlet2_id`) REFERENCES `outlet`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `report` ADD CONSTRAINT `FK_C42F7784C6957CCE` FOREIGN KEY (`truck_id`) REFERENCES `truck`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `report` ADD CONSTRAINT `FK_C42F7784C85926E` FOREIGN KEY (`flux_id`) REFERENCES `flux`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `report` ADD CONSTRAINT `FK_C42F7784CF2182C8` FOREIGN KEY (`circuit_id`) REFERENCES `circuit`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `report` ADD CONSTRAINT `FK_C42F7784E75FF7BB` FOREIGN KEY (`default_outlet4_id`) REFERENCES `outlet`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `report` ADD CONSTRAINT `FK_C42F7784EF390162` FOREIGN KEY (`geoloc_id`) REFERENCES `tablet`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `sinister` ADD CONSTRAINT `FK_73FC7B36C3423909` FOREIGN KEY (`driver_id`) REFERENCES `driver`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `sinister` ADD CONSTRAINT `FK_73FC7B36C6957CCE` FOREIGN KEY (`truck_id`) REFERENCES `truck`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `team` ADD CONSTRAINT `FK_C4E0A61FAB72E537` FOREIGN KEY (`ripper1_id`) REFERENCES `ripper`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `team` ADD CONSTRAINT `FK_C4E0A61FB9C74AD9` FOREIGN KEY (`ripper2_id`) REFERENCES `ripper`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `team` ADD CONSTRAINT `FK_C4E0A61FC3423909` FOREIGN KEY (`driver_id`) REFERENCES `driver`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `team` ADD CONSTRAINT `FK_C4E0A61FC6957CCE` FOREIGN KEY (`truck_id`) REFERENCES `truck`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `team` ADD CONSTRAINT `FK_C4E0A61FC85926E` FOREIGN KEY (`flux_id`) REFERENCES `flux`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `team` ADD CONSTRAINT `FK_C4E0A61FFA281DAB` FOREIGN KEY (`replacement_team_id`) REFERENCES `replacement_team`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `town` ADD CONSTRAINT `FK_4CE6C7A4CF2182C8` FOREIGN KEY (`circuit_id`) REFERENCES `circuit`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `way` ADD CONSTRAINT `FK_FBC034B975E23604` FOREIGN KEY (`town_id`) REFERENCES `town`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `worksite` ADD CONSTRAINT `FK_5E46478275E23604` FOREIGN KEY (`town_id`) REFERENCES `town`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

