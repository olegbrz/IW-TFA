-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema iw_tfa
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `iw_tfa` ;

-- -----------------------------------------------------
-- Schema iw_tfa
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `iw_tfa` ;
USE `iw_tfa` ;

-- -----------------------------------------------------
-- Table `iw_tfa`.`Paciente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `iw_tfa`.`Paciente` ;

CREATE TABLE IF NOT EXISTS `iw_tfa`.`Paciente` (
  `NIF` INT NOT NULL,
  `Nombre` VARCHAR(500) NULL,
  `Apellidos` VARCHAR(500) NULL,
  `Fecha_Nacimiento` DATE NULL,
  `Email` VARCHAR(500) NULL,
  `Telefono` VARCHAR(45) NULL,
  `Altura` INT NULL,
  `Peso` INT NULL,
  `Password` VARCHAR(500) NULL,
  `Medico_NIF` INT NULL,
  PRIMARY KEY (`NIF`),
  INDEX `fk_Paciente_Médico1_idx` (`Medico_NIF` ASC) VISIBLE,
  CONSTRAINT `fk_Paciente_Médico1`
    FOREIGN KEY (`Medico_NIF`)
    REFERENCES `iw_tfa`.`Medico` (`NIF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `iw_tfa`.`Medico`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `iw_tfa`.`Medico` ;

