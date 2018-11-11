// Queries for Table

// Get tables
const String GET_TABLES = 'CALL `USP_GetTables`();';

///////////////////////////////////////////////////////////////

// Queries for Food Category

// Get food categories
const String GET_FOOD_CATEGORIES = 'CALL `USP_GetFoodCategories`();';

///////////////////////////////////////////////////////////////

// Queries for Food

// Get foods
const String GET_FOODS = 'CALL `USP_GetFoods`();';

///////////////////////////////////////////////////////////////

// Queries for Bill

// Insert Bill
const String INSERT_BILL = 'CALL `USP_InsertBill`( @_IDTable , @_DateCheckIn , @_DateCheckOut , @_Discount , @_thien4chan , @_Status );';

const String GET_ID_MAX = 'CALL `USP_GetIdMax`();';

const String GET_BILLS = 'CALL `USP_GetBills`( @currentDate );';
///////////////////////////////////////////////////////////////

// Queries for BillDetail

// Insert BillDetail
const String INSERT_BILL_DETAIL = 'CALL `USP_InsertBillInfo`( @_IDBill , @_IDFood , @_Quantity );';

const String GET_BILLDETAIL_BY_TABLE = 'CALL `USP_GetBillDetalByTable`( @idTable );';
///////////////////////////////////////////////////////////////