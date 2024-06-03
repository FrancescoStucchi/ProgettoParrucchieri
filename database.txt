-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versione server:              10.4.27-MariaDB - mariadb.org binary distribution
-- S.O. server:                  Win64
-- HeidiSQL Versione:            12.3.0.6589
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dump della struttura del database parrucchieridb
CREATE DATABASE IF NOT EXISTS `parrucchieridb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `parrucchieridb`;

-- Dump della struttura di tabella parrucchieridb.appuntamenti
CREATE TABLE IF NOT EXISTS `appuntamenti` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data` date NOT NULL,
  `durata` time NOT NULL,
  `ora` time NOT NULL,
  `id_cliente` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_id_cliente` (`id_cliente`),
  CONSTRAINT `FK_id_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `clienti` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dump dei dati della tabella parrucchieridb.appuntamenti: ~5 rows (circa)
INSERT INTO `appuntamenti` (`id`, `data`, `durata`, `ora`, `id_cliente`) VALUES
	(9, '0245-05-31', '00:30:00', '08:00:00', 13),
	(14, '2024-06-01', '01:30:00', '13:00:00', 14),
	(15, '2024-06-01', '01:30:00', '08:00:00', 14),
	(16, '2024-06-01', '00:40:00', '15:00:00', 14),
	(17, '2024-05-31', '02:00:00', '13:00:00', 13);

-- Dump della struttura di tabella parrucchieridb.capacita
CREATE TABLE IF NOT EXISTS `capacita` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_servizio` int(11) NOT NULL,
  `id_parrucchiere` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_id_parrucchiere` (`id_parrucchiere`,`id_servizio`) USING BTREE,
  KEY `FK_id_servizio` (`id_servizio`),
  CONSTRAINT `FK_id_parrucchiere` FOREIGN KEY (`id_parrucchiere`) REFERENCES `parrucchieri` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_id_servizio` FOREIGN KEY (`id_servizio`) REFERENCES `servizi` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dump dei dati della tabella parrucchieridb.capacita: ~25 rows (circa)
INSERT INTO `capacita` (`id`, `id_servizio`, `id_parrucchiere`) VALUES
	(76, 1, 16),
	(77, 2, 16),
	(78, 3, 16),
	(79, 4, 16),
	(80, 5, 16),
	(81, 6, 16),
	(82, 7, 16),
	(56, 1, 17),
	(57, 2, 17),
	(58, 3, 17),
	(59, 7, 17),
	(71, 1, 18),
	(72, 3, 18),
	(73, 4, 18),
	(74, 5, 18),
	(75, 6, 18),
	(47, 1, 19),
	(48, 2, 19),
	(49, 3, 19),
	(50, 5, 19),
	(42, 1, 20),
	(43, 3, 20),
	(44, 5, 20),
	(45, 6, 20),
	(46, 7, 20);

-- Dump della struttura di tabella parrucchieridb.clienti
CREATE TABLE IF NOT EXISTS `clienti` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL DEFAULT '',
  `cognome` varchar(50) NOT NULL DEFAULT '',
  `telefono` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dump dei dati della tabella parrucchieridb.clienti: ~1 rows (circa)
INSERT INTO `clienti` (`id`, `nome`, `cognome`, `telefono`) VALUES
	(13, 'Berenice', 'Di Grecia', '3335428456'),
	(14, 'Chiara', 'Schiavo', '7594548923');

-- Dump della struttura di tabella parrucchieridb.impegno
CREATE TABLE IF NOT EXISTS `impegno` (
  `id_impegno` int(11) NOT NULL AUTO_INCREMENT,
  `id_parrucchiere` int(11) NOT NULL,
  `id_servizio` int(11) NOT NULL,
  `id_appuntamento` int(11) NOT NULL,
  PRIMARY KEY (`id_impegno`) USING BTREE,
  KEY `FK_ha_parrucchieri` (`id_parrucchiere`),
  KEY `FK_ha_servizio` (`id_servizio`),
  KEY `FK_ha_appuntamento` (`id_appuntamento`),
  CONSTRAINT `FK_ha_appuntamento` FOREIGN KEY (`id_appuntamento`) REFERENCES `appuntamenti` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_ha_parrucchieri` FOREIGN KEY (`id_parrucchiere`) REFERENCES `parrucchieri` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_ha_servizio` FOREIGN KEY (`id_servizio`) REFERENCES `servizi` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dump dei dati della tabella parrucchieridb.impegno: ~4 rows (circa)
INSERT INTO `impegno` (`id_impegno`, `id_parrucchiere`, `id_servizio`, `id_appuntamento`) VALUES
	(6, 16, 1, 9),
	(11, 16, 4, 14),
	(12, 18, 4, 15),
	(13, 17, 2, 16),
	(14, 18, 5, 17);

-- Dump della struttura di tabella parrucchieridb.parrucchieri
CREATE TABLE IF NOT EXISTS `parrucchieri` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `cognome` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `telefono` varchar(50) NOT NULL,
  `id_sede` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_id_sede` (`id_sede`),
  CONSTRAINT `FK_id_sede` FOREIGN KEY (`id_sede`) REFERENCES `sedi` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dump dei dati della tabella parrucchieridb.parrucchieri: ~4 rows (circa)
