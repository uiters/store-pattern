const String URL_EXECUTE = "https://meomeocf98.000webhostapp.com/flutter";
const String ID_EXECUTENONEQUERY = 'executeNoneQuery';
const String ID_EXECUTEQUERY = 'executeQuery';

//---------------------------------------------------------------------------------------------------------------- */



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