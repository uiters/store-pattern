/// Queries for Table
///
/// Get tables
const String QUERY_GET_TABLES = 'CALL USP_GetTables()';

// ////////////////////////////////////////////////////////////

/// Queries for Food Category
///
/// Get food categories
const String QUERY_GET_FOOD_CATEGORIES = 'CALL USP_GetFoodCategories()';

// ////////////////////////////////////////////////////////////

/// Queries for Food
///
/// Get foods
const String QUERY_GET_FOODS = 'CALL USP_GetFoods()';

// ////////////////////////////////////////////////////////////

/// Query
///
/// Get list id images
const String  QUERY_GET_ID_IMAGES = 'CALL USP_GetIDImages()';
///
/// Get list image by id
/// 
/// @id
const String QUERY_GET_IMAGE_BY_ID = 'CALL USP_GetImageByID( @id )';