INSERT INTO `parrucchieri` (`id`, `nome`, `cognome`, `username`, `password`, `telefono`, `id_sede`) VALUES
	(16, 'Giuseppe ', 'De Pietro', 'Pino32', 'password', '4756473845', 20),
	(17, 'Luca', 'Verdi', 'Lucaverdi', 'password', '5465432345', 20),
	(18, 'Marco', 'Rossi', 'Marcorossi', 'password', '8573527367', 20),
	(19, 'Davide', 'Parrotta', 'davideparro', 'password', '3334274384', 1),
	(20, 'Claudio', 'Scaramucci', 'scaraclaudio', 'password', '3847564397', 1);

-- Dump della struttura di tabella parrucchieridb.sedi
CREATE TABLE IF NOT EXISTS `sedi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citta` varchar(50) NOT NULL,
  `cap` varchar(50) NOT NULL,
  `via` varchar(50) NOT NULL,
  `civico` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dump dei dati della tabella parrucchieridb.sedi: ~3 rows (circa)
INSERT INTO `sedi` (`id`, `citta`, `cap`, `via`, `civico`) VALUES
	(1, 'Asso', '22033', 'Via Dorella', '66'),
	(20, 'Lecco', '23900', 'Via Alssandro Manzoni', '88'),
	(24, 'pasturo', '23818', 'via cariole', '2');

-- Dump della struttura di tabella parrucchieridb.segretari
CREATE TABLE IF NOT EXISTS `segretari` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL DEFAULT '',
  `cognome` varchar(50) NOT NULL DEFAULT '',
  `username` varchar(50) NOT NULL DEFAULT '',
  `password` varchar(50) NOT NULL DEFAULT '',
  `telefono` varchar(50) NOT NULL DEFAULT '',
  `tipo` bit(1) NOT NULL,
  `id_sede` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_id_sede` (`id_sede`),
  CONSTRAINT `FK_id_sede` FOREIGN KEY (`id_sede`) REFERENCES `sedi` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dump dei dati della tabella parrucchieridb.segretari: ~3 rows (circa)
INSERT INTO `segretari` (`id`, `nome`, `cognome`, `username`, `password`, `telefono`, `tipo`, `id_sede`) VALUES
	(3, 'admin', 'admin', 'admin', 'a', '9999', b'1', NULL),
	(8, 'Claudio', 'Bonci', 'cbonci', 'a', '366', b'0', 20),
	(9, 'Davide', 'Falzetta', 'falze', 'password', '4783754893', b'0', 1);

-- Dump della struttura di tabella parrucchieridb.servizi
CREATE TABLE IF NOT EXISTS `servizi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(50) NOT NULL DEFAULT '',
  `prezzo` float NOT NULL DEFAULT 0,
  `durata` time NOT NULL DEFAULT '00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56536 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dump dei dati della tabella parrucchieridb.servizi: ~7 rows (circa)
