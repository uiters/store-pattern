<?php
require_once 'Adapter.php';
/**
 * 
 * Header had had two part, its separated by '.'
 * 
 * Example abcdf.1b510db381543148da9de596186659fe2459d2b9493d7f1a85d1216742277b8b
 * 
 * abcdf has been encode by base64 & The rest = sha256('abcdf', secretkey)
 * 
 * *Login succed return json_profile & token
 * 
 * *Login failed return http code 401 - unauthorized
 * 
 */
class Login{
    private $user = null;
    private $pass = null;
    private $adaper = null;
    private $row = null;
    private $timeOut = null;
    public function __construct()
    {
        $this->adaper = new Adapter();
    }

    public function builder($header)
    {
        if($header == null || $this->_invalid($header))
            http_response_code(404);//Not found
        else
        {
            date_default_timezone_set("Asia/Ho_Chi_Minh");
            $body = explode('.', $header)[0];
            try
            {
                $data = json_decode(base64_decode($body));
                $this->user = $data->user;
                $this->pass = $data->pass;
                if($this->_login() == false)
                    http_response_code(401);//unauthorized
                else
                {
                    $token = $this->_createToken();

                    $json = [   
                                'Username'     => $this->user,
                                'DisplayName'  => $this->row['DisplayName'],
                                'Sex'          => $this->row['Sex'],
                                'IDCard'       => $this->row['IDCard'],
                                'Address'      => $this->row['Address'],
                                'PhoneNumber'  => $this->row['PhoneNumber'],
                                'BirthDay'     => $this->row['BirthDay'],
                                'IDAccountType'=> $this->row['IDAccountType'],
                                'IDImage'      => $this->row['IDImage'],
                                'Token'        => $token,
                                'TimeOut'      => $this->timeOut
                            ];

                    echo json_encode($json);

                    $this->_saveToken($token);
                }
            }
            catch(Exception $e)
            {
                http_response_code(404);
            }
        }
    }
    private function _invalid($header)
    {
        $listString = explode('.', $header);
        if(count($listString) < 2)
            return true;
        else
        {
            $key = hash_hmac('sha256', $listString[0], 'flutter');
            if($key == $listString[1])
                return false;
            else return true;
        }  
    }

    private function _login()
    {
        $queryLogin = "call USP_Login1('$this->user');";//------------
        $this->row = $this->adaper->executeQuery($queryLogin)[0];
        if($this->row['Password'] == $this->pass)
            return true;
        else return false;
    }

    private function _saveToken($token)
    {
        $noneQuery = "call USP_SaveToken('$this->user', '$token', '$this->timeOut')";
        $this->adaper->executeNoneQuery($noneQuery);
    }

    private function _createToken()
    {
        $this->timeOut = $this->_getDateOut();
        return hash_hmac('sha256', $this->user, time());
    }

    private function _getDateOut()
    {
        return date("Y-m-d H:i:s", time() + 2592000); // 3600 * 24 * 30 = 2592000 = 30 days
    }
}
?>