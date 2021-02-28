import Foundation

//----------------------------Defining Classes----------------------------//

//Creating a Base class named accounts


import Foundation

class Customer{
    //declaring variables
    var customer_fname:String
    var customer_mname:String
    var customer_lname:String
    var dob:String
    var age:Int
    //adhaar number is used as id to identify the customer
    var adhaar_number:Int
    var contact_number:Int
    var alternative_contact_number:Int
    var address:String
    var account_number:String
    let account_type:String
    var pin:Int
   //constructor 
    init(customer_fname:String,customer_mname:String,customer_lname:String,dob:String,age:Int,adhaar_number:Int,contact_number:Int,alternative_contact_number:Int,address:String,account_number:String,account_type:String,pin:Int){
        //initilizing variables
        self.customer_fname = customer_fname
        self.customer_mname = customer_mname
        self.customer_lname = customer_lname
        self.dob = dob
        self.age = age
        self.adhaar_number = adhaar_number
        self.contact_number = contact_number
        self.alternative_contact_number = alternative_contact_number
        self.address = address
        self.account_number = account_number
        self.account_type = account_type   
        self.pin = pin
    }
    //Function will print details of the customer
    func printDetails(){
        
    }
    
    //Function will credited to money in customer's account
    func depositMoney(amount:Double)->Int{
        return 1
    }
    
    //Function will debit amount from the customer's account
    func withdrawMoney(amount:Double){
        
    }
    //Function gets amount and account_number and transfer that amount to respective account_number
    func transferMoney(amount:Double,account_number:String){
        
    }
    
    //Function provide new pin to customer
    func changePin(){
        repeat{
            print("Enter a new pin OR Enter 0 to cancel")
            let changepin = Int(readLine()!)!
            if changepin == 0{
                break
            }
            print("Confirm Pin")
            if changepin == Int(readLine()!)!{
                self.pin = changepin
                print("pin is changed")
                break
            }
            else{
                print("Pins doesn't Macthed\n")
                print("Please Re-enter\n")
            }
        }while true
    }
    
    //this function will return date and time
    func getDateAndTime()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
        let dateString = dateFormatter.string(from:Date())
        return dateString
    }
    
}

//creating a class named child savings account inherted from Customer class
class SavingsAccount:Customer{
    //declaring variables
    var balance:Double
    
    //constructor of SavingsAccount class
    init(customer_fname:String,customer_mname:String,customer_lname:String,dob:String,age:Int,adhaar_number:Int,contact_number:Int,alternative_contact_number:Int,address:String,account_number:String,account_type:String,balance:Double,pin:Int){
        //initilizing variable
        self.balance = balance
        //call initilizer from base class
        super.init(customer_fname:customer_fname,customer_mname:customer_mname,customer_lname:customer_lname,dob:dob,age:age,adhaar_number:adhaar_number,contact_number:contact_number,alternative_contact_number:alternative_contact_number,address:address,account_number:account_number,account_type:account_type,pin:pin)
    }
    
    //funtion will print the details of account holder
    override func printDetails(){
        print("============================================================================================")
        print("Name of the customer:\(self.customer_fname) \(self.customer_mname) \(self.customer_lname)\n")
        print("Account Number is:\(self.account_number)\n")
        print("Type of Account:\(self.account_type)\n")
        print("Balance:\(self.balance)\n")
        print("============================================================================================")
    }
    
    //Function will deposit money in customer's Savings Account
    override func depositMoney(amount:Double)->Int{
        let balance_before = self.balance
        self.balance = self.balance + amount
        let datetime = String(getDateAndTime())
        details.append(Transactions(customer_fname:self.customer_fname,customer_mname:self.customer_mname,customer_lname:self.customer_lname,dob:self.dob,age:self.age,adhaar_number:self.adhaar_number,contact_number:self.contact_number,alternative_contact_number:self.alternative_contact_number,address:self.address,account_number:self.account_number,account_type:self.account_type,pin:self.pin,before_transaction_balance:balance_before,after_transaction_balance:self.balance,amount_transacted:amount,datetime:datetime,transaction_type:"Credited"))
        return 1
    }
    
