--Starting the portfolioProject2

--Cleaning Data in SQL Queries

Select *
from [portfolio project].dbo.NashvilleHousing

--Standardize Date Format

Select saledateConverted, Convert(Date,SaleDate)
from [portfolio project].dbo.NashvilleHousing

Update NashvilleHousing
set SaleDate =Convert(Date,SaleDate) 

Alter table nashvillehousing
Add saledateConverted Date;

Update Nashvillehousing
set saledateConverted = Convert(date,SaleDate)

----------------------------------------------------------------------------------------------------------------------

--Populate Property Address Data
 select *
 from [portfolio project].dbo.NashvilleHousing
 --Where PropertyAddress is Null
 order by ParcelID 
 

select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, Isnull(a.propertyaddress,b.PropertyAddress)
from [portfolio project].dbo.NashvilleHousing a
 Join [portfolio project].dbo.NashvilleHousing b
     on a.parcelID = b.parcelID
	 And a.[uniqueID ]<> b.[uniqueID ]
	 Where a.propertyAddress is null

Update a
set PropertyAddress = Isnull(a.propertyaddress,b.PropertyAddress)
from [portfolio project].dbo.NashvilleHousing a
 Join [portfolio project].dbo.NashvilleHousing b
     on a.parcelID = b.parcelID
	 And a.[uniqueID ]<> b.[uniqueID ]
	 Where a.propertyAddress is null

-----------------------------------------------------------------------------------------------------------------------

--Breaking out Address into Individual Columns (Address, City, State)

select PropertyAddress
from [portfolio project].dbo.NashvilleHousing
--where propertyaddress is Null
--order by parcelID

Select 
Substring(PropertyAddress, 1, charindex(',', PropertyAddress)-1) as Address
, substring(propertyaddress, charindex(',', PropertyAddress)+1, len(PropertyAddress)) as Address

from [portfolio project].dbo.NashvilleHousing

Alter table nashvillehousing
Add PropertySplitAddress Nvarchar(255);

Update nashvillehousing
set PropertySplitAddress = Substring(PropertyAddress, 1, charindex(',', PropertyAddress)-1) 

Alter table nashvillehousing
Add PropertySplitcity Nvarchar(255);

Update nashvillehousing
set PropertySplitcity = substring(propertyaddress, charindex(',', PropertyAddress)+1, len(PropertyAddress))

Select *
From [portfolio project].dbo.NashvilleHousing

--Do the things above in a simpler way.

Select OwnerAddress
From [portfolio project].dbo.NashvilleHousing




Select 
Parsename(replace(OwnerAddress, ',','.'),3)
,Parsename(replace(OwnerAddress, ',','.'),2) 
,Parsename(replace(OwnerAddress, ',','.'),1) 
From [portfolio project].dbo.NashvilleHousing




Alter table NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

Update nashvillehousing
set OwnerSplitAddress = Parsename(replace(OwnerAddress, ',','.'),3) 

Alter table nashvillehousing
Add OwnerSplitcity Nvarchar(255);

Update nashvillehousing
set OwnerSplitcity = Parsename(replace(OwnerAddress, ',','.'),2) 

Alter table nashvillehousing
Add OwnerSplitstate Nvarchar(255);

Update nashvillehousing
set OwnerSplitstate = Parsename(replace(OwnerAddress, ',','.'),1)

Select *
From [portfolio project].dbo.NashvilleHousing

----------------------------------------------------------------------------------------------------------------------------------------------

--Change Y and N to Yes and No in "Sold as Vacant" field 

--We will use Distinct to check the total numbers of yes and no column
--(DISTINCT keyword in SQL eliminates all duplicate records from the result returned by the SQL query.)

Select distinct(Soldasvacant), count(Soldasvacant) 
From [portfolio project].dbo.NashvilleHousing 
Group by Soldasvacant
order by 

Select SoldAsVacant
, Case When SoldAsVacant = 'Y' Then 'Yes'
When SoldAsVacant = 'N' Then 'No'
Else SoldAsVacant 
end
From [portfolio project].dbo.NashvilleHousing

Update NashvilleHousing
set SoldAsVacant =  Case When SoldAsVacant = 'Y' Then 'Yes'
When SoldAsVacant = 'N' Then 'No'
Else SoldAsVacant 
end


------------------------------------------------------------------------------------------------------------------------------------------------------------


--REMOVE DUPLICATES(Don't use it much)

With RowNumCTE as(
select *, 
ROW_NUMBER() over(
Partition by parcelID,
             PropertyAddress,
			 SalePrice,
			 SaleDate,
			 LegalReference
			 Order by 
			 UniqueID
			 ) Row_num



From [portfolio project].dbo.NashvilleHousing
--order by ParcelID
)
Select *
from RowNumCTE
where Row_num > 1 
Order by  PropertyAddress

select*
From [portfolio project].dbo.NashvilleHousing

--------------------------------------------------------------------------------------------------------------------------------------------

--DELETE UNUSED COLOUMNS



select*
From [portfolio project].dbo.NashvilleHousing

--alter table [portfolio project].dbo.NashvilleHousing
--drop column OwnerAddress, TaxDistrict, PropertyAddress

select*
From [portfolio project].dbo.NashvilleHousing
--alter table [portfolio project].dbo.NashvilleHousing
--drop column SaleDate




