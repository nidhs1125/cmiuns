#include "BasicBlock.h"
#include "Constant.h"
#include "Function.h"
#include "IRBuilder.h"
#include "Module.h"
#include "Type.h"

#include <iostream>
#include <memory>

#ifdef DEBUG
#define DEBUG_OUTPUT std::cout << __LINE__ << std::endl;
#else
#define DEBUG_OUTPUT
#endif

#define CONST_INT(num) \
    ConstantInt::get(num, module)

#define CONST_FP(num) \
    ConstantFP::get(num, module)

int main() {
  auto module = new Module("if.c");
  auto builder = new IRBuilder(nullptr, module);
  Type *Int32Type = Type::get_int32_type(module);  
  Type *FloatType = Type::get_float_type(module);
  
  // intialize main
  auto mainFun = Function::create(FunctionType::get(Int32Type, {}),"main", module);
  auto bb = BasicBlock::create(module, "entry", mainFun);
  builder->set_insert_point(bb);
  
  // alloc float a = 5.555;
  auto aAlloca = builder->create_alloca(FloatType);
  builder->create_store(CONST_FP(5.555),aAlloca);
  auto aLoad = builder->create_load(aAlloca);
  
  auto fcmp = builder->create_fcmp_gt(aLoad,CONST_FP(1));
  auto trueBB = BasicBlock::create(module,"trueBB",mainFun);
  auto falseBB = BasicBlock::create(module,"falseBB",mainFun);
  auto br = builder->create_cond_br(fcmp, trueBB, falseBB);
  
  // if true
  builder->set_insert_point(trueBB);
  builder->create_ret(CONST_INT(233));
  
  // else false
  builder->set_insert_point(falseBB);
  builder->create_ret(CONST_INT(0));
  
  std::cout << module->print();
  delete module;
  return 0;
}