    //Function will get amount as parameter and withdraw same amount of money from account
    func withdrawMoney(amount:Double)->Int{
        if self.balance < amount{
            print("You does not have sufficent amount in your account\n")
            print("Account Balance:\(balance)")
            return 0
        }
        else if(amount > 25000){
            print("You entered a amount greater than your withdraw limit!")
            return 0
        }
        else {
            let balance_before = self.balance
            self.balance -= amount
            print("Amount \(amount) is debited from your account\n")
            print("Account Balance is :\(self.balance)")
            let datetime = String(getDateAndTime())
            details.append(Transactions(customer_fname:self.customer_fname,customer_mname:self.customer_mname,customer_lname:self.customer_lname,dob:self.dob,age:self.age,adhaar_number:self.adhaar_number,contact_number:self.contact_number,alternative_contact_number:self.alternative_contact_number,address:self.address,account_number:self.account_number,account_type:self.account_type,pin:self.pin,before_transaction_balance:balance_before,after_transaction_balance:self.balance,amount_transacted:amount,datetime:datetime,transaction_type:"Debited"))
            return 1
        }
    }
    
    //Function gets amount and account_number and transfer that amount to respective account_number
    override func transferMoney(amount:Double,account_number:String){
        //counter 
        var n = 0
        for obj in details{
            if obj.account_number == account_number{
                n += 1
                print("============================================================================================")
                print("Account Holder Name:\(obj.customer_fname) \(obj.customer_mname) \(obj.customer_lname)")
                print("Want to transfer money")
                print("Enter 'y' for yes and 'n' for no")
                if readLine()! == "y"{
                    if obj.depositMoney(amount:amount) == 1{
                        let balance_before = self.balance
                        self.balance -= amount
                        let datetime = String(getDateAndTime())
                        details.append(Transactions(customer_fname:self.customer_fname,customer_mname:self.customer_mname,customer_lname:self.customer_lname,dob:self.dob,age:self.age,adhaar_number:self.adhaar_number,contact_number:self.contact_number,alternative_contact_number:self.alternative_contact_number,address:self.address,account_number:self.account_number,account_type:self.account_type,pin:self.pin,before_transaction_balance:balance_before,after_transaction_balance:self.balance,amount_transacted:amount,datetime:datetime,transaction_type:"Transfer to \(account_number)"))
                        print("Done")   
                    }
                    else{
                        print("Some problem occured")
                    }
                }
                else{
                    print("Transaction cancelled")
                }
            }
            
        }
        if n == 0{
                print("No record Found")
        }
    }
}
//creating a class named child current account inherted from Customer class
class CurrentAccount:Customer{
    
    var balance:Double
    var minimun_balance:Double
    //constructor of SavingsAccount class
    init(customer_fname:String,customer_mname:String,customer_lname:String,dob:String,age:Int,adhaar_number:Int,contact_number:Int,alternative_contact_number:Int,address:String,account_number:String,account_type:String,balance:Double,minimun_balance:Double,pin:Int){
        
        self.balance = balance
        self.minimun_balance = minimun_balance
        //call initilizer from base class
        super.init(customer_fname:customer_fname,customer_mname:customer_mname,customer_lname:customer_lname,dob:dob,age:age,adhaar_number:adhaar_number,contact_number:contact_number,alternative_contact_number:alternative_contact_number,address:address,account_number:account_number,account_type:account_type,pin:pin)
    }
    
    //funtion will print the details of account holder
    override func printDetails(){
        print("============================================================================================")
        print("Name of the customer:\(self.customer_fname) \(self.customer_mname) \(self.customer_lname)\n")
        print("Account Number is:\(self.account_number)\n")
        print("Type of Account:\(self.account_type)\n")
        print("Balance:\(self.balance)\n")
        print("============================================================================================")
    }
    
