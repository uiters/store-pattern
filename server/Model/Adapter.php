<?php
class Adapter
{
    private static $server  = ''; //server name
    private static $user    = ''; //user name
    private static $pass    = ''; //pass user
    private static $dbname  = ''; //database name

    public function __construct() {
    }


    public function executeNoneQuery($noneQuery)
    {
        $connect = new mysqli($server, $user, $pass, $dbname);
        try
        {
            $stmt = $connect->prepare($noneQuery);
            $data = $stmt->execute();
            $stmt->close();
            $connect->close();
            return $data ? 1 : 0;
        }
        catch(Exception $e)
        {
            http_response_code(503);//Service Unavailable: The server is currently unavailable 
        }
    }

    public function executeQuery($query)
    {
        $connect = new mysqli($server, $user, $pass, $dbname);
        try{
            $connect->set_charset('UTF8');
            $stmt = $connect->prepare($query);
            $stmt->execute();
            $data = $stmt->get_result();
            $rows = array();
            while($array = $data->fetch_assoc()) {
                $rows[] = $array;
            }

            $data->close();
            $stmt->close();
            $connect->close();

            return $rows;
        }
        catch(Exception $e)
        {
            http_response_code(503); //Service Unavailable: The server is currently unavailable 
        }
    }
}
?>
