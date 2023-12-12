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
	auto module = new Module("assign.c");
	auto builder = new IRBuilder(nullptr, module);
	Type *Int32Type = Type::get_int32_type(module);

	// main function
	auto mainFun = Function::create(FunctionType::get(Int32Type, {}),"main", module);
	auto bb = BasicBlock::create(module, "entry", mainFun);

	builder->set_insert_point(bb);
	
	//alloc an array
	auto *arrayType=ArrayType::get(Int32Type,10);
	auto initilizer=ConstantZero::get(Int32Type,module);
	auto aAlloca=builder->create_alloca(arrayType);
	//a[0]=10
	auto a0GEP=builder->create_gep(aAlloca,{CONST_INT(0),CONST_INT(0)});
	builder->create_store(CONST_INT(10),a0GEP);

	// a[1]=a[0]*2;
	auto a0Load=builder->create_load(a0GEP);
	auto mul=builder->create_imul(a0Load,CONST_INT(2));
	auto a1GEP=builder->create_gep(aAlloca,{CONST_INT(0),CONST_INT(1)});
	builder->create_store(mul,a1GEP);

	//return a[1];
	auto r=builder->create_load(a1GEP);
	builder->create_ret(r);

	std::cout << module->print();
	delete module;
	return 0;
}