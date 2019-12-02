test_deps:
	pip install coverage flake8 wheel mypy

lint: test_deps
	./setup.py flake8
	if [[ $$(python --version 2>&1) > "Python 3.5" ]]; then mypy $$(python setup.py --name) --ignore-missing-imports; fi

test: test_deps lint
	coverage run --source=$$(python setup.py --name) ./test/test.py

init_docs:
	cd docs; sphinx-quickstart

docs:
	$(MAKE) -C docs html

install: clean
	pip install wheel
	python setup.py bdist_wheel
	pip install --upgrade dist/*.whl

clean:
	-rm -rf build dist
	-rm -rf *.egg-info

.PHONY: lint test test_deps docs install clean

include common.mk
