#include <string>

#include "VMTranslator.h"

using namespace std;

int gtcount = 1;
int ltcount = 1;
int eqcount = 1;
int functioncount = 1;
/**
 * VMTranslator constructor
 */
VMTranslator::VMTranslator() {
    // Your code here
}

/**
 * VMTranslator destructor
 */
VMTranslator::~VMTranslator() {
    // Your code here
}

/** Generate Hack Assembly code for a VM push operation */
string VMTranslator::vm_push(string segment, int offset){
    string code = "@";
    code += to_string(offset);
    code +="\nD=A\n";
    if (segment == "static"){
            code += "@16\nA=A+D\nD=M\n";
    }else if(segment == "pointer"){
            code += "@3\nA=A+D\nD=M\n";
    }else if(segment == "temp"){
            code += "@5\nA=A+D\nD=M\n";
    }else if(segment == "local"){
            code += "@LCL\nA=M+D\nD=M\n";
    }else if(segment == "argument"){
            code += "@ARG\nA=M+D\nD=M\n";
    }else if(segment == "this"){
            code += "@THIS\nA=M+D\nD=M\n";
    }else if(segment == "that"){
            code += "@THAT\nA=M+D\nD=M\n";
    }
    code += "@SP\nAM=M+1\nA=A-1\nM=D";
    return code;
}

/** Generate Hack Assembly code for a VM pop operation */
string VMTranslator::vm_pop(string segment, int offset){    
    string code = "@SP\nAM=M-1\nD=M\n";

    if (segment == "static"){
            code += "@16\n";
    }else if(segment == "pointer"){
            code += "@3\n";
    }else if(segment == "temp"){
            code += "@5\n";
    }else if(segment == "local"){
            code += "@LCL\nA=M\n";
    }else if(segment == "argument"){
            code += "@ARG\nA=M\n";
    }else if(segment == "this"){
            code += "@THIS\nA=M\n";
    }else if(segment == "that"){
            code += "@THAT\nA=M\n";
    }
    for (int i=0;i<offset;i++){
        code += "A=A+1\n";
    }
    code += "M=D";
    return code;
}

/** Generate Hack Assembly code for a VM add operation */
string VMTranslator::vm_add(){
    return "@SP\nAM=M-1\nD=M\nA=A-1\nM=D+M";
}

/** Generate Hack Assembly code for a VM sub operation */
string VMTranslator::vm_sub(){
    return "@SP\nAM=M-1\nD=M\nA=A-1\nM=M-D";
}

/** Generate Hack Assembly code for a VM neg operation */
string VMTranslator::vm_neg(){
    return "@SP\nAM=M-1\nM=-M\n@SP\nM=M+1";
}

/** Generate Hack Assembly code for a VM eq operation */
string VMTranslator::vm_eq(){
    eqcount++;
    return "@SP\nAM=M-1\nD=M\nA=A-1\nD=M-D\nM=-1\n@EQUAL."+to_string(eqcount)+"\nD;JEQ\n@SP\nA=M-1\nM=0\n(EQUAL."+to_string(eqcount)+")";

}

/** Generate Hack Assembly code for a VM gt operation */
string VMTranslator::vm_gt(){
    gtcount++;
    return "@SP\nAM=M-1\nD=M\nA=A-1\nD=M-D\nM=-1\n@GREATER."+to_string(gtcount)+"\nD;JGT\n@SP\nA=M-1\nM=0\n(GREATER."+to_string(gtcount)+")";

}

/** Generate Hack Assembly code for a VM lt operation */
string VMTranslator::vm_lt(){
    ltcount++;
    return "@SP\nAM=M-1\nD=M\nA=A-1\nD=D-M\nM=-1\n@LESS."+to_string(ltcount)+"\nD;JGT\n@SP\nA=M-1\nM=0\n(LESS."+to_string(ltcount)+")";

}

/** Generate Hack Assembly code for a VM and operation */
string VMTranslator::vm_and(){
    return "@SP\nAM=M-1\nD=M\nA=A-1\nM=D&M";

}

/** Generate Hack Assembly code for a VM or operation */
string VMTranslator::vm_or(){
    return "@SP\nAM=M-1\nD=M\nA=A-1\nM=D|M";

}

/** Generate Hack Assembly code for a VM not operation */
string VMTranslator::vm_not(){
    return "@SP\nA=M-1\nD=M\nM=!D";
}

/** Generate Hack Assembly code for a VM label operation */
string VMTranslator::vm_label(string label){
    return "(" + label + ")";
}

/** Generate Hack Assembly code for a VM goto operation */
string VMTranslator::vm_goto(string label){
    return "@" + label + "\n0;JMP";
}

/** Generate Hack Assembly code for a VM if-goto operation */
string VMTranslator::vm_if(string label){
    return "@SP\nAM=M-1\nD=M\n@" + label + "\nD;JNE";
}

/** Generate Hack Assembly code for a VM function operation */
string VMTranslator::vm_function(string function_name, int n_vars){
    string code = "("+ function_name +")\n";
    for (int i=0; i<n_vars;i++){
        code += "@SP\nAM=M+1\nA=A-1\nM=0\n";
    }
    return code;
}

/** Generate Hack Assembly code for a VM call operation */
string VMTranslator::vm_call(string function_name, int n_args){
    string returnaddress = function_name + "$ret." + to_string(functioncount++);
    string code = "@"+returnaddress+"\nD=A\n@SP\nAM=M+1\nA=A-1\nM=D\n";
    code+="@LCL\nD=M\n@SP\nAM=M+1\nA=A-1\nM=D\n";
    code+="@ARG\nD=M\n@SP\nAM=M+1\nA=A-1\nM=D\n";
    code+="@THIS\nD=M\n@SP\nAM=M+1\nA=A-1\nM=D\n";
    code+="@THAT\nD=M\n@SP\nAM=M+1\nA=A-1\nM=D\n";
    code+="@SP\nD=M\n@5\nD=D-A\n@"+ to_string(n_args) +"\nD=D-A\n@ARG\nM=D\n";
    code+="@SP\nD=M\n@LCL\nM=D\n";
    code+="@"+ function_name +"\n";
    code+="0;JMP\n";
    code+="("+returnaddress+")";
    return code;
}

/** Generate Hack Assembly code for a VM return operation */
string VMTranslator::vm_return(){
    string code = "@LCL\nD=M\n";
    code += "@5\nA=D-A\nD=M\n@retAddr\nM=D\n";
    code += "@SP\nA=M-1\nD=M\n@ARG\nA=M\nM=D\n";
    code += "@ARG\nD=M+1\n@SP\nM=D\n";
    code += "@LCL\nAM=M-1\nD=M\nD=M\n@THAT\nM=D\n";
    code += "@LCL\nAM=M-1\nD=M\nD=M\n@THIS\nM=D\n";
    code += "@LCL\nAM=M-1\nD=M\nD=M\n@ARG\nM=D\n";
    code += "@LCL\nAM=M-1\nD=M\nD=M\n@LCL\nM=D\n";
    code += "@retAddr\nA=M\n0;JMP";
    return code;
}                    