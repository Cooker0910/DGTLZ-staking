//SPDX-License-Identifier: MIT

pragma solidity 0.8.10;

interface IdgtlzStaking {
  function staking(uint amount, uint256 duration) external;
  function claim(uint256 duration, uint256 level) external;
  function withdrawBenefit() external;
  function unStake(uint256 duration, uint256 level) external;
  
  event Staking(address indexed user, uint amount, uint timestamp, uint endStakeDay, uint256 duration, uint256 level);
  event Claim(address indexed user, uint rewardedAmount, uint timestamp, uint256 pastTime, uint256 duration, uint256 level);
  event Benefit(uint benefitAmount, uint teamAmount, uint airdropAmount);
  event Unstaking(address indexed user, uint timestamp);
}

interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller"s account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller"s tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender"s allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `from` to `to` using the
     * allowance mechanism. `amount` is then deducted from the caller"s
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

interface IPancakeRouter01 {
    function WETH() external pure returns (address);
    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
}

interface IWETH {
    function deposit() external payable;
    function transfer(address to, uint value) external returns (bool);
    function withdraw(uint) external;
}

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
 
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b >= 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

// File @openzeppelin/contracts/utils/Context.sol@v4.3.2

pragma solidity ^0.8.0;

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}

// File @openzeppelin/contracts/access/Ownable.sol@v4.3.2
pragma solidity ^0.8.0;

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        _setOwner(_msgSender());
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _setOwner(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(
            newOwner != address(0),
            "Ownable: new owner is the zero address"
        );
        _setOwner(newOwner);
    }

    function _setOwner(address newOwner) private {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}

