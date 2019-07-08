#include <vector>
using namespace std;

struct Creature;
struct Game
{
  vector<Creature*> creatures;
};

struct Creature
{
protected:
  Game& game;
  int base_attack, base_defense;

public:
  Creature(Game &game, int base_attack, int base_defense) : game(game),
  base_attack(base_attack), base_defense(base_defense) {}
  virtual int get_attack() = 0;
  virtual int get_defense() = 0;
  virtual bool is_king() = 0;
};

class Goblin : public Creature
{
public:
  Goblin(Game &game, int base_attack, int base_defense) : Creature(game, base_attack, base_defense) {}

  Goblin(Game &game) : Creature(game, 1, 1) {}
  
  bool is_king() override {
      return false;
  }

  int get_attack() override {
    int attack = base_attack;
    for (auto creature : game.creatures) {
        if (creature->is_king()) {
            attack += 1;
        }
    }
    return attack;
  }

  int get_defense() override {
    return base_defense + game.creatures.size() -1;
  }
};

class GoblinKing : public Goblin
{
public:
  GoblinKing(Game &game) : Goblin(game, 3, 3) {}
  
  bool is_king() override {
      return true;
  }
  
  int get_attack() override {
     return base_attack;
  }
  
  int get_defense() override {
      return base_defense + game.creatures.size() -1;
  }
};
