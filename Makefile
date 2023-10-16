# Create a virtual environment
vir_create:
	python3 -m venv $(VENV_DIR)

# Activate the virtual environment
vir_activate:
	@echo "Activating virtual environment..."
	@source $(VENV_DIR)/bin/activate && \
		echo "Virtual environment activated."

# Deactivate the virtual environment
vir_deactivate:
	@echo "Deactivating virtual environment..."
	@deactivate


install:
	pip install --upgrade pip &&\
		pip install -r requirements.txt 
format:
	#makesure the correct format of code
	black src/*.py

lint:
	#check program syntatically correct using flame or pylint, disabling R,C (recomended & configuration warnig)avoid warnig and avoid ci fail
	pylint --disable=R,C *.py src/*.py *.py

test:
	#test program cov flag says how much test coverage inside
	python -m pytest -vv --cov=src --cov=main test_*.py

build:
	#docker build
	docker build -t devops-practice .
