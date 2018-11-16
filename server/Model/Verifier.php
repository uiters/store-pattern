<?php
require_once 'Adapter.php';
    class Verifier{
        private $token = null;
        private $query = null;
        private $noneQuery = null;
        private $adapter = null;


        public function __construct($header, $excuteQuery, $excuteNoneQuery){

            $this->token = $header;
            $this->query = $excuteQuery;
            $this->noneQuery = $excuteNoneQuery;
            $this->adapter = new Adapter();
        }

        public function builder()
        {
            if($this->token == null || !(($this->noneQuery == null) ^ ($this->query == null)))
                http_response_code(404);//Not Found: The requested resource could not be found.
            else
            {   
                $row = verify();
                if($row == false)
                {
                    echo 0;
                }
                else
                {
                    //$idType = $row['IDAccountType'];
                    //if(!checkPermit($idType)) http_response_code(401) // 401 UNAUTHORIZED: 
                    if($noneQuery != null) 
                        echo $adapter->executeNoneQuery($noneQuery);
                    else echo json_encode($adapter->executeQuery($query));
                }
            }
        }

        private function verify()
        {
            date_default_timezone_set('Asia/Ho_Chi_Minh');
            $queryVery = "call USP_CheckToken('$token')";
            $row = $adapter->executeQuery($queryVery)[0];
            if(strtotime($row['TimeOut']) > time())
                return $row;
            else return false;
        }
        private function checkPermit($idType)
        {
            $str = ['Admin', 'User'];
            $permit = str[$idType];
            //check
        }
    }
?>