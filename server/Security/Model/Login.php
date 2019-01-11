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
    private $adapter = null;
    private $row = null;
    private $timeOut = null;
    public function __construct()
    {
        $this->adapter = new Adapter();
    }

    public function builder($header, $body)
    {
        $header = $this->_valid($header);
        $body = $this->_valid($body);

        if($header == null && $body == null)
            http_response_code(404);//Not found
        else
        {
            if($header != null)
            {
                date_default_timezone_set("Asia/Ho_Chi_Minh");
                $data = json_decode($header);
                $this->user = isset($data->user) ? $data->user : null;
                $this->pass = isset($data->pass) ? $data->pass : null;
                if($this->user == null || $this->pass == null || $this->_login() == false)
                    http_response_code(401);//unauthorized
                else
                {
                    $token = $this->_createToken();
                    $json = $this->_getJson($token);
                    echo json_encode($json);
                    $this->_saveToken($token);
                }
            }
            else
            {
                $token = $body;
                $status = $this->_verify($token);
                switch ($status) {
                case 0:
                    http_response_code(401);//unauthorized
                    break;
                case -1:
                    $this->_updateToken($token);
                case 1:
                    $this->row = $this->_getInfo($this->row['Username']);
                    $json = $this->_getJson($token);
                    echo json_encode($json);
                    break;
                default:
                    http_response_code(401);//unauthorized
                    break;
                }
            }
        }
    }

    private function _getJson($token)
    {
        return [   
            'status'       => 200,
            'Username'     => $this->row['Username'],
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
    }

    private function _updateToken($token)
    {
        $$this->timeOut = $this->_getDateOut();
        $user = $this->row['Username'];
        $noneQuery = "call USP_SaveToken('$user', '$token', '$$this->timeOut')";
        $this->adapter->executeNoneQuery($noneQuery);
    }

    private function _verify($token)
    {
        $queryVery = "call USP_CheckToken('$token')";
        $this->row = $this->adapter->executeQuery($queryVery);
        if(count($this->row) < 1)
            return 0; // unauthorized
        $this->row = $this->row[0];
        $this->timeOut = $this->row['TimeOut'];

        if(strtotime($this->timeOut) > time())
            return 1; // OK
        else return -1;// expired token
    }

    private function _valid($str) //try decode base64
    {
        if($str == null)
            return null;
        $listString = explode('.', $str);
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

    private function _login()
    {
        $this->row = $this->_getInfo($this->user);
        if($this->row == null)
            return false;
        $hash = $this->row['Password'];
        if(password_verify($this->pass, $hash))
            return true;
        else return false;
    }

    private function _getInfo($user)
    {
        $queryLogin = "call USP_Login1('$user');";//------------
        $rows = $this->adapter->executeQuery($queryLogin);
        if(count($rows) < 1)
            return null;
        return $rows[0];
    }

    private function _saveToken($token)
    {
        $noneQuery = "call USP_SaveToken('$this->user', '$token', '$this->timeOut')";
        $this->adapter->executeNoneQuery($noneQuery);
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