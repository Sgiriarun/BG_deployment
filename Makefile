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

build-blue:
	@echo "Building blue-app Docker image..."
	@docker build -t blue-app --build-arg APP_ENV=Blue -f Dockerfile .

build-green:
	@echo "Building green-app Docker image..."
	@docker build -t green-app --build-arg APP_ENV=Green -f Dockerfile .


create-vpc-stack:
	aws cloudformation create-stack --template-body file://$PWD/infra/vpc.yml --stack-name vpc

create-iam-stack:
	aws cloudformation create-stack --template-body file://$PWD/infra/iam.yml --stack-name iam --capabilities CAPABILITY_IAM

create-cluster-stack:
	aws cloudformation create-stack --template-body file://$PWD/infra/cluster.yml --stack-name app-cluster

create-endpoint-stack:
	# Before running this command, make sure to edit api.yml to update the Image tag/URL as needed.
	aws cloudformation create-stack --template-body file://$PWD/infra/bg_endpoint.yml --stack-name api
