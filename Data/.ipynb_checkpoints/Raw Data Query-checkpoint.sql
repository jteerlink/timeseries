CREATE TABLE #Sales(
custnum varchar(10),
saledate date,
EquipSales float )

DELETE #Sales

Insert into #Sales


Select A.ARNO01,Marketing.dbo.CreateDate(OEMO01,OEYR01) as saledate,sum(oeam05) as sales
From Marketing_Core.dbo.OEPTOHY A
inner join Marketing_Core.dbo.OEPTOLY B on A.OENO01=B.OENO01
inner join (select custnum from marketing.dbo.codskusales where year>=18 group by custnum having sum(totalamt)>50000) C on a.ARNO01=C.custnum
left join Marketing.dbo.CLV_Exclusions D on a.ARNO01=d.[Mincron ID]
left join Marketing.dbo.CustRegion E on A.ARNO01=e.CustNum

where OEYR01>=14 and d.[Mincron ID] is null and CustType in ('ar','mf')
group by a.ARNO01,OEMO01,OEYR01


insert into invplannersapp.dbo.TSdata_JT


select a.*,(case when EquipSales is null then 0 else EquipSales end) as EquipSales

FROM (
			select distinct a.custnum, b.date as saledate from #sales A
			cross join (select date from Marketing.dbo.DateRange
			where date <= DATEADD(MONTH, DATEDIFF(MONTH, -1, GETDATE())-1, -1) and year(date)>=2015) B
	 ) A

left join #sales B on a.CustNum=b.CustNum and a.saledate=b.saledate
where a.custnum not like '_00_00'
order by custnum,saledate




---RUN ON GMCSQL12

select custnum,date,sales
,sum(sales) OVER (PARTITION BY custnum
					order by custnum,date
					rows 11 PRECEDING) as R12Sales


from gmlsql2hou.invplannersapp.dbo.TSdata_JT

order by custnum,date
