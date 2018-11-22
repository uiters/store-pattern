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
const String INSERT_BILL = 'CALL `USP_InsertBill`( @_IDTable , @_DateCheckIn , @_DateCheckOut , @_Discount , @_TotalPrice , @_Status , @_Username );';

const String GET_ID_MAX = 'CALL `USP_GetIdMax`();';

const String GET_BILLS = 'CALL `USP_GetBills`( @currentDate );';

const String DELETE_BILL = 'CALL `USP_DelBill`( @id );';
///////////////////////////////////////////////////////////////

// Queries for BillDetail

// Insert BillDetail
const String INSERT_BILL_DETAIL = 'CALL `USP_InsertBillInfo`( @_IDBill , @_IDFood , @_Quantity );';

const String GET_BILLDETAIL_BY_BILL = 'CALL `USP_GetBillDetailByBill`( @id );';
///////////////////////////////////////////////////////////////

// Queries for Account

// Check login
const String LOGIN = 'CALL USP_Login( @username )';

// Update info
const String UPDATE_ACC_INFO = 'CALL USP_UpdateAccInfo ( @username , @displayName , @sex , @birthday , @idCard , @address , @phone );';

// Update password
const String UPDATE_ACC_PASS = 'CALL USP_UpdateAccPass ( @username , @newPass );';
///////////////////////////////////////////////////////////////