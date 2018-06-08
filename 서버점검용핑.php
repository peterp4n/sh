function ping($host,$port=80,$timeout=6)
{
        $fsock = fsockopen($host, $port, $errno, $errstr, $timeout);
        if ( ! $fsock ) {
                return FALSE;
        } else {
        fclose($fsock);
                return TRUE;
        }
}
