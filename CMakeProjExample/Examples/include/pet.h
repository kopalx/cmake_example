///
/// @file PIP.h
///
/// @brief definition file for PIP module
///
///
/// @author AlexK
///
///
/// @notes
///       1) 
///       2)

#ifndef _pet_h_
#define _pet_h_

#include <string>

namespace ProjExample {

struct Pet {
    Pet(const std::string &name) : name(name) { }
    void setName(const std::string &name_) { name = name_; }
    const std::string &getName() const { return name; }

    std::string name;
};

struct Dog : Pet {
    Dog(const std::string &name) : Pet(name) { }
    std::string bark() const { return "woof!"; }
};

}  // namespace pip

#endif