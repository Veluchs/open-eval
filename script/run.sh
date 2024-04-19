#!/bin/bash
NAME=$1
cp data/raw/hanhu_data/*hanhu*.py data/clean
python script/parse.py
for file in data/processed/*hanhu*wo_doc.py; do
    pytest "$file"
    if [ $? -ne 0 ]; then
        echo "Pytest failed on $file, stopping..."
        exit 1
    fi
done

for file in data/processed/*hanhu*w_doc.py; do
    pytest --doctest-modules "$file"
    if [ $? -ne 0 ]; then
        echo "Pytest failed on $file, stopping..."
        exit 1
    fi
done