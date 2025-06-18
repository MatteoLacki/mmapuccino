make:
    echo "Welcome to Project 'mmapuccino'"

upload_test_pypi:
    twine check dist/*
    python -m pip install --upgrade twine
    twine upload --repository testpypi dist/*

upload_pypi:
    twine check dist/*
    python -m pip install --upgrade twine
    twine upload dist/* 

ve_mmapuccino:
    python3 -m venv ve_mmapuccino
