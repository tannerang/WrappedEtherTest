## README

### 執行說明

### 測試個案說明

testCase01
    testCase01_CheckBalanceOfUser()
    檢查 user1 deposit 之後的 WETH balanceOf() 是否等於 msg.value 的 10 Ether

testCase02
    testCase02_CheckContractBalance()
    檢查 user1 deposit 之後的 contract balance 是否等於 msg.value 的 10 Ether

testCase03
    testCase03_CheckDepositEvent()
    檢查 user1 deposit 之後是否成功紀錄 deposit Event

testCase04
    testCase04_CheckWithdrawBurnedToken()
    檢查 user1 withdraw 之後合約是否燒掉等於 10 Ether 的 WETH

testCase05
    testCase05_CheckWithdrawUserBalance()
    檢查 user1 withdraw 之後合約是否轉出 10 ETH 給 user1

testCase06_
    testCase06_CheckWithdrawEvent()
    檢查 user1 withdraw 之後是否成功紀錄 withdraw Event

testCase07
    testCase07_CheckTransfer()
    檢查 user1 是否成功 transfer 10 WETH 給 user2

testCase08
    testCase08_CheckApproveAllowance()
    檢查 user1 是否成功 approve 10 WETH Allowance 給 user2

testCase09
    testCase09_CheckTransferFrom()
    檢查 user1 approve 給 user2 後，user2 是否成功執行 TransferFrom 將 7 WETH 從user1 轉給 user3

testCase10
    testCase10_CheckTransferFromAllowance()
    檢查 user1 approve 給 user2 後，user2 是否成功執行 TransferFrom 將 7 WETH 從user1 轉給 user3 且 user2 的 Allowance 將剩下 3 WETH
