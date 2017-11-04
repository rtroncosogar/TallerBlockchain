//A continuacion se presenta un contrato base, tipo ERC20. Tiene muchas de las funciones basicas de este estandar
//y es del mismo tipo de contrato que compilan las ICO cuando sea anuncian.



pragma solidity ^0.4.11;  //Esta linea indica qué versión de compilador considera el diseño del contrato

//Solidity es un lenguaje orientado a Contratos, sin embargo, algo importante de internalizar es que
//los contratos poseen el mismo comportamiento de las Clases, por tanto, es posible afirmar que solidity es un
//lenguaje orientado a objetos [objetos == clases].  

//"Clase" base del contrato 

contract Token {
    
	//Declaracion de los distintos metodos que implementara el contrato.
	
    function transfer(address to, uint256 value) public returns (bool success);
    function transferFrom(address from, address to, uint256 value) public returns (bool success);
    function approve(address spender, uint256 value) public returns (bool success);
    
    //function totalSupply() public  constant returns (uint256 supply) {}
    function balanceOf(address owner) public constant returns (uint256 balance);
    function allowance(address owner, address spender) public constant returns (uint256 remaining);
    
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

//Notar la herencia desde la "clase" Token

contract StandardToken is Token {
    
    mapping (address => uint256) balances;
    mapping (address => mapping (address => uint256)) allowed;
    uint256 public totalSupply;
    
    function transfer(address _to, uint256 _value)
        public
        returns (bool)
    {
        assert(!(balances[msg.sender] < _value));
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        Transfer(msg.sender, _to, _value);
        return true;
    }
    
    function transferFrom(address _from, address _to, uint256 _value)
        public
        returns (bool)
    {
        assert(!(balances[_from] < _value || allowed[_from][msg.sender] < _value));
        balances[_to] += _value;
        balances[_from] -= _value;
        allowed[_from][msg.sender] -= _value;
        Transfer(_from, _to, _value);
        return true;
    }
    
    function approve(address _spender, uint256 _value)
        public
        returns(bool)
    {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }
    
    function allowance(address _owner, address _spender)
        constant
        public
        returns (uint256)
    {
        return allowed[_owner][_spender];
    }
    
    function balanceOf(address _owner)
        constant
        public
        returns (uint256)
    {
        return balances[_owner];
    }
}
//Aqui tenemos el constructos del token. Rellena con los parametros que tu prefieras :D

contract ERC20 is StandardToken {
    string constant public name     = ""; //Debes darle un nombre, para hacer una analogia, si esto fuera la moneda Chilena, aqui iria "Peso"
    string constant public symbol   = ""; // siguiendo con la analogia esto seria el "CLP"
    uint8  constant public decimals = ;  // Aqui definimos en cuantas unidades va a ser divisible cada Token
    
    function ERC20
        (
            uint256 _totalSuply
        )
        public
    {
        totalSupply          = _totalSuply;
        balances[msg.sender] = _totalSuply;
        Transfer(0, msg.sender, balances[msg.sender]);
    }
}
