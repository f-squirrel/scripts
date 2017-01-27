PROJECT_NAME=$1
OUTPUT_MAKE=Makefile

write() {
    echo ${1} >> ${OUTPUT_MAKE}
}

if [ -z "$1"  ]
    then
        PWD=`pwd`
        PROJECT_NAME=`basename "${PWD}"`
        echo "No argument supplied. Current directory name is used for project name" 
fi

rm  -f ${OUTPUT_MAKE}

write "TARGET=${PROJECT_NAME}"
write 'TARGET_BINARY=$(TARGET).bin'

write "CC=clang++"
write "CPP_FLAGS=-W -Wall -g -std=c++14 -stdlib=libc++"
write 'SRC=$(wildcard *.cpp)'

write 'all: $(TARGET)'

write '$(TARGET):'
write '\t$(CC) $(CPP_FLAGS) $(SRC) -o $(TARGET_BINARY)'
write 'clean:'
write '\trm -f $(TARGET_BINARY)'
