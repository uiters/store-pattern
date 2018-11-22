<?php
class Adapter
{
    private $server  = ''; //server name
    private $user    = ''; //user name
    private $pass    = ''; //pass user
    private $dbname  = ''; //database name

    public function __construct() {
    }


    public function executeNoneQuery($noneQuery)
    {
        $connect = new mysqli($this->server, $this->user, $this->pass, $this->dbname);
        try
        {
            $connect->set_charset('UTF8');
            $data = $connect->query($noneQuery);
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
        $connect = new mysqli($this->server, $this->user, $this->pass, $this->dbname);
        try{
            $connect->set_charset('UTF8');
            $data = $connect->query($query);
            $rows = array();
             while($array = $data->fetch_assoc()) {
               $rows[] = $array;
            }

            $data->close();
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
