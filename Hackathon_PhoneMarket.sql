/*
1. Có bao nhiêu đơn hàng trong từng tháng? (transactionID)
-- count unique TransID theo từng tháng
*/

select 
  format_date('%Y %m', parse_date('%Y %m %d', DatePurchase)) month
  ,count(distinct TransactionID) so_don_hang
FROM nakt-991762341.hometest.hackathon_phone_sales
group by 1
order by 1;

/*
2. Có bao nhiêu khách hàng mua tháng? (Customer_code)
*/
SELECT
	format_date('%Y %m', parse_date('%Y %m %d', DatePurchase)) year_month
	,count(distinct CustomerCode) so_khach_hang
FROM 'phone_market'
GROUP BY year_month
ORDER BY year_month;

/*
3. Nhóm khách hàng Nam và Nữ thích điện thoại của hãng nào nhất, lấy top 3? (dựa vào việc đếm transactionID)
Đầu tiên là SexType, sau đó ProductBrand, ProductName
TransactionID và tổng Transaction của nhóm khách hàng của giới tính đó mua hãng điện thoại nào
*/


WITH BrandRanking AS (
    SELECT 
        SexType,
        ProductBrand,
        COUNT(TransactionID) AS TotalTransactions,
        ROW_NUMBER() OVER (PARTITION BY SexType ORDER BY COUNT(TransactionID) DESC) AS Sex_Rank
    FROM nakt-991762341.hometest.hackathon_phone_sales
    WHERE SexType IN ('NAM', 'NU') 
    GROUP BY SexType, ProductBrand
)
SELECT 
    SexType, 
    ProductBrand, 
    TotalTransactions
FROM BrandRanking
WHERE Sex_Rank <= 3
ORDER BY SexType, Sex_Rank;

/*
4. Nhóm tuổi nào mua nhiều nhất, nhóm tuổi nào mang lại
doanh thu nhiều nhất?
Mình có thể rút ra kết luận gì không?
-- Sử dụng field 'Unit' để cộng số lượng mua, hoặc TransactionID
chỉ lấy data từ sheet Phone_Sales
*/

/*
Nhóm tuổi mua nhiều nhất (Age Group Buys Most)
*/
SELECT
	YearOldRange,
	SUM(Unit) AS tuoi_nguoi_mua
FROM 'phone_market'
GROUP BY YearOldRange
ORDER BY tuoi_nguoi_mua DESC;

/*
Nhóm tuổi mang lại doanh thu nhiều nhất
*/
SELECT
	YearOldRange,
	SUM(SalesValue) AS tong_doanh_thu
FROM 'phone_market'
GROUP BY YearOldRange
ORDER BY tong_doanh_thu DESC;


/*
5. Top 3 sản phẩm (điện thoại) mang lại doanh thu cao nhất của từng tháng? Đưa ra insight cho business nếu có (SalesValue)
Tính theo từng tháng, doanh thu theo từng tháng
Tìm sản phẩm ProductBrand, ProductName
*/

WITH MonthlySales AS (
    SELECT 
        -- Trích xuất Tháng từ chuỗi '2015 01 03'
        SUBSTR(DatePurchase, 6, 2) AS Month,
        ProductName,
        ProductBrand,
        SUM(SalesValue) AS TotalRevenue
    FROM nakt-991762341.hometest.hackathon_phone_sales
    GROUP BY 1, 2, 3
),
RankedProducts AS (
    SELECT 
        Month,
        ProductName,
        ProductBrand,
        TotalRevenue,
        RANK() OVER (PARTITION BY Month ORDER BY TotalRevenue DESC) as Rank
    FROM MonthlySales
)
SELECT 
    Month, 
    ProductName, 
    ProductBrand, 
    TotalRevenue
FROM RankedProducts
WHERE Rank <= 3
ORDER BY Month ASC, TotalRevenue DESC;


/*
6. Nhóm khách hàng 26-30 yêu thích hãng nào? 
-- transactionID
*/
SELECT
	ProductBrand
	,COUNT(DISTINCT TransactionID) As tuoi_khach_hang_2630
FROM 'phone_market'
WHERE YearOldRange IN (26, 30)
GROUP BY ProductBrand
ORDER BY tuoi_khach_hang_2630 DESC;


/*
10. Hãng điện thoại được mua trả góp nhiều nhất?
-- count transactionID
*/
SELECT
	ProductBrand
	,COUNT(DISTINCT TransactionID) As tong_nguoi_tra_gop
FROM 'phone_market'
WHERE PaymentMethod = 'Trả góp'
GROUP BY ProductBrand
ORDER BY tong_nguoi_tra_gop DESC;