INSERT INTO `servizi` (`id`, `tipo`, `prezzo`, `durata`) VALUES
	(1, 'taglio uomo', 10, '00:30:00'),
	(2, 'taglio donna', 20, '00:40:00'),
	(3, 'tinta', 20, '01:00:00'),
	(4, 'taglio+tinta', 30, '01:30:00'),
	(5, 'permanente', 50, '02:00:00'),
	(6, 'piega', 15, '00:35:00'),
	(7, 'trucco', 35, '00:40:00');

-- Dump della struttura di tabella parrucchieridb.svolge
CREATE TABLE IF NOT EXISTS `svolge` (
  `id_turno` int(11) NOT NULL,
  `id_parrucchiere` int(11) NOT NULL,
  PRIMARY KEY (`id_turno`,`id_parrucchiere`),
  KEY `FK_parrucchiere` (`id_parrucchiere`),
  CONSTRAINT `FK_parrucchiere` FOREIGN KEY (`id_parrucchiere`) REFERENCES `parrucchieri` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_turno` FOREIGN KEY (`id_turno`) REFERENCES `turni` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dump dei dati della tabella parrucchieridb.svolge: ~37 rows (circa)
INSERT INTO `svolge` (`id_turno`, `id_parrucchiere`) VALUES
	(3, 16),
	(3, 17),
	(3, 18),
	(3, 19),
	(4, 19),
	(5, 16),
	(5, 17),
	(5, 18),
	(5, 19),
	(5, 20),
	(6, 17),
	(6, 20),
	(7, 16),
	(7, 18),
	(7, 19),
	(7, 20),
	(8, 16),
	(8, 19),
	(9, 16),
	(9, 17),
	(9, 19),
	(10, 18),
	(10, 19),
	(10, 20),
	(11, 16),
	(11, 18),
	(11, 19),
	(12, 18),
	(12, 20),
	(13, 17),
	(13, 18),
	(13, 20),
	(14, 16),
	(14, 17),
	(14, 18),
	(14, 19),
	(14, 20);

-- Dump della struttura di tabella parrucchieridb.turni
CREATE TABLE IF NOT EXISTS `turni` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `giorno` varchar(50) NOT NULL DEFAULT '',
  `ora_inizio` time NOT NULL,
  `ora_fine` time NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dump dei dati della tabella parrucchieridb.turni: ~12 rows (circa)
INSERT INTO `turni` (`id`, `giorno`, `ora_inizio`, `ora_fine`) VALUES
	(1, 'SUNDAY', '08:00:00', '12:00:00'),
	(2, 'SUNDAY', '13:00:00', '18:00:00'),
	(3, 'MONDAY', '08:00:00', '12:00:00'),
	(4, 'MONDAY', '13:00:00', '18:00:00'),
	(5, 'TUESDAY', '08:00:00', '12:00:00'),
	(6, 'TUESDAY', '13:00:00', '18:00:00'),
	(7, 'WEDNESDAY', '08:00:00', '12:00:00'),
	(8, 'WEDNESDAY', '13:00:00', '18:00:00'),
	(9, 'THURSDAY', '08:00:00', '12:00:00'),
	(10, 'THURSDAY', '13:00:00', '18:00:00'),
	(11, 'FRIDAY', '08:00:00', '12:00:00'),
	(12, 'FRIDAY', '13:00:00', '18:00:00'),
	(13, 'SATURDAY', '08:00:00', '12:00:00'),
	(14, 'SATURDAY', '13:00:00', '18:00:00');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
