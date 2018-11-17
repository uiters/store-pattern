<?php
require_once 'Adapter.php';
class Login{
    private $user = null;
    private $pass = null;
    private $adaper = null;
    private $row = null;
    
    public function __constructor()
    {
        $adaper = new Adapter();
    }

    public function builder($header , $body)
    {
        if($header == null || $body == null)
            http_response_code(404);//Not found
        else
        {
            try
            {
                $data = json_decode($body);
                $this->user = $data['user'];
                $this->pass = $data['pass'];
                if(_login() == false)
                    http_response_code(401);//UNAUTHORIZED
                else
                {
                    $token = _createToken();
                    echo $token;
                    _saveToken($token);
                }
            }
            catch(Exception $e)
            {
                http_response_code(404);
            }
        }
    }
    private function _login()
    {
        $queryLogin = "call USP_Login('$user');";
        $row = $adaper->executeQuery($queryLogin);
        if($row['Password'] == $pass)
            return true;
        else return false;
    }

    private function _saveToken($token)
    {
        $query = "call USP_SaveToken($token)";
        $adaper->executeNoneQuery($query);
    }

    private function _createToken()
    {
        return hash_hmac('sha256', $user, time());
    }
}
?>