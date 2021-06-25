
-- =============================================
-- Author:		Sema �ahin
-- Create date: 25.06.2021
-- Description:	tckn do�rulamas� yapan fonksiyon
-- =============================================
CREATE FUNCTION dbo.fn_tckn_dogrula
(
	@tcno nvarchar(11)
)
RETURNS int
AS
BEGIN



declare @sonuc bit =0
declare @karakter int = 0
declare @tek int = 0
declare @cift int = 0
declare @ilkOnHane int = 0
declare @basamak10 int = 0
declare @basamak11 int = 0
declare @bilgi1 int = 0
declare @bilgi1sonuc int = 0
declare @bilgi2 int = 0
declare @bilgi3 int = 0
declare @bilgi4 int = 0
declare @dokuzrakaminToplami int =0
declare @onRakaminToplami int = 0

while(@karakter<9)
begin
	set @karakter=@karakter +1
	--tek rakamlar toplan�r
	if (@karakter % 2=1 )
	begin
		set @tek = @tek + cast(substring(@tcno,@karakter,1) as int)
	end
	--�ift rakamlar toplan�r
	if (@karakter %  2=0)
	begin
		set @cift=@cift + cast(substring(@tcno,@karakter,1) as int)
	end
	--ilk 9 rakam�n toplam�
	set @dokuzrakaminToplami = @dokuzrakaminToplami + cast(substring(@tcno,@karakter,1) as int)
end

 --tek rakamlar�n 7 kat� ile �ift rakamlar�n 9 kat� toplam�n�n birler basama�� 10. rakam� verir
 --10. basamak
 set @basamak10 = cast(substring(@tcno,10,1) as int)
 --11. basamak
 set @basamak11 = cast(substring(@tcno,11,1) as int)

 set @bilgi1sonuc = ((@tek * 7) + (@cift * 9)) %10

 --select @bilgi1sonuc '@bilgi1sonuc', @basamak10 '@basamak10', @tek 'tek', @cift 'cift'

 if( @bilgi1sonuc = @basamak10)
 begin
	set @bilgi1 = 1
 end

 set @onRakaminToplami = @dokuzrakaminToplami + @basamak10

 --ilk 10 rakam�n toplam�n�n birler basama�� 11. rakam� verir.
 if(@onRakaminToplami %10 = @basamak11)
 begin
	set @bilgi2 = 1
 end

 --tekler 7 kat�ndan �ifleri ��kar�nca sonucun birler basama�� 10. rakam� verir
 if(((@tek * 7) - @cift) %10 = @basamak10 )
 begin
	set @bilgi3 = 1
 end 

 -- tek rakamlar�n toplam�n�n 8 kat�n�n birler basama�� 11. rakam� verir
 if(@tek * 8 %10= @basamak11)
 begin
	set @bilgi4 = 1
 end

 --t�m bilgileri sa�l�yor ise do�ru 
 if(@bilgi1 =  1 and @bilgi2 = 1 and @bilgi3 = 1 and @bilgi4 = 1)
 begin
	set @sonuc = 1
 end 
	
	--select @bilgi1 '@bilgi1', @bilgi2 '@bilgi2', @bilgi3 '@bilgi3', @bilgi4 '@bilgi4'

	return @sonuc

END
GO

