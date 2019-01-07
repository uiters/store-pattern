///////////////////////////////////////////////////////////////

// Queries for Account

const String LOGIN = 'CALL USP_LoginAdmin( @username )';

const String UPDATE_ACC_INFO = 'CALL USP_UpdateAccInfo ( @username , @displayName , @sex , @birthday , @idCard , @address , @phone );';

const String UPDATE_ACC_PASS = 'CALL USP_UpdateAccPass ( @username , @newPass );';

const String UPDATE_ACC_AVATAR = 'CALL `USP_UpdateAccAvatar`( @username , @image )';

///////////////////////////////////////////////////////////////

// Queries for Category

const String GET_CATEGORIES = 'CALL `USP_GetFoodCategories`();';

const String INSERT_CATEGORY = 'CALL `USP_InsertFoodCatetory`( @_Name );';

const String UPDATE_CATEGORY = 'CALL `USP_UpdateFoodCategory`( @ID , @Name );';

///////////////////////////////////////////////////////////////

// Queries for Table

const String GET_TABLES = 'CALL `USP_GetTables`();';

const String INSERT_TABLE = 'CALL `USP_InsertTable`( @Nametable );';

const String UPDATE_TABLE = 'CALL `USP_UpdateTable`( @ID , @_Name , @_Status );';

///////////////////////////////////////////////////////////////

// Queries for Account Types

const String GET_ACCTYPES = 'CALL `USP_GetAccountTypes`();';

const String INSERT_ACCTYPE = 'CALL `USP_InsertAccType`( @_Name );';

const String UPDATE_ACCTYPE = 'CALL `USP_UpdateAccType`( @_ID , @_Name );';

///////////////////////////////////////////////////////////////

// Queries for Food

const String GET_FOODS = 'CALL `USP_GetFoodsPlus`();';

const String INSERT_FOOD = 'CALL `USP_InsertFood`( @name , @price , @idCategory , @image )';

const String UPDATE_FOOD = 'CALL `USP_UpdateFoodCategory`( @ID , @Name );';

///////////////////////////////////////////////////////////////

// Queries for Account

const String GET_ACCS = 'CALL `USP_GetAccounts`();';

const String INSERT_ACC = 'CALL `USP_InsertAccount`( @username , @password , @displayname , @sex , @idCard , @address , @phoneNumber , @birthday , @idAccountType , @image )';

const String UPDATE_ACC = 'CALL `USP_UpdateAccType`( @_ID , @_Name );';

///////////////////////////////////////////////////////////////

///Query Insert Table
///
///USP_InsertTable( @Nametable ) 
const String QUERY_INSERT_TABLE = 'CALL USP_InsertTable( @Nametable )';

///Query Insert Food
///
///USP_InsertFood( @IDCategory , @Name , @Price )
const String QUERY_INSERT_FOOD = 'CALL USP_InsertFood( @IDCategory , @Name , @Price )';

///Query Insert Food Category
///
///USP_InsertFoodCatetory( @Nametable )
const String QUERY_INSERT_FOODCATEGORY = 'CALL USP_InsertFoodCatetory( @Nametable )';

///Query Insert Pending
///
///USP_InsertPending( @IDBill )
const String QUERY_INSERT_PENDING = 'CALL USP_InsertPending( @IDBill )';

///Query Insert
///
///USP_InsertBin( @IDCollect , @ID )
const String QUERY_INSERT_BIN = 'CALL USP_InsertBin( @IDCollect , @ID )';

//---------------------------------------------------------------------------------------------------------------- */


/// Query update Table
/// 
/// USP_UpdateTable( @ID , @_Name , @_Status )
const String QUERY_UPDATE_TABLE = 'CALL USP_UpdateTable( @ID , @_Name , @_Status )';

/// Query update Food
/// 
/// USP_UpdateFood( @ID , @IDFoodCategory , @Name , @Price )
const String QUERY_UPDATE_FOOD = 'CALL USP_UpdateFood( @ID , @IDFoodCategory , @Name , @Price )';

/// Query update Food Category
/// 
/// USP_UpdateFoodCategory( @ID , @Name )
const String QUERY_UPDATE_FOODCATEGORY = 'CALL USP_UpdateFoodCategory( @ID , @Name )';


//---------------------------------------------------------------------------------------------------------------- */


/// Query delete Pending
/// 
///USP_DelPending( @IDBill )
const String QUERY_DELETE_PENDING = 'CALL USP_DelPending( @IDBill )';

/// Query delete bin
/// 
/// USP_DelBin( @IDCollect , @ID )
const String QUERY_DELTE_BIN = 'CALL USP_DelBin( @IDCollect , @ID )';