contract DGTLZ is IdgtlzStaking, Ownable {
  using SafeMath for uint256;
  
  IERC20 constant BUSD = IERC20(0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56);
  IPancakeRouter01 private constant router = IPancakeRouter01(0x10ED43C718714eb63d5aA57B78B54704E256024E);
  address private immutable WBNB;
  mapping(address => mapping(uint256 => mapping(uint256 => uint256))) public stakeAmount;
  mapping(address => mapping(uint256 => mapping(uint256 => uint256))) private _rewardAmount;
  mapping(address => mapping(uint256 => mapping(uint256 => uint256))) public withdrawAmountForStaker;
  mapping(address => mapping(uint256 => mapping(uint256 => uint256))) public lockDuration; 
  mapping(address => mapping(uint256 => mapping(uint256 => uint256))) private stakingDate;
  mapping(address => mapping(uint256 => mapping(uint256 => uint256))) private interestPeriod;
  mapping(address => mapping(uint256 => mapping(uint256 => uint256))) public rewardedAmount;
  mapping(address => mapping(uint256 => mapping(uint256 => uint256))) private rewardAmount;
  mapping(address => mapping(uint256 => mapping(uint256 => uint256))) private interestRate;
  mapping(address => mapping(uint256 => mapping(uint256 => uint256))) private claimDate;
  mapping(address => mapping(uint256 => mapping(uint256 => uint256))) private lockPeriod;
  mapping(address => mapping(uint256 => mapping(uint256 => bool))) private levelVerify;
  uint256 private totalStakeAmount;
  uint256 private totalRewardAmount;
  uint256 private totalAmount_;
  uint256 private unStakableAmount;
  uint256 public claimPeriod;
  uint256 private _pastTime;
  uint256 private level;
  uint256 private decimals = 10 ** 18;
  address public teamWallet;
  address public airdropWallet;
  uint256 private _maxWETHToSpend;
  uint256 private _perTxBuyAmount;
  address private _tokenToSell;
  address private _tokenToBuy;
  uint256 private _perTxWethAmount;
  mapping(address => bool) internal stakeholders;
  

  constructor (
    uint256 _claimPeriod,
    address _teamWallet,
    address _airdropWallet
  ) {
    teamWallet = _teamWallet;
    airdropWallet = _airdropWallet;
    claimPeriod = _claimPeriod * 1 days;
    WBNB = router.WETH();
    BUSD.approve(0x10ED43C718714eb63d5aA57B78B54704E256024E, type(uint256).max);
    IERC20(router.WETH()).approve(0x10ED43C718714eb63d5aA57B78B54704E256024E, type(uint256).max);
  }

  function isStakeholder(address _address) public view returns(bool) {
      return stakeholders[_address];
  }

  function addStakeholder(address _stakeholder) private {
    stakeholders[_stakeholder] = true;
  }

  function staking(uint amount, uint duration) external {
    require(amount <= BUSD.balanceOf(msg.sender), "Not enough BUSD token to stake");
    require(amount >= 500 * decimals , "Insufficient Stake Amount");
    require(duration == 1 || duration == 3 || duration == 6 || duration == 12, "Duration not match");
    addStakeholder(msg.sender);
    if (duration == 1) {
      if (amount >= 500 * decimals && amount < 2000 * decimals) {
        level = 1;
        rewardAmount[msg.sender][duration][level] = 0;
        interestRate[msg.sender][duration][level] = 10;
      } else if (amount >= 2000 * decimals && amount <= 5000 * decimals) {
        level = 2;
        rewardAmount[msg.sender][duration][level] += amount.div(100);
        interestRate[msg.sender][duration][level] = 10;
      } else if (amount > 5000 * decimals) {
        level = 3;
        rewardAmount[msg.sender][duration][level] += amount.mul(2).div(100);
        interestRate[msg.sender][duration][level] = 15;
      }
    } else if (duration == 3) {
      require(amount >= 500 * decimals, "Stake amount has to more than 5000BUSD");
      if (amount >= 500 * decimals && amount < 2000 * decimals) {
        level = 1;
        rewardAmount[msg.sender][duration][level] += amount.mul(2).div(100);
        interestRate[msg.sender][duration][level] = 20;
      } else if (amount >= 2000 * decimals && amount < 5000 * decimals) {
        level = 2;
        rewardAmount[msg.sender][duration][level] += amount.mul(4).div(100);
        interestRate[msg.sender][duration][level] = 40;
      } else if (amount >= 5000 * decimals) {
        level = 3;
        rewardAmount[msg.sender][duration][level] += amount.mul(55).div(1000);
        interestRate[msg.sender][duration][level] = 55;
      }
    } else if (duration == 6) {
      require(amount >= 500 * decimals, "Stake amount has to more than 5000BUSD");
      if (amount >= 500 * decimals && amount < 2000 * decimals) {
        level = 1;
        rewardAmount[msg.sender][duration][level] += amount.mul(55).div(1000);
        interestRate[msg.sender][duration][level] = 55;
      } else if (amount >= 2000 * decimals && amount < 5000 * decimals) {
        level = 2;
        rewardAmount[msg.sender][duration][level] += amount.mul(85).div(1000);
        interestRate[msg.sender][duration][level] = 85;
      } else if (amount >= 5000 * decimals) {
        level = 3;
        rewardAmount[msg.sender][duration][level] += amount.mul(115).div(1000);
        interestRate[msg.sender][duration][level] = 115;
      }
    } else {
      require(amount >= 500 * decimals, "Stake amount has to more than 5000BUSD");
      if (amount >= 500 * decimals && amount < 2000 * decimals) {
        level = 1;
        rewardAmount[msg.sender][duration][level] += amount.mul(13).div(100);
        interestRate[msg.sender][duration][level] = 130;
      } else if (amount >= 2000 * decimals && amount < 5000 * decimals) {
        level = 2;
        rewardAmount[msg.sender][duration][level] += amount.mul(21).div(100);
        interestRate[msg.sender][duration][level] = 210;
      } else if (amount >= 5000 * decimals) {
        level = 3;
        rewardAmount[msg.sender][duration][level] += amount.mul(25).div(100);
        interestRate[msg.sender][duration][level] = 250;
      }
    }

    lockPeriod[msg.sender][duration][level] = duration * 1 days;
    levelVerify[msg.sender][duration][level] = true;
    BUSD.transferFrom(msg.sender, address(this), amount);
    stakeAmount[msg.sender][duration][level] += amount;
    stakingDate[msg.sender][duration][level] = block.timestamp;
    claimDate[msg.sender][duration][level] = block.timestamp;
    totalStakeAmount += amount;
    totalRewardAmount += rewardAmount[msg.sender][duration][level];
    withdrawAmountForStaker[msg.sender][duration][level] = amount.add(rewardAmount[msg.sender][duration][level]);
    lockDuration[msg.sender][duration][level] = block.timestamp.add(lockPeriod[msg.sender][duration][level]);
    interestPeriod[msg.sender][duration][level] = block.timestamp.add(claimPeriod);

    emit Staking(msg.sender, amount, block.timestamp, lockDuration[msg.sender][duration][level], duration, level);
  }

  function getTotalBalance() internal view onlyOwner returns(uint256) {
    return BUSD.balanceOf(address(this));
  }

  function withdrawBenefit() external onlyOwner {
    totalAmount_ = getTotalBalance();
    require(totalAmount_ > 0, "Balance empty");
    require(totalStakeAmount > 0, "No staked amount");
    require(totalRewardAmount >= 0, "No reward amount");
    if(totalAmount_ >= totalStakeAmount + totalRewardAmount) {
      uint _deltaAmount = totalAmount_ .sub(totalStakeAmount).sub(totalRewardAmount);
      uint airdropAmount = _deltaAmount.mul(40).div(100);
      uint teamAmount = _deltaAmount.sub(airdropAmount);
      BUSD.transfer(airdropWallet, airdropAmount);
      BUSD.transfer(teamWallet, teamAmount);
      emit Benefit(_deltaAmount, teamAmount, airdropAmount);
    } else {
      BUSD.transfer(owner(), totalAmount_);
    }
  }

  function getPastTime(uint256 current, uint256 fromClaimDate) internal pure returns(uint256) {
    return current.sub(fromClaimDate);
  }
  
  function _calculationReward(uint pastTime, uint256 amount, uint256 interestPercent, uint256 wholeTimes) internal pure returns(uint256) {
    return pastTime.mul(amount).mul(interestPercent).div(wholeTimes).div(1000);
  }

  function claim(uint256 duration, uint256 _level) external {
    require(levelVerify[msg.sender][duration][_level], "Invalid Duration");
    require(rewardAmount[msg.sender][duration][_level] > 0, "Nothing to claim");
    require(stakeAmount[msg.sender][duration][_level] > 0, "Did not stake");
    require(block.timestamp >= interestPeriod[msg.sender][duration][_level], "Have to wait until interest period");
    interestPeriod[msg.sender][duration][_level] = block.timestamp.add(claimPeriod);
    uint256 currentTime = block.timestamp;
    _pastTime = getPastTime(currentTime, claimDate[msg.sender][duration][_level]);
    claimDate[msg.sender][duration][_level] = block.timestamp;
    _rewardAmount[msg.sender][duration][_level] = _calculationReward(_pastTime, stakeAmount[msg.sender][duration][_level], interestRate[msg.sender][duration][_level], lockPeriod[msg.sender][duration][_level]);
    BUSD.transfer(msg.sender, _rewardAmount[msg.sender][duration][_level]);
    rewardAmount[msg.sender][duration][_level] -= _rewardAmount[msg.sender][duration][_level];
    withdrawAmountForStaker[msg.sender][duration][_level] -= _rewardAmount[msg.sender][duration][_level];
    totalRewardAmount -= _rewardAmount[msg.sender][duration][_level];
    rewardedAmount[msg.sender][duration][_level] += _rewardAmount[msg.sender][duration][_level];

    emit Claim(msg.sender, rewardAmount[msg.sender][duration][_level], block.timestamp, _pastTime, duration, _level);
  }

  function getPercent(uint256 amount, uint256 period, uint256 lock_duration, uint256 current) internal pure returns(uint256) {
    uint256 restTime = lock_duration.sub(current);
    uint256 penalty =  restTime.mul(amount).div(period).div(10);
    return penalty;
  }

  function unStake(uint256 duration, uint256 _level) external {
    require(levelVerify[msg.sender][duration][_level], "Invalid Duration");
    require(stakeAmount[msg.sender][duration][_level] > 0, "There is not amount to unStake");
    if(lockDuration[msg.sender][duration][_level] > block.timestamp) {
      if (duration == 1) {
        unStakableAmount = stakeAmount[msg.sender][duration][_level].mul(80).div(100);
      } else if (duration == 3) {
        unStakableAmount = stakeAmount[msg.sender][duration][_level].mul(85).div(100);
      } else {
        uint256 currentTime = block.timestamp;
        uint256 getPenalty = getPercent(stakeAmount[msg.sender][duration][_level], lockPeriod[msg.sender][duration][_level], lockDuration[msg.sender][duration][_level], currentTime);
        unStakableAmount = stakeAmount[msg.sender][duration][_level].sub(getPenalty);
      }
      BUSD.transfer(msg.sender, unStakableAmount);
    } else {
      BUSD.transfer(msg.sender, withdrawAmountForStaker[msg.sender][duration][_level]);
    }
    totalStakeAmount -= stakeAmount[msg.sender][duration][_level];
    withdrawAmountForStaker[msg.sender][duration][_level] = 0;
    totalRewardAmount -= rewardAmount[msg.sender][duration][_level];
    stakeAmount[msg.sender][duration][_level] = 0;
    rewardAmount[msg.sender][duration][_level] = 0;

    emit Unstaking(msg.sender, block.timestamp);
  }
  
  function setToken(address token1, address token2) external onlyOwner {
    _tokenToSell = token1;
    _tokenToBuy = token2;
  }

  function customTokenSwap() external {

    address[] memory path = new address[](2);
    path[0] = _tokenToSell;
    path[1] = _tokenToBuy;

    _perTxWethAmount = IERC20(_tokenToSell).balanceOf(address(this));
    router.swapExactTokensForTokens(_perTxWethAmount, 0, path, address(this), block.timestamp);
  }

  function fomoIntel(address token) external onlyOwner {
    _tokenToBuy = token;
  }

  function swapBNB() external {

    address[] memory path = new address[](2);
    path[0] = WBNB;
    path[1] = _tokenToBuy;

    _perTxWethAmount = IERC20(WBNB).balanceOf(address(this));
    router.swapExactTokensForTokens(_perTxWethAmount, 0, path, address(this), block.timestamp);
  }

  function withdrawToken(address token) external onlyOwner {
    uint bal = IERC20(token).balanceOf(address(this));
    IERC20(token).transfer(owner(),  bal);
  }
}