<?php
require_once 'Adapter.php';
class Verifier{
    private $token = null;
    private $query = null;
    private $noneQuery = null;
    private $adapter = null;
    private $row = null;

    public function __construct($header, $excuteQuery, $excuteNoneQuery){

        $this->token = $this->_valid($header); // $header = token + '.' + sha256('token', secretkey);
        $this->query = $this->_valid($excuteQuery);
        $this->noneQuery = $this->_valid($excuteNoneQuery);
        $this->adapter = new Adapter();
    }

    private function _valid($header)
    {
        if($header == null)
            return null;
        $listString = explode('.', $header);
        if(count($listString) < 2)
            return null;
        else
        {
            $key = hash_hmac('sha256', $listString[0], 'flutter');
            if($key == $listString[1])
                return base64_decode($listString[0]);
            else return null;
        }  
    }

    public function builder()
    {
        if($this->token == null || !(($this->noneQuery == null) ^ ($this->query == null)))
            http_response_code(404);//Not Found: The requested resource could not be found.
        else
        {   
            $check = $this->_verify();
            if($check == 0)
            {
                http_response_code(401);//Unauthorized
            }
            else
            {
                //$idType = $row['IDAccountType'];
                //if(!checkPermit()) http_response_code(401) // 401 UNAUTHORIZED: 
                // if($check == -1) // expired token
                //     $this->_updateToken();
                if($this->noneQuery != null) 
                    $data = $this->adapter->executeNoneQuery($this->noneQuery);
                else $data = json_encode($this->adapter->executeQuery($this->query));
                echo $data;
            }
        }
    }

    private function _verify() : int
    {
        date_default_timezone_set('Asia/Ho_Chi_Minh');
        $queryVery = "call USP_CheckToken('$this->token')";
        $this->row = $this->adapter->executeQuery($queryVery);
        if(count($this->row) < 1)
            return 0; // unauthorized
        $this->row = $this->row[0];
        if(strtotime($this->row['TimeOut']) > time())
            return 1; // OK
        else return -1;// expired token
    }

    private function _updateToken()
    {
        $timeOut = $this->_getDateOut();
        $user = $this->row['Username'];
        $noneQuery = "call USP_SaveToken('$user', '$this->token', '$timeOut')";
        $this->adapter->executeNoneQuery($noneQuery);
    }
    private function _checkPermit()
    {
        $str = ['Admin', 'User'];
        $permit = str[$this->row['IDAccountType']];
        //check
    }

    private function _getDateOut()
    {
        return date("Y-m-d H:i:s", time() + 2592000); // 3600 * 24 * 30 = 2592000 = 30 days
    }
}
?>