// Queries for Table

const String GET_TABLES = 'CALL `USP_GetTables`();';

///////////////////////////////////////////////////////////////

// Queries for Food Category
const String GET_FOOD_CATEGORIES = 'CALL `USP_GetFoodCategories`();';

///////////////////////////////////////////////////////////////

// Queries for Food
const String GET_FOODS = 'CALL `USP_GetFoods`();';
const String QUERY_GET_FOODS = 'CALL USP_GetFoods1()';

///////////////////////////////////////////////////////////////

// Queries for Bill
const String INSERT_BILL = 'CALL `USP_InsertBill`( @_IDTable , @_DateCheckIn , @_DateCheckOut , @_Discount , @_TotalPrice , @_Status , @_Username );';
const String UPDATE_BILL = 'CALL `USP_UpdateBill`( @_ID , @_IDTable , @_DateCheckIn , @_DateCheckOut , @_Discount , @_TotalPrice , @_Status , @_Username );';
const String GET_ID_MAX = 'CALL `USP_GetIdMax`();';
const String GET_BILLS = 'CALL `USP_GetBills`( @currentDate );';
const String DELETE_BILL = 'CALL `USP_DelBill`( @id );';
const String HAS_BILL_OF_TABLE = 'CALL `USP_HasBillOfTable`( @idTable );';

///////////////////////////////////////////////////////////////

// Queries for BillDetail
const String INSERT_BILL_DETAIL = 'CALL `USP_InsertBillInfo`( @_IDBill , @_IDFood , @_Quantity );';
const String UPDATE_BILL_DETAIL = 'CALL `USP_UpdateBillInfo`( @_IDBill , @_IDFood , @_Quantity );';
const String GET_BILLDETAIL_BY_BILL = 'CALL `USP_GetBillDetailByBill`( @id );';
const String HAS_BILLDETAIL_OF_BILL = 'CALL USP_HasBillDetailOfBill ( @idBill , @idFood );';

///////////////////////////////////////////////////////////////

// Queries for Account
const String LOGIN = 'CALL USP_Login( @username )';
const String UPDATE_ACC_INFO = 'CALL USP_UpdateAccInfo ( @username , @displayName , @sex , @birthday , @idCard , @address , @phone );';
const String UPDATE_ACC_PASS = 'CALL USP_UpdateAccPass ( @username , @newPass );';
const String UPDATE_ACC_AVATAR = 'CALL `USP_UpdateAccAvatar`( @username , @image )';

///////////////////////////////////////////////////////////////

// Query
const String  QUERY_GET_ID_IMAGES = 'CALL USP_GetIDImages()';
const String QUERY_GET_IMAGE_BY_ID = 'CALL USP_GetImageByID( @id )';