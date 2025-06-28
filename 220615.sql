SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT=0;
START TRANSACTION;

USE `jasperjob`;

DROP TABLE IF EXISTS `gba_straﬂenreinigung`;
CREATE TABLE `gba_straﬂenreinigung` (
`row_id` int(10) unsigned NOT NULL AUTO_INCREMENT ,
`OBS` text NULL,
`GKZ` text NULL,
`ARTSL` text NULL,
`ZUGANG` text NULL,
`ABGANG` text NULL,
`DIFFERENZ` text NULL,
PRIMARY KEY (`row_id`)
) AUTO_INCREMENT=1;

INSERT INTO `gba_straﬂenreinigung` (
`OBS` ,
`GKZ` ,
`ARTSL` ,
`ZUGANG` ,
`ABGANG` ,
`DIFFERENZ` 
)
VALUES ('1',
'800',
'S1100',
'103,36',
'-103,36',
'0,00'
);
INSERT INTO `gba_straﬂenreinigung` (
`OBS` ,
`GKZ` ,
`ARTSL` ,
`ZUGANG` ,
`ABGANG` ,
`DIFFERENZ` 
)
VALUES ('2',
'800',
'S2100',
'323,46',
'-323,46',
'0,00'
);SET FOREIGN_KEY_CHECKS=1;
COMMIT;