CREATE TABLE IF NOT EXISTS `iw_tfa`.`Medico` (
  `NIF` INT NOT NULL,
  `Nombre` VARCHAR(500) NULL,
  `Apellidos` VARCHAR(500) NULL,
  `Email` VARCHAR(500) NULL,
  `Password` VARCHAR(500) NULL,
  `Hospital` VARCHAR(500) NULL,
  `Consulta` VARCHAR(500) NULL,
  `Horario_Atencion` VARCHAR(500) NULL,
  `Telefono` VARCHAR(45) NULL,
  PRIMARY KEY (`NIF`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `iw_tfa`.`Paciente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `iw_tfa`.`Paciente` ;

CREATE TABLE IF NOT EXISTS `iw_tfa`.`Paciente` (
  `NIF` INT NOT NULL,
  `Nombre` VARCHAR(500) NULL,
  `Apellidos` VARCHAR(500) NULL,
  `Fecha_Nacimiento` DATE NULL,
  `Email` VARCHAR(500) NULL,
  `Telefono` VARCHAR(45) NULL,
  `Altura` INT NULL,
  `Peso` INT NULL,
  `Password` VARCHAR(500) NULL,
  `Medico_NIF` INT NULL,
  PRIMARY KEY (`NIF`),
  INDEX `fk_Paciente_Médico1_idx` (`Medico_NIF` ASC) VISIBLE,
  CONSTRAINT `fk_Paciente_Médico1`
    FOREIGN KEY (`Medico_NIF`)
    REFERENCES `iw_tfa`.`Medico` (`NIF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `iw_tfa`.`Receta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `iw_tfa`.`Receta` ;

CREATE TABLE IF NOT EXISTS `iw_tfa`.`Receta` (
  `idReceta` INT NOT NULL AUTO_INCREMENT,
  `Fecha_Inicio` DATE NULL,
  `Fecha_Fin` DATE NULL,
  `Medicamento` VARCHAR(45) NULL,
  `Principio_Activo` VARCHAR(45) NULL,
  `Posologia` VARCHAR(45) NULL,
  `Paciente_NIF` INT NOT NULL,
  `Medico_NIF` INT NOT NULL,
  PRIMARY KEY (`idReceta`),
  INDEX `fk_Receta_Paciente1_idx` (`Paciente_NIF` ASC) VISIBLE,
  INDEX `fk_Receta_Médico1_idx` (`Medico_NIF` ASC) VISIBLE,
  CONSTRAINT `fk_Receta_Paciente1`
    FOREIGN KEY (`Paciente_NIF`)
    REFERENCES `iw_tfa`.`Paciente` (`NIF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Receta_Médico1`
    FOREIGN KEY (`Medico_NIF`)
    REFERENCES `iw_tfa`.`Medico` (`NIF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `iw_tfa`.`Lectura`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `iw_tfa`.`Lectura` ;

CREATE TABLE IF NOT EXISTS `iw_tfa`.`Lectura` (
  `idLectura` INT NOT NULL AUTO_INCREMENT,
  `Fecha_Hora` DATETIME NULL,
  `TA_Sistolica` INT NULL,
  `TA_Diastolica` INT NULL,
  `PPM` INT NULL,
  `Notas` VARCHAR(500) NULL,
  `Notas_medico` VARCHAR(500) NULL,
  `Medicacion_Tomada` TINYINT NULL,
  `Paciente_NIF` INT NOT NULL,
  PRIMARY KEY (`idLectura`),
  INDEX `fk_Lectura_Paciente_idx` (`Paciente_NIF` ASC) VISIBLE,
  CONSTRAINT `fk_Lectura_Paciente`
    FOREIGN KEY (`Paciente_NIF`)
    REFERENCES `iw_tfa`.`Paciente` (`NIF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `iw_tfa`.`Medico`
-- -----------------------------------------------------
START TRANSACTION;
USE `iw_tfa`;
INSERT INTO `iw_tfa`.`Medico` (`NIF`, `Nombre`, `Apellidos`, `Email`, `Password`, `Hospital`, `Consulta`, `Horario_Atencion`, `Telefono`) VALUES (1000001, 'Oriol', 'Paz Tercero', 'm1@gmail.com', 'sha256$MvL4aH9VwluDMo3r$0fbce479f4134afe1f87770ad4adf5ce66dfd26566f37383af086b6d907d8068', 'Hospital Civil', 'Consulta 1', 'L-V 8:00-16:00', '667100001');
INSERT INTO `iw_tfa`.`Medico` (`NIF`, `Nombre`, `Apellidos`, `Email`, `Password`, `Hospital`, `Consulta`, `Horario_Atencion`, `Telefono`) VALUES (1000002, 'Amparo', 'Luján', 'm2@gmail.com', 'sha256$MvL4aH9VwluDMo3r$0fbce479f4134afe1f87770ad4adf5ce66dfd26566f37383af086b6d907d8068', 'Hospital Civil', 'Consulta 2', 'L-V 8:00-16:00', '667100002');
INSERT INTO `iw_tfa`.`Medico` (`NIF`, `Nombre`, `Apellidos`, `Email`, `Password`, `Hospital`, `Consulta`, `Horario_Atencion`, `Telefono`) VALUES (1000003, 'Eric', 'Quiñónez', 'm3@gmail.com', 'sha256$MvL4aH9VwluDMo3r$0fbce479f4134afe1f87770ad4adf5ce66dfd26566f37383af086b6d907d8068', 'Hospital Civil', 'Consulta 3', 'L-V 8:00-16:00', '667100003');
INSERT INTO `iw_tfa`.`Medico` (`NIF`, `Nombre`, `Apellidos`, `Email`, `Password`, `Hospital`, `Consulta`, `Horario_Atencion`, `Telefono`) VALUES (1000004, 'Paula', 'Valdez Segundo', 'm4@gmail.com', 'sha256$MvL4aH9VwluDMo3r$0fbce479f4134afe1f87770ad4adf5ce66dfd26566f37383af086b6d907d8068', 'Hospital Clínico', 'Consulta 1', 'L-V 8:00-16:00', '667100004');
INSERT INTO `iw_tfa`.`Medico` (`NIF`, `Nombre`, `Apellidos`, `Email`, `Password`, `Hospital`, `Consulta`, `Horario_Atencion`, `Telefono`) VALUES (1000005, 'María Ángeles', 'Pulido', 'm5@gmail.com', 'sha256$MvL4aH9VwluDMo3r$0fbce479f4134afe1f87770ad4adf5ce66dfd26566f37383af086b6d907d8068', 'Hospital Clínico', 'Consulta 2', 'L-S 10:00-18:00', '667100005');
INSERT INTO `iw_tfa`.`Medico` (`NIF`, `Nombre`, `Apellidos`, `Email`, `Password`, `Hospital`, `Consulta`, `Horario_Atencion`, `Telefono`) VALUES (1000006, 'Margarita', 'Tejada Segundo', 'm6@gmail.com', 'sha256$MvL4aH9VwluDMo3r$0fbce479f4134afe1f87770ad4adf5ce66dfd26566f37383af086b6d907d8068', 'Hospital Clínico', 'Consulta 3', 'L-V 8:00-16:00', '667100006');
INSERT INTO `iw_tfa`.`Medico` (`NIF`, `Nombre`, `Apellidos`, `Email`, `Password`, `Hospital`, `Consulta`, `Horario_Atencion`, `Telefono`) VALUES (1000007, 'Ian', 'De Anda', 'm7@gmail.com', 'sha256$MvL4aH9VwluDMo3r$0fbce479f4134afe1f87770ad4adf5ce66dfd26566f37383af086b6d907d8068', 'Hospital Clínico', 'Consulta 2', 'L-V 8:00-16:00', '667100007');
INSERT INTO `iw_tfa`.`Medico` (`NIF`, `Nombre`, `Apellidos`, `Email`, `Password`, `Hospital`, `Consulta`, `Horario_Atencion`, `Telefono`) VALUES (1000008, 'Eduardo', 'Cornejo Segundo', 'm8@gmail.com', 'sha256$MvL4aH9VwluDMo3r$0fbce479f4134afe1f87770ad4adf5ce66dfd26566f37383af086b6d907d8068', 'Hospital El Ángel', 'Consulta 5', 'L-V 16:00-22:00', '667100008');
INSERT INTO `iw_tfa`.`Medico` (`NIF`, `Nombre`, `Apellidos`, `Email`, `Password`, `Hospital`, `Consulta`, `Horario_Atencion`, `Telefono`) VALUES (1000009, 'Carlos', 'Puga', 'm9@gmail.com', 'sha256$MvL4aH9VwluDMo3r$0fbce479f4134afe1f87770ad4adf5ce66dfd26566f37383af086b6d907d8068', 'Hospital El Ángel', 'Consulta 8', 'L-V 8:00-16:00', '667100009');
INSERT INTO `iw_tfa`.`Medico` (`NIF`, `Nombre`, `Apellidos`, `Email`, `Password`, `Hospital`, `Consulta`, `Horario_Atencion`, `Telefono`) VALUES (1000010, 'Yeray', 'Armas Segundo', 'm10@gmail.com', 'sha256$MvL4aH9VwluDMo3r$0fbce479f4134afe1f87770ad4adf5ce66dfd26566f37383af086b6d907d8068', 'Hospital El Ángel', 'Consulta 3', 'L-V 8:00-16:00', '667100010');

COMMIT;


-- -----------------------------------------------------
-- Data for table `iw_tfa`.`Paciente`
-- -----------------------------------------------------
START TRANSACTION;
USE `iw_tfa`;
INSERT INTO `iw_tfa`.`Paciente` (`NIF`, `Nombre`, `Apellidos`, `Fecha_Nacimiento`, `Email`, `Telefono`, `Altura`, `Peso`, `Password`, `Medico_NIF`) VALUES (0000001, 'Jordi', 'Pineda Hijo', '2000-01-01', 'p1@gmail.com', '667000001', 180, 78, 'sha256$v0S44529ArGcrLNa$874179494ea3adf47ee0553d4ff9955e87df83cc5d4d7b27f476dab8dab23b5c', 1000001);
INSERT INTO `iw_tfa`.`Paciente` (`NIF`, `Nombre`, `Apellidos`, `Fecha_Nacimiento`, `Email`, `Telefono`, `Altura`, `Peso`, `Password`, `Medico_NIF`) VALUES (0000002, 'Alexandra', 'Segovia', '2001-01-01', 'p2@gmail.com', '667000002', 175, 82, 'sha256$v0S44529ArGcrLNa$874179494ea3adf47ee0553d4ff9955e87df83cc5d4d7b27f476dab8dab23b5c', 1000001);
INSERT INTO `iw_tfa`.`Paciente` (`NIF`, `Nombre`, `Apellidos`, `Fecha_Nacimiento`, `Email`, `Telefono`, `Altura`, `Peso`, `Password`, `Medico_NIF`) VALUES (0000003, 'Encarnación', 'Rosado', '2976-01-01', 'p3@gmail.com', '667000003', 169, 104, 'sha256$v0S44529ArGcrLNa$874179494ea3adf47ee0553d4ff9955e87df83cc5d4d7b27f476dab8dab23b5c', 1000001);
INSERT INTO `iw_tfa`.`Paciente` (`NIF`, `Nombre`, `Apellidos`, `Fecha_Nacimiento`, `Email`, `Telefono`, `Altura`, `Peso`, `Password`, `Medico_NIF`) VALUES (0000004, 'César', 'Castellanos', '1999-01-01', 'p4@gmail.com', '667000004', 181, 67, 'sha256$v0S44529ArGcrLNa$874179494ea3adf47ee0553d4ff9955e87df83cc5d4d7b27f476dab8dab23b5c', 1000001);
INSERT INTO `iw_tfa`.`Paciente` (`NIF`, `Nombre`, `Apellidos`, `Fecha_Nacimiento`, `Email`, `Telefono`, `Altura`, `Peso`, `Password`, `Medico_NIF`) VALUES (0000005, 'Jan', 'Soliz', '1965-01-01', 'p5@gmail.com', '667000005', 178, 83, 'sha256$v0S44529ArGcrLNa$874179494ea3adf47ee0553d4ff9955e87df83cc5d4d7b27f476dab8dab23b5c', 1000001);
INSERT INTO `iw_tfa`.`Paciente` (`NIF`, `Nombre`, `Apellidos`, `Fecha_Nacimiento`, `Email`, `Telefono`, `Altura`, `Peso`, `Password`, `Medico_NIF`) VALUES (0000006, 'Mara', 'Bermúdez', '1987-01-01', 'p6@gmail.com', '667000006', 156, 77, 'sha256$v0S44529ArGcrLNa$874179494ea3adf47ee0553d4ff9955e87df83cc5d4d7b27f476dab8dab23b5c', 1000001);
INSERT INTO `iw_tfa`.`Paciente` (`NIF`, `Nombre`, `Apellidos`, `Fecha_Nacimiento`, `Email`, `Telefono`, `Altura`, `Peso`, `Password`, `Medico_NIF`) VALUES (0000007, 'Ander', 'Bastia', '1988-01-01', 'p7@gmail.com', '667000007', 198, 73, 'sha256$v0S44529ArGcrLNa$874179494ea3adf47ee0553d4ff9955e87df83cc5d4d7b27f476dab8dab23b5c', 1000001);
INSERT INTO `iw_tfa`.`Paciente` (`NIF`, `Nombre`, `Apellidos`, `Fecha_Nacimiento`, `Email`, `Telefono`, `Altura`, `Peso`, `Password`, `Medico_NIF`) VALUES (0000008, 'Ángela', 'Mena', '2003-01-01', 'p8@gmail.com', '667000008', 178, 75, 'sha256$v0S44529ArGcrLNa$874179494ea3adf47ee0553d4ff9955e87df83cc5d4d7b27f476dab8dab23b5c', 1000001);
INSERT INTO `iw_tfa`.`Paciente` (`NIF`, `Nombre`, `Apellidos`, `Fecha_Nacimiento`, `Email`, `Telefono`, `Altura`, `Peso`, `Password`, `Medico_NIF`) VALUES (0000009, 'Naiara', 'Soler', '2004-01-01', 'p9@gmail.com', '667000009', 175, 79, 'sha256$v0S44529ArGcrLNa$874179494ea3adf47ee0553d4ff9955e87df83cc5d4d7b27f476dab8dab23b5c', 1000001);
INSERT INTO `iw_tfa`.`Paciente` (`NIF`, `Nombre`, `Apellidos`, `Fecha_Nacimiento`, `Email`, `Telefono`, `Altura`, `Peso`, `Password`, `Medico_NIF`) VALUES (0000010, 'Jośe', 'Beltrán', '2002-01-01', 'p10@gmail.com', '667000010', 174, 86, 'sha256$v0S44529ArGcrLNa$874179494ea3adf47ee0553d4ff9955e87df83cc5d4d7b27f476dab8dab23b5c', 1000001);

COMMIT;


-- -----------------------------------------------------
-- Data for table `iw_tfa`.`Receta`
-- -----------------------------------------------------
START TRANSACTION;
USE `iw_tfa`;
INSERT INTO `iw_tfa`.`Receta` (`idReceta`, `Fecha_Inicio`, `Fecha_Fin`, `Medicamento`, `Principio_Activo`, `Posologia`, `Paciente_NIF`, `Medico_NIF`) VALUES (DEFAULT, '2022-02-12', '2023-02-12', 'Balzak 40mg/5mg', 'Olmesartán medoxomilo/Amlodipino', '1 pastilla por la mañana', 0000001, 1000001);
INSERT INTO `iw_tfa`.`Receta` (`idReceta`, `Fecha_Inicio`, `Fecha_Fin`, `Medicamento`, `Principio_Activo`, `Posologia`, `Paciente_NIF`, `Medico_NIF`) VALUES (DEFAULT, '2022-02-12', '2023-02-12', 'Enalapril 20mg', 'Enalapril maleato', '1 pastilla por la noche', 0000001, 1000001);
INSERT INTO `iw_tfa`.`Receta` (`idReceta`, `Fecha_Inicio`, `Fecha_Fin`, `Medicamento`, `Principio_Activo`, `Posologia`, `Paciente_NIF`, `Medico_NIF`) VALUES (DEFAULT, '2021-02-19', '2022-02-26', 'Diazepam', 'Diazepam', '1 pastilla cuando necesite', 0000001, 1000001);
INSERT INTO `iw_tfa`.`Receta` (`idReceta`, `Fecha_Inicio`, `Fecha_Fin`, `Medicamento`, `Principio_Activo`, `Posologia`, `Paciente_NIF`, `Medico_NIF`) VALUES (DEFAULT, '2021-02-12', '2023-02-12', 'Balzak 40mg/5mg', 'Olmesartán medoxomilo/Amlodipino', '1 pastilla por la tarde', 0000002, 1000001);
INSERT INTO `iw_tfa`.`Receta` (`idReceta`, `Fecha_Inicio`, `Fecha_Fin`, `Medicamento`, `Principio_Activo`, `Posologia`, `Paciente_NIF`, `Medico_NIF`) VALUES (DEFAULT, '2021-02-12', '2023-02-12', 'Enalapril 20mg', 'Enalapril maleato', '1 pastilla por la noche', 0000003, 1000001);
INSERT INTO `iw_tfa`.`Receta` (`idReceta`, `Fecha_Inicio`, `Fecha_Fin`, `Medicamento`, `Principio_Activo`, `Posologia`, `Paciente_NIF`, `Medico_NIF`) VALUES (DEFAULT, '2021-02-19', '2022-02-26', 'Diazepam', 'Diazepam', '1 pastilla por la mañana', 0000003, 1000001);
INSERT INTO `iw_tfa`.`Receta` (`idReceta`, `Fecha_Inicio`, `Fecha_Fin`, `Medicamento`, `Principio_Activo`, `Posologia`, `Paciente_NIF`, `Medico_NIF`) VALUES (DEFAULT, '2021-01-12', '2023-02-12', 'Balzak 40mg/5mg', 'Olmesartán medoxomilo/Amlodipino', '1 pastilla por la tarde', 0000004, 1000001);
INSERT INTO `iw_tfa`.`Receta` (`idReceta`, `Fecha_Inicio`, `Fecha_Fin`, `Medicamento`, `Principio_Activo`, `Posologia`, `Paciente_NIF`, `Medico_NIF`) VALUES (DEFAULT, '2021-02-12', '2023-02-12', 'Enalapril 20mg', 'Enalapril maleato', '1 pastilla por la noche', 0000004, 1000001);
INSERT INTO `iw_tfa`.`Receta` (`idReceta`, `Fecha_Inicio`, `Fecha_Fin`, `Medicamento`, `Principio_Activo`, `Posologia`, `Paciente_NIF`, `Medico_NIF`) VALUES (DEFAULT, '2021-01-19', '2022-02-26', 'Diazepam', 'Diazepam', '1 pastilla por la mañana', 0000006, 1000001);
INSERT INTO `iw_tfa`.`Receta` (`idReceta`, `Fecha_Inicio`, `Fecha_Fin`, `Medicamento`, `Principio_Activo`, `Posologia`, `Paciente_NIF`, `Medico_NIF`) VALUES (DEFAULT, '2021-02-12', '2023-02-12', 'Balzak 40mg/5mg', 'Olmesartán medoxomilo/Amlodipino', '1 pastilla por la tarde', 0000007, 1000001);
INSERT INTO `iw_tfa`.`Receta` (`idReceta`, `Fecha_Inicio`, `Fecha_Fin`, `Medicamento`, `Principio_Activo`, `Posologia`, `Paciente_NIF`, `Medico_NIF`) VALUES (DEFAULT, '2021-03-12', '2023-02-12', 'Enalapril 20mg', 'Enalapril maleato', '1 pastilla por la noche', 0000007, 1000001);
INSERT INTO `iw_tfa`.`Receta` (`idReceta`, `Fecha_Inicio`, `Fecha_Fin`, `Medicamento`, `Principio_Activo`, `Posologia`, `Paciente_NIF`, `Medico_NIF`) VALUES (DEFAULT, '2021-02-19', '2022-02-26', 'Diazepam', 'Diazepam', '1 pastilla por la mañana', 0000007, 1000001);
INSERT INTO `iw_tfa`.`Receta` (`idReceta`, `Fecha_Inicio`, `Fecha_Fin`, `Medicamento`, `Principio_Activo`, `Posologia`, `Paciente_NIF`, `Medico_NIF`) VALUES (DEFAULT, '2021-03-12', '2023-02-12', 'Balzak 40mg/5mg', 'Olmesartán medoxomilo/Amlodipino', '1 pastilla por la tarde', 0000008, 1000001);
INSERT INTO `iw_tfa`.`Receta` (`idReceta`, `Fecha_Inicio`, `Fecha_Fin`, `Medicamento`, `Principio_Activo`, `Posologia`, `Paciente_NIF`, `Medico_NIF`) VALUES (DEFAULT, '2022-02-12', '2023-02-12', 'Enalapril 20mg', 'Enalapril maleato', '1 pastilla por la noche', 0000009, 1000001);
INSERT INTO `iw_tfa`.`Receta` (`idReceta`, `Fecha_Inicio`, `Fecha_Fin`, `Medicamento`, `Principio_Activo`, `Posologia`, `Paciente_NIF`, `Medico_NIF`) VALUES (DEFAULT, '2022-02-19', '2022-02-26', 'Diazepam', 'Diazepam', '1 pastilla por la mañana', 0000010, 1000001);

COMMIT;


-- -----------------------------------------------------
-- Data for table `iw_tfa`.`Lectura`
-- -----------------------------------------------------
START TRANSACTION;
USE `iw_tfa`;
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-18 21:56:00', 125, 80, 87, NULL, NULL, 1, 0000001);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-19 21:56:00', 143, 85, 87, 'Dolor de cabeza', NULL, 1, 0000001);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-20 21:56:00', 134, 75, 87, 'Malestar', NULL, 1, 0000001);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-18 21:56:00', 138, 67, 87, NULL, NULL, 1, 0000002);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-19 21:56:00', 143, 85, 87, 'Dolor de cabeza', NULL, 0, 0000002);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-20 21:56:00', 134, 75, 87, NULL, NULL, 1, 0000002);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-18 21:56:00', 126, 86, 87, NULL, NULL, 0, 0000003);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-17 21:56:00', 143, 85, 87, NULL, 'Nota de ejemplo', 0, 0000003);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-16 21:56:00', 134, 75, 87, NULL, NULL, 1, 0000003);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-15 21:56:00', 125, 80, 87, NULL, NULL, 1, 0000003);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-14 21:56:00', 143, 85, 87, NULL, NULL, 1, 0000003);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-13 21:56:00', 134, 75, 87, NULL, NULL, 0, 0000003);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-18 21:56:00', 125, 80, 87, NULL, NULL, 1, 0000004);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-17 21:56:00', 143, 85, 87, 'Dolor de cabeza', NULL, 1, 0000004);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-16 21:56:00', 134, 75, 87, NULL, NULL, 1, 0000004);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-15 21:56:00', 125, 80, 87, NULL, NULL, 1, 0000004);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-14 21:56:00', 143, 85, 87, NULL, NULL, 1, 0000004);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-13 21:56:00', 134, 75, 87, 'Malestar', NULL, 0, 0000004);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-18 21:56:00', 127, 79, 87, NULL, NULL, 1, 0000005);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-17 21:56:00', 143, 85, 87, 'Dolor de cabeza', NULL, 0, 0000005);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-16 21:56:00', 134, 75, 87, NULL, NULL, 0, 0000005);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-15 21:56:00', 125, 80, 87, NULL, NULL, 1, 0000005);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-14 21:56:00', 143, 85, 87, 'Dolor de cabeza', NULL, 1, 0000005);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-13 21:56:00', 134, 75, 87, NULL, NULL, 1, 0000005);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-18 21:56:00', 125, 80, 87, NULL, NULL, 1, 0000006);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-17 21:56:00', 143, 85, 87, 'Dolor de cabeza', NULL, 0, 0000006);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-16 21:56:00', 134, 75, 87, NULL, NULL, 1, 0000006);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-15 21:56:00', 125, 80, 87, NULL, NULL, 1, 0000006);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-14 21:56:00', 143, 85, 87, 'Dolor de cabeza', NULL, 1, 0000006);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-13 21:56:00', 134, 75, 87, NULL, NULL, 1, 0000006);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-18 21:56:00', 156, 92, 87, NULL, NULL, 1, 0000007);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-17 21:56:00', 143, 85, 87, 'Dolor de cabeza', NULL, 1, 0000007);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-16 21:56:00', 134, 75, 87, NULL, NULL, 1, 0000007);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-15 21:56:00', 125, 80, 87, NULL, NULL, 1, 0000007);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-14 21:56:00', 143, 85, 87, NULL, NULL, 1, 0000007);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-13 21:56:00', 134, 75, 87, NULL, NULL, 1, 0000007);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-18 21:56:00', 138, 78, 87, NULL, NULL, 1, 0000008);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-17 21:56:00', 143, 85, 87, 'Dolor de cabeza', NULL, 1, 0000008);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-16 21:56:00', 134, 75, 87, NULL, NULL, 1, 0000008);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-15 21:56:00', 125, 80, 87, NULL, NULL, 1, 0000008);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-14 21:56:00', 143, 85, 87, 'Dolor de cabeza', NULL, 1, 0000008);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-13 21:56:00', 134, 75, 87, NULL, NULL, 1, 0000008);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-18 21:56:00', 143, 81, 87, NULL, NULL, 1, 0000009);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-17 21:56:00', 143, 85, 87, 'Dolor de cabeza', NULL, 1, 0000009);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-16 21:56:00', 134, 75, 87, NULL, NULL, 1, 0000009);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-15 21:56:00', 125, 80, 87, NULL, NULL, 1, 0000009);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-14 21:56:00', 143, 85, 87, 'Dolor de cabeza', NULL, 0, 0000009);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-13 21:56:00', 134, 75, 87, NULL, NULL, 0, 0000009);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-18 21:56:00', 129, 82, 87, NULL, NULL, 0, 0000010);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-17 21:56:00', 143, 85, 87, 'Dolor de cabeza', NULL, 1, 0000010);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-16 21:56:00', 134, 75, 87, NULL, NULL, 1, 0000010);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-15 21:56:00', 125, 80, 87, NULL, NULL, 1, 0000010);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-14 21:56:00', 143, 85, 87, 'Dolor de cabeza', NULL, 1, 0000010);
INSERT INTO `iw_tfa`.`Lectura` (`idLectura`, `Fecha_Hora`, `TA_Sistolica`, `TA_Diastolica`, `PPM`, `Notas`, `Notas_medico`, `Medicacion_Tomada`, `Paciente_NIF`) VALUES (DEFAULT, '2022-02-13 21:56:00', 134, 75, 87, NULL, NULL, 1, 0000010);

COMMIT;

