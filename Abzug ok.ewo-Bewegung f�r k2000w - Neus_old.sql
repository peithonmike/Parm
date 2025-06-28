declare @Herr as nchar(04);
set @Herr = 'Herr';

declare @Frau as nchar(04);
set @Frau = 'Frau';

declare @ew as nchar(15);
set @ew = 'Einzige Wohnung';

declare @nw as nchar(13);
set @nw = 'Nebenwohnsitz';

declare @hw as nchar(13);
set @hw = 'Hauptwohnsitz';

declare @b as nchar(01);
set @b = '' ;

select 
isnull (b.famname, @b ) as Familienname, 
isnull (b.geb_name, @b )as Geburtsname,
isnull (b.rufname, @b ) as Rufname,
isnull (b.vorname, @b ) as Alle_Vornamen,
case b.geschl
  when 'm' then @Herr
  when 'w' then @Frau
    else @b
end 
as Anrede,
isnull(b.best_fname,@b ) as Namensbestandteile, 
isnull(b.akadgr,@b ) as Doktorgrad, 
b.gebdat as Geburtsdatum, 
b.famstand as Familienstand,
d.staang_txl as Staatsangehörigkeit,
@b as Telefon, @b as Fax, @b as Mail, @b as Verwandschaftsgrad,
case when a.ereig_dat
IS NOT NULL then CONVERT(varchar(10), ereig_dat, 104)
else @b
end
 as Ereignisdatum,
case when a.bearb_dat
IS NOT NULL then CONVERT(varchar(10), bearb_dat, 104)
else @b 
end
 as Meldedatum,
isnull(a.art, @b ) as Meldestatus,
isnull (s.nr_stat_la, @b ) as Straßenschlüssel,
isnull (e.strasse, @b ) as Straße, 
case when e.hausnr 
is not null then convert(varchar(4),e.hausnr)
else @b 
end
as Hausnummer,
isnull(e.buchstabe,@b ) as Buchstabe, 
e.objekt_nr as Wohnungsnummer, 
f.plz as Postleitzahl, 
f.ort as Ort,
g.geb_bezei as Ortsteil, 
g.gebiet_nr as Stadtteil,
g.gebiettyp as Stadtgebiet,
e.status as Wohnungsstatus_Schluessel,
case e.status
  when 'EW' then @ew
  when 'NW' then @nw
  when 'HW' then @hw
    else @b 
end 
as Wohnungsstatus,
--@b  as AStraßenschlüssel,
isnull (t.nr_stat_la, @b ) as AStraßenschlüssel,
isnull(i.strasse,@b ) as AStraße, 
case when i.hausnr 
is not null then convert(varchar(4),i.hausnr)
else @b --
end
as AHausnummer,
isnull(i.buchstabe,@b ) as ABuchstabe,
isnull(i.objekt_nr,@b ) as AWohnungsnummer, 
isnull(j.plz,@b ) as APostleitzahl, 
isnull(j.ort,@b ) as AOrt, @b  as AOrtsteil, @b  as AStadtteil, @b  as AStadtgebiet,
--
g.gs as AGS,
b.om as okewo_OM ,
isnull(b.ehe_om,@b ) as okewo_Ehe_OM, 
@b as Duis_Alt_PKZ

from 
e01e044 a inner join
e01e001 b on a.om = b.om and
(a.art = 'UMZ' or a.art = 'WGZ' or a.art = 'ZUZ' or a.art = 'GEB' or a.art = 'TOD')inner join 
e01e007 c on b.om = c.om inner join 
e01e257 d on c.staatang = d.staat inner join
e01e002 e on e.om = a.om inner join
e01e200 f on e.ort_nr = f.ort_nr inner join 
e01e203 g on g. gebiettyp = '101'inner join
e01e205 h on e.objekt_nr = h.objekt_nr and h.gebiettyp = g.gebiettyp and h.gebiet_nr = g.gebiet_nr inner join
e01e202 o on o.objekt_nr = h.objekt_nr /** and o.wohnungsbi is not null **/ inner join
e01e201 s on e.strasse = s.strasse and e.ort_nr = s.ort_nr left outer join 
e01e003 i on i.om = b.om and i.lfd_nr = (select max (lfd_nr) from e01e003 where e01e003.om = b.om)left outer join
e01e200 j on i.ort_nr = j.ort_nr left outer join
e01e201 t on i.strasse = t.strasse and i.ort_nr = t.ort_nr

