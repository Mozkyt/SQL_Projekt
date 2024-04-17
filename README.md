Kontakt na discordu: pepa_73062

Josef Ženka – SQL projekt – průvodní listina
Primární tabulka: 
Tady šlo o spojení platů a cen, respektive potřeboval jsem průměrný plat za profesi/rok a cenu za rok/komoditu. Nejprve jsem to zkoušel za použití Selectu a nakonec přešel k CTE.
V prvním with jsem spočítal průměrný plat za jednotlivou profesní oblast s omezením na řádku na příslušný kód a pomocí group by ho seskupil podle roku a profese. V druhém withu jsem totéž udělal s průměrnou cenou, omezil na to, kde je kód regionu NULL (tj. celá země) a opět seskupil pomocí roku a profese. Navíc jsem si chtěl ještě spočítat, z jakých hodnot se počítá průměrná cena potravin, nicméně samotný sloupec, přestože v tabulce zůstal, nakonec po důkladném prozkoumání dat nebyl použit.
Následně jsem pomocí selectu vybral příslušné relevantní údaje a spojil obě dočasně vytvořené tabulky a seskupil podle let. Počet řádků odpovídá.


Sekundární tabulka – byla nutná ke splnění pátého úkolu. 
Tady jsem zvolil postup s použitím CTE a self joinu, k výpočtu růstu GDP (standardní vzorec pro procentuální nárůst). Ještě jsem to omezil rokem 2020, což je poslední rok, pro něž ještě jdou použít nějaká data. Počáteční rok jsem nestanovoval a nechal null hodnoty – stejně se s nimi totiž pak v cvičení 5 nepočítá.
V druhé fázi jsem si ještě za pomoci Case expression  přidělal ještě jeden sloupec pro lepší orientaci (kterou jsem nakonec ale nepoužil, leč pro odevzdání si ho tam nechal). Vzhledem k tomu, že v zadání bylo, že máme použít obě tabulky (economies a countries), tak jsem ještě přemýšlel, jak spojit Czechia a Czech Republic. Nakonec to udělal pomocí Case expression (teda metodou pokus/omyl). Nakonec jsem CTE nechal připojit dočasnou tabulku a odfiltroval výsledky na Czech republic a seřadil.
Pro úkoly 1 až 4 byla použita základní tabulka, pro 5. úkol pak kombinovány obě tabulky dohromady. 

1. úkol.
	Tady jsem si potřeboval spojit self joinem tabulku, abych vedle sebe postavil hodnotu za minulý a probíhající rok a pomocí case expression dodělat sloupec, který označí, zda šlo o nárůst či pokles. Následnou filtrací jsem pak nechal pouze viditelné výsledky, kde došlo k poklesu, abych mohl zodpovědět na otázku zda všechny rostou, poté udělal další, kde se mi to seřadilo. Pak jsem se pokoušel vymyslet, jak docílit toho, aby mi to odfiltrovalo jen ty, kde je pořád růst. Toho jsem nakonec, po velkém zkoušení metodou pokus omyl docílil zapojením funkce min a připojením klausule having, která společně s group by dává žádoucí výsledek. 
 
2. úkol 
Jednoduchý select omezený wherem na konkrétní produkty a koncovými roky (2006 a 2018 – pro oba jsou k dispozici kompletní údaje, jakkoli u jednoho v 50 záznamech tak u druhého ve 12). 
Nakonec jsem to seskupil pomocí roku produktu a profese a zaokrouhlil na dvě desetinná místa. Tady jsem poprvé musel čelit otázce, co je údaj průměrný plat a došel k tomu, že ho nelze zprůměrovat ne jedinou hodnotu (neznámý počet zaměstnanců, neúplnost údajů) a proto vždy počítal možnost zakoupení zboží podle dané profese. 

3. úkol 
Tady bylo třeba zjistit, jaký je průměrný růst ceny u každé potraviny. Zase self join, výpočet průměru, seskupení podle jména a seřazení;

4. úkol 
Tady bylo potřeba vypočítat průměrný cenový nárůst a průměrný platový nárůst (standardně za pomoci selfjoinu) a následně pomocí case expression dohledat zda někde byl nárůst o více než deset. Tady jsem pořádně měl errory s tím, když jsem pomocí where zkoušel odfiltrovat všechny výsledky s No, pak, v návalu čirého zoufalství, zkusil having a fungovalo to. 

5. úkol 
To bylo čiré peklo. Je tam celkem 6 skriptů pro jednotlivé kategorie a čas. Self-join, case expression pro každou jednu věc (plat/cena) spojený s druhou tabulkou přes rok. Zase je tu otázka, že to musí být podle profesí. Naprosté peklo to bylo pak udělat ob rok, tam jsem pak zkusil připojit druhou tabulku pomocí stejné metodiky jako normálně v selfjoinu (year+1) a dal si tam dodatečné kategorie. Popravdě netuším, zda-li je to správně. Jestli to je špatně, tak mi, prosím, řekněte, co. Já už vůbec netuším. Díky. 