    //Function will deposit money in customer's Current Account
    override func depositMoney(amount:Double)->Int{
        let balance_before = self.balance
        self.balance = self.balance + amount
        let datetime = String(getDateAndTime())
        details.append(Transactions(customer_fname:self.customer_fname,customer_mname:self.customer_mname,customer_lname:self.customer_lname,dob:self.dob,age:self.age,adhaar_number:self.adhaar_number,contact_number:self.contact_number,alternative_contact_number:self.alternative_contact_number,address:self.address,account_number:self.account_number,account_type:self.account_type,pin:self.pin,before_transaction_balance:balance_before,after_transaction_balance:self.balance,amount_transacted:amount,datetime:datetime,transaction_type:"Credited"))
        return 1
    }
    
    //Function will get amount as parameter and withdraw same amount from balance
    override func withdrawMoney(amount:Double){
        if self.balance < amount{
            print("You does not have sufficent amount in your account\n")
            print("Account Balance:\(balance)")
        }
        else {
            let balance_before = self.balance
            self.balance -= amount
            print("Amount \(amount) is debited from your account\n")
            print("Account Balance is :\(self.balance)")
            let datetime = String(getDateAndTime())
            details.append(Transactions(customer_fname:self.customer_fname,customer_mname:self.customer_mname,customer_lname:self.customer_lname,dob:self.dob,age:self.age,adhaar_number:self.adhaar_number,contact_number:self.contact_number,alternative_contact_number:self.alternative_contact_number,address:self.address,account_number:self.account_number,account_type:self.account_type,pin:self.pin,before_transaction_balance:balance_before,after_transaction_balance:self.balance,amount_transacted:amount,datetime:datetime,transaction_type:"Debited"))
            
        }
    }
    //Function gets amount and account_number and transfer that amount to respective account_number
    override func transferMoney(amount:Double,account_number:String){
        //counter 
        var n = 0
        for obj in details{
            if obj.account_number == account_number{
                n += 1
                print("============================================================================================")
                print("Account Holder Name:\(obj.customer_fname) \(obj.customer_mname) \(obj.customer_lname)")
                print("Want to transfer money")
                print("Enter 'y' for yes and 'n' for no")
                if readLine()! == "y"{
                    if obj.depositMoney(amount:amount) == 1{
                        let balance_before = self.balance
                        self.balance -= amount
                        let datetime = String(getDateAndTime())
                        details.append(Transactions(customer_fname:self.customer_fname,customer_mname:self.customer_mname,customer_lname:self.customer_lname,dob:self.dob,age:self.age,adhaar_number:self.adhaar_number,contact_number:self.contact_number,alternative_contact_number:self.alternative_contact_number,address:self.address,account_number:self.account_number,account_type:self.account_type,pin:self.pin,before_transaction_balance:balance_before,after_transaction_balance:self.balance,amount_transacted:amount,datetime:datetime,transaction_type:"Transfer to \(account_number)"))
                        print("Done")   
                    }
                    else{
                        print("Some problem occured")
                    }
                }
                else{
                    print("Transaction cancelled")
                }
            }
            
        }
        if n == 0{
                print("No record Found")
        }
    }
}

//class to get and show transactions
class Transactions:Customer{
//declaring variables
    var before_transaction_balance:Double
    var after_transaction_balance:Double
    var amount_transacted:Double
    var datetime:String
    var transaction_type:String
    init(customer_fname:String,customer_mname:String,customer_lname:String,dob:String,age:Int,adhaar_number:Int,contact_number:Int,alternative_contact_number:Int,address:String,account_number:String,account_type:String,pin:Int,before_transaction_balance:Double,after_transaction_balance:Double,amount_transacted:Double,datetime:String,transaction_type:String){
        //initilizing variables
        self.before_transaction_balance = before_transaction_balance
        self.after_transaction_balance = after_transaction_balance
        self.amount_transacted = amount_transacted
        self.datetime = datetime
        self.transaction_type = transaction_type
        super.init(customer_fname:customer_fname,customer_mname:customer_mname,customer_lname:customer_lname,dob:dob,age:age,adhaar_number:adhaar_number,contact_number:contact_number,alternative_contact_number:alternative_contact_number,address:address,account_number:account_number,account_type:account_type,pin:pin)
    }
    
