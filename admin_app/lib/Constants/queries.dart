///////////////////////////////////////////////////////////////

// Queries for Account

const String LOGIN = 'CALL USP_LoginAdmin( @username )';

const String UPDATE_ACC_INFO = 'CALL USP_UpdateAccInfo( @username , @displayName , @sex , @birthday , @idCard , @address , @phone );';

const String UPDATE_ACC_PASS = 'CALL USP_UpdateAccPass( @username , @newPass );';

const String UPDATE_ACC_AVATAR = 'CALL `USP_UpdateAccAvatar`( @username , @image )';

const String GET_ACCS = 'CALL `USP_GetAccounts`();';

const String INSERT_ACC = 'CALL `USP_InsertAccount`( @username , @password , @displayname , @sex , @idCard , @address , @phoneNumber , @birthday , @idAccountType , @image );';

const String UPDATE_ACC = 'CALL `USP_UpdateAccount`( @username , @displayname , @sex , @idCard , @address , @phoneNumber , @birthday , @idAccountType , @image );';

const String DELETE_ACC = 'CALL `USP_DeleteAcc`( @username );';

const String IS_ACC_EXISTS = 'CALL `USP_IsAccExists`( @username );';

const String RESET_ACC = UPDATE_ACC_PASS;

///////////////////////////////////////////////////////////////

// Queries for Category

const String GET_CATEGORIES = 'CALL `USP_GetFoodCategories`();';

const String INSERT_CATEGORY = 'CALL `USP_InsertFoodCatetory`( @_Name );';

const String UPDATE_CATEGORY = 'CALL `USP_UpdateFoodCategory`( @ID , @Name );';

const String DELETE_CATEGORY = 'CALL `USP_DeleteCategory`( @id );';

const String IS_CATEGORY_EXISTS = 'CALL `USP_IsCategoryExists`( @id );';

const String GET_ID_CATEGORY_MAX = 'CALL `USP_GetIdCategoryMax`();';

///////////////////////////////////////////////////////////////

// Queries for Table

const String GET_TABLES = 'CALL `USP_GetTables`();';

const String INSERT_TABLE = 'CALL `USP_InsertTable`( @Nametable );';

const String UPDATE_TABLE = 'CALL `USP_UpdateTable`( @ID , @_Name , @_Status );';

const String DELETE_TABLE = 'CALL `USP_DeleteTable`( @id );';

const String IS_TABLE_EXISTS = 'CALL `USP_IsTableExists`( @id );';

const String GET_ID_TABLE_MAX = 'CALL `USP_GetIdTableMax`();';

///////////////////////////////////////////////////////////////

// Queries for Account Types

const String GET_ACCTYPES = 'CALL `USP_GetAccountTypes`();';

const String INSERT_ACCTYPE = 'CALL `USP_InsertAccType`( @_Name );';

const String UPDATE_ACCTYPE = 'CALL `USP_UpdateAccType`( @_ID , @_Name );';

const String DELETE_ACCTYPE = 'CALL `USP_DeleteAccType`( @id );';

const String IS_ACCTYPE_EXISTS = 'CALL `USP_IsAccTypeExists`( @id );';

const String GET_ID_ACCTYPE_MAX = 'CALL `USP_GetIdAccTypeMax`();';

///////////////////////////////////////////////////////////////

// Queries for Food

const String GET_FOODS = 'CALL `USP_GetFoodsPlus`();';

const String INSERT_FOOD = 'CALL `USP_InsertFood`( @name , @price , @idCategory , @image );';

const String UPDATE_FOOD = 'CALL `USP_UpdateFood`( @id , @name , @price , @idCategory , @image );';

const String DELETE_FOOD = 'CALL USP_DeleteFood( @id );';

const String IS_FOOD_EXISTS = 'CALL `USP_IsFoodExists`( @id );';

const String GET_ID_FOOD_MAX = 'CALL `USP_GetIdFoodMax`();';

///////////////////////////////////////////////////////////////

//Queries for Report

const String QUERY_GET_REPORT_LASTWEEK  = 'CALL USP_TVC12_GetReport_WEEK()';

const String QUERY_GET_REPORT_TODAY = 'CALL USP_TVC12_GetReport_Today()';

///////////////////////////////////////////////////////////////
