#include <string>
#include <vector>
#include <ostream>
using namespace std;

class CodeBuilder;
class Code {
 public:
  friend ostream& operator<<(ostream& os, const Code& obj)
  {
    os << "class " << obj.class_name << "\n{\n";
    for (auto name_type : obj.field_map) {
        os << "  " << name_type.second << " " << name_type.first << ";" << "\n";
    }
    os << "};";
  }
 private:
  string class_name;
  vector<pair<string, string>> field_map;
  
  friend class CodeBuilder;
};

class CodeBuilder
{
public:
  CodeBuilder(const string& class_name)
  {
      code.class_name = class_name;
  }

  CodeBuilder& add_field(const string& name, const string& type)
  {
    code.field_map.emplace_back(name, type);
    return *this;
  }

  friend ostream& operator<<(ostream& os, const CodeBuilder& obj)
  {
    os << obj.code;

  }
  
  private:
   Code code;
};