    //showTransactions function gets account number as parameter and prints the Transaction
    func showTransactions(account_number:String){
        if self.account_number == account_number{
            print("============================================================")
            print("Transaction date time:\(self.datetime)")
            print("Balance before Transaction:\(self.before_transaction_balance)")
            print("Amount \(self.transaction_type):\(self.amount_transacted)")
            print("Balance :\(self.after_transaction_balance)")
            print("============================================================")
        }
    }
}


//----------------------------End of class definations----------------------------//

//----------------------------Main----------------------------//

//----------------------------Defining funtions of Main----------------------------//

//Creating an empty array
var details = [Customer]()

//Funtion fillData get data from user and append it to hetrogenous array
func fillData(){

//increment variables for savings and CurrentAccount
var sav = 0 
var cur = 0
    repeat{//this repeat will go on until user input anything else then y
        print("Enter type of account:\n1 For Savings Account\n2 For Current Account")
        let choice = readLine()!
        print("Enter First name of customer")
        let customer_fname = readLine()!
        print("Enter Middle name of customer")
        let customer_mname = readLine()!
        print("Enter Last name of customer")
        let customer_lname = readLine()!
        print("Enter DOB of customer:dd/mm/yyyy")
        let dob = readLine()!
        print("Enter age of customer")
        let age = Int(readLine()!)!
        print("Enter Adhaar number of customer")
        let adhaar_number = Int(readLine()!)!
        print("Enter Contact Number of customer")
        let contact_number = Int(readLine()!)!
        print("Enter Alternative Contact Number of customer")
        let alternative_contact_number = Int(readLine()!)!
        print("Enter address of customer")
        let address = readLine()!
        print("Enter opening balance")
        let opening_balance = Double(readLine()!)!
        switch choice{
            case "1":
                sav += 1
                let account_type = "Savings"
                print("Account Type:\(account_type)\n")
                let account_number = "SAV" + String(sav)
                print("Account Number provided:\(account_number)")
                print("Provide a pin")
                let pin = Int(readLine()!)!
                details.append(SavingsAccount(customer_fname:customer_fname,customer_mname:customer_mname,customer_lname:customer_lname,dob:dob,age:age,adhaar_number:adhaar_number,contact_number:contact_number,alternative_contact_number:alternative_contact_number,address:address,account_number:account_number,account_type:account_type,balance:opening_balance,pin:pin))
            case "2":
                cur += 1
                let account_type = "Current"
                print("Account Type:\(account_type)\n")
                let account_number = "CUR" + String(cur)
                print("Account Number provided:\(account_number)")
                print("Enter an Minimun balance limit")
                let minimun_balance = Double(readLine()!)!
                print("Provide a pin")
                let pin = Int(readLine()!)!
                details.append(CurrentAccount(customer_fname:customer_fname,customer_mname:customer_mname,customer_lname:customer_lname,dob:dob,age:age,adhaar_number:adhaar_number,contact_number:contact_number,alternative_contact_number:alternative_contact_number,address:address,account_number:account_number,account_type:account_type,balance:opening_balance,minimun_balance:minimun_balance,pin:pin))
            default:
            print("Wrong Choice")
        }
        
        
        
        print("Do you want to create more accounts: y/n")
    }while(readLine()! == "y")
    

}