--
-- Bearbeitungsdatumsintervall für Jobsteuerung
-- where a.bearb_dat between '01.01.2012' and '31.12.2012'
where a.bearb_dat between '@von' and '@bis'

--

union all

select 
isnull (b.famname, @b ) as Familienname, 
isnull (b.geb_name, @b )as Geburtsname,
isnull (b.rufname, @b ) as Rufname,
isnull (b.vorname, @b ) as Alle_Vornamen,
case b.geschl
  when 'm' then @Herr
  when 'w' then @Frau
    else @b 
end 
as Anrede,
isnull(b.best_fname,@b ) as Namensbestandteile, 
isnull(b.akadgr,@b ) as Doktorgrad, 
b.gebdat as Geburtsdatum, 
b.famstand as Familienstand,
--isnull (a.staang1, @b ) as Staatsangehörigkeit,
d.staang_txl as Staatsangehörigkeit,
--@b  as Staatsangehörigkeit,
@b  as Telefon, @b  as Fax,@b  as Mail, @b as Verwandschaftsgrad,
case when a.ereig_dat
IS NOT NULL then CONVERT(varchar(10), a.ereig_dat, 104)
else @b 
end
 as Ereignisdatum,
case when a.bearb_dat
IS NOT NULL then CONVERT(varchar(10), a.bearb_dat, 104)
else @b 
end
 as Meldedatum,
isnull(a.art, @b ) as Meldestatus,
@b  as Straßenschlüssel,
isnull (a.zw_strasse, @b ) as Straße, 
case when a.zw_hausnr 
is not null then convert(varchar(4),a.zw_hausnr)
else @b 
end
as Hausnummer,
@b  as Buchstabe, 
--case when e.objekt_nr
--is not null then convert(varchar(4),e.objekt_nr)
--else @b 
--end 
@b as Wohnungsnummer,
--e.objekt_nr as Wohnungsnummer, 
isnull (a.zw_plz, @b ) as Postleitzahl, 
isnull (a.zw_ort, @b ) as Ort,
@b  as Ortsteil, @b  as Stadtteil, @b  as Stadtgebiet,
isnull (a.zw_status, @b ) as Wohnungsstatus_Schluessel,
case a.zw_status
  when 'EW' then @ew
  when 'NW' then @nw
  when 'HW' then @hw
    else @b 
end 
as Wohnungsstatus,
--@b  as AStraßenschlüssel,
isnull (t.nr_stat_la, @b ) as AStraßenschlüssel,
isnull(i.strasse,@b ) as AStraße, 
case when i.hausnr 
is not null then convert(varchar(4),i.hausnr)
else @b 
end
as AHausnummer,
isnull(i.buchstabe,@b ) as ABuchstabe,
isnull(i.objekt_nr,@b ) as AWohnungsnummer, 
isnull(j.plz,@b ) as APostleitzahl, 
isnull(j.ort,@b ) as AOrt, 
g.geb_bezei as AOrtsteil, 
g.gebiet_nr as AStadtteil,
g.gebiettyp as AStadtgebiet,

--
case when a.zw_gs
is not null then convert (varchar(8),a.zw_gs)
else @b 
end
as AGS,
b.om as okewo_OM ,
isnull(b.ehe_om,@b ) as okewo_Ehe_OM, 
@b as Duis_Alt_PKZ

from 
e01e044 a inner join
e01e070 b on a.om = b.om and 
(a.art = 'WGZ'  or a.art = 'TOD')inner join 
--e01e007 c on b.om = c.om inner join 
e01e257 d on a.staang1 = d.staat inner join
e01e003 i on i.om = b.om and i.aktuell = 1 inner join
e01e200 j on i.ort_nr = j.ort_nr inner join
e01e201 t on i.strasse = t.strasse and i.ort_nr = t.ort_nr inner join
--
e01e203 g on g. gebiettyp = '101'inner join
e01e205 h on i.objekt_nr = h.objekt_nr and h.gebiettyp = g.gebiettyp and h.gebiet_nr = g.gebiet_nr inner join
e01e202 o on o.objekt_nr = h.objekt_nr 
--and o.wohnungsbi is not null
--
-- Bearbeitungsdatumsintervall für Jobsteuerung
-- where a.bearb_dat between '01.01.2012' and '31.12.2012'
where a.bearb_dat between '@von' and '@bis'

-- Ausgabedatei

-- -o c:\CTM_AV\Sysout\okewo.txt