#include <pybind11/pybind11.h>
#include "pet.h"

#define STRINGIFY(x) #x
#define MACRO_STRINGIFY(x) STRINGIFY(x)

int add(int i, int j) {
    return i + j;
}

namespace py = pybind11;

PYBIND11_MODULE(cmake_example, m) {
    m.doc() = R"pbdoc(
        Pybind11 example plugin
        -----------------------

        .. currentmodule:: cmake_example

        .. autosummary::
           :toctree: _generate

           add
           subtract
    )pbdoc";

    m.def("add", &add, R"pbdoc(
        Add two numbers

        Some other explanation about the add function.
    )pbdoc");

    m.def("subtract", [](int i, int j) { return i - j; }, R"pbdoc(
        Subtract two numbers

        Some other explanation about the subtract function.
    )pbdoc");

#ifdef VERSION_INFO
    m.attr("__version__") = MACRO_STRINGIFY(VERSION_INFO);
#else
    m.attr("__version__") = "dev";
#endif

    py::class_<ProjExample::Pet>(m, "Pet")
      .def(py::init<const std::string &>())
      .def("setName", &ProjExample::Pet::setName)
      .def("getName", &ProjExample::Pet::getName);

    //py::class_<ProjExample::Dog, ProjExample::Pet /* <- specify C++ parent type */>(m, "Dog")
    //  .def(py::init<const std::string &>())
    //  .def("bark", &ProjExample::Dog::bark);

    py::class_<ProjExample::Dog>(m, "nEGGADog")
      .def(py::init<const std::string &>())
      .def("bark", &ProjExample::Dog::bark);
}