//Function useBank will get account_number and pin as parameters and return an integer value
func useBank(account_number:String,pin:Int){
    //defining and initilizing a number for count
    var savingswithdrawal = 0
    var ac = 0
    var pi = 0
    for obj in details{
        if obj.account_number == account_number{//Account Number and pin matched further statement will be implemented and at last it will return 1 and if not matched will return 0
            ac += 1
            if obj.pin == pin{
                pi += 1
                if obj is CurrentAccount{//If object is a insatance of CurrentAccount class then ture
                    print("It is a Current Account\n")
                    var loop = 1
                    repeat{
                        if (obj as! CurrentAccount).balance < (obj as! CurrentAccount).minimun_balance{
                        print("=================Alert=================")
                        print("Account balance is less then Minimun Balance Limit")
                        }
                        print("Please select your option:\n0 For Exit\n1 For Deposit Money\n2 For Withdraw Money\n3 For Account details\n4 For Pin change\n5 To Display Transactions\n6 For Money Transfer")
                        switch (Int(readLine()!)!){
                            case 0:
                                loop = 0
                            case 1:
                                print("Enter amount you want to  deposit:")
                                let amountdeposit = Double(readLine()!)!
                                let success = obj.depositMoney(amount:amountdeposit)
                                if success == 1{
                                    print("Money Deposited")
                                    print("Avaliable Balance:\((obj as! CurrentAccount).balance)")
                                }
                            case 2:
                                print("Enter amount you want to withdraw:")
                                let amountwithdraw = Double(readLine()!)!
                                obj.withdrawMoney(amount:amountwithdraw)
                            case 3:
                                obj.printDetails()
                            case 4:
                                obj.changePin()
                            case 5:
                                for obj in details{
                                    if obj is Transactions{
                                        if (obj as! Transactions).account_number == account_number{
                                            (obj as! Transactions).showTransactions(account_number:(obj as! Transactions).account_number)
                                        }
                                    }
                                }
                            case 6:
                                print("Enter amount you want to  transfer:")
                                let amountdeposit = Double(readLine()!)!
                                print("Enter Account Number of the person whom you want to transfer money")
                                let receiver_account = readLine()!
                                obj.transferMoney(amount:amountdeposit,account_number:receiver_account)
                                print("============================================================================================")
                            
                            default:
                                print("Wrong Choice")
                                    }
                    }while loop != 0
                }
                if obj is SavingsAccount{//If object is a insatance of SavingsAccount class then ture
                    print("It is a Savings Account")
                    var loop = 1
                    repeat{
                        print("Please select your option:\n0 For Exit\n1 For Deposit Money\n2 For Withdraw Money\n3 For Account details\n4 For Pin change\n5 To Display Transactions\n6 For Money Transfer")
                        switch (Int(readLine()!)!){
                            case 0:
                                loop = 0
                                break
                            case 1:
                                print("Enter amount you want to  deposit:")
                                let amountdeposit = Double(readLine()!)!
                                let success = obj.depositMoney(amount:amountdeposit)
                                if success == 1{
                                    print("Money Deposited")
                                    print("Avaliable Balance:\((obj as! SavingsAccount).balance)")
                                }
                            case 2:
                                if savingswithdrawal >= 4{
                                    print("Your Withdraw Transactions limit is up for the day")
                                }
                                else{
                                    print("Enter amount you want to withdraw:")
                                    let amountwithdraw = Double(readLine()!)!
                                    savingswithdrawal += (obj as! SavingsAccount).withdrawMoney(amount:amountwithdraw)
                                }
                            case 3:
                                obj.printDetails()
                            case 4:
                                obj.changePin()
                            case 5:
                                for obj in details{
                                    if obj is Transactions{
                                        if (obj as! Transactions).account_number == account_number{
                                            (obj as! Transactions).showTransactions(account_number:(obj as! Transactions).account_number)
                                        }
                                    }
                                }
                            case 6:
                                print("Enter amount you want to  transfer:")
                                let amountdeposit = Double(readLine()!)!
                                print("Enter Account Number of the person whom you want to transfer money")
                                let receiver_account = readLine()!
                                obj.transferMoney(amount:amountdeposit,account_number:receiver_account)
                                print("============================================================================================")
                            default:
                                print("Wrong Choice")
                                    }
                    }while loop != 0
                }
            }
        }
    }
    if ac == 0{
        print("Account Not Found")
    }
    if pi == 0{
        print("Pin doesn't match")
    }
}
//----------------------------End of funtion definations----------------------------//
//----------------------------calling funtions----------------------------//

//calling fillData Function
fillData()

//this statement is used to call useBank statement
var a = 1
system("clear")
repeat{
print("========================================================")
print("\tWelcome to your Bank")
print("========================================================")
print("Enter your Account Number")
let account_number = readLine()!
print("Enter your pin")
let pin = Int(readLine()!)!
useBank(account_number:account_number,pin:pin)
print("Enter 0 for exit the bank servies or Enter 1 to go to start")
a = Int(readLine()!)!
}while a != 0

//----------------------------End of main----------------------------//
