struct Command
{
  enum Action { deposit, withdraw } action;
  int amount{0};
  bool success{false};
};

struct Account
{
  int balance{0};

  void process(Command& cmd)
  {
    switch(cmd.action) {
        case Command::deposit:
            if (cmd.amount < 0) {
                cmd.success = false;
            } else {
                balance += cmd.amount;
                cmd.success = true;                
            }
            break;
        case Command::withdraw:
            if (balance < cmd.amount) {
                cmd.success = false;
            } else {
                balance -= cmd.amount;
                cmd.success = true;
            }
            break;
    }
  }
};
