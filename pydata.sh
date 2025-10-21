#!/usr/bin/env bash

# ~/pydata.sh
# Updated for modern Python 3 and ARM Mac compatibility

# Removed user's cached credentials
# This script might be run with .dots, which uses elevated privileges
sudo -K

echo "------------------------------"
echo "Setting up pip."

# Ensure Python 3 and pip are installed via Homebrew
if ! type brew &>/dev/null; then
  echo "Homebrew is required. Please run brew.sh first."
  exit 1
fi

# Install Python 3 if not already installed
brew list python@3.11 &>/dev/null || brew install python@3.11

# pip3 is included with Python 3 from Homebrew
echo "Using pip from Homebrew Python 3"

###############################################################################
# Virtual Enviroments                                                         #
###############################################################################

echo "------------------------------"
echo "Setting up virtual environments."

# Install virtual environments globally
# It fails to install virtualenv if PIP_REQUIRE_VIRTUALENV was true
export PIP_REQUIRE_VIRTUALENV=false
pip3 install --upgrade pip
pip3 install virtualenv
pip3 install virtualenvwrapper

echo "------------------------------"
echo "Source virtualenvwrapper from ~/.extra"

EXTRA_PATH=~/.extra
BREW_PREFIX=$(brew --prefix)
echo $EXTRA_PATH
echo "" >> $EXTRA_PATH
echo "" >> $EXTRA_PATH
echo "# Source virtualenvwrapper, added by pydata.sh" >> $EXTRA_PATH
echo "export WORKON_HOME=~/.virtualenvs" >> $EXTRA_PATH
echo "export VIRTUALENVWRAPPER_PYTHON=$BREW_PREFIX/bin/python3" >> $EXTRA_PATH
echo "source $BREW_PREFIX/bin/virtualenvwrapper.sh" >> $EXTRA_PATH
echo "" >> $EXTRA_PATH
source $EXTRA_PATH

###############################################################################
# Python 3 Data Science Virtual Environment                                   #
###############################################################################

echo "------------------------------"
echo "Setting up py3-data virtual environment."

# Detect Python 3 path from Homebrew
BREW_PREFIX=$(brew --prefix)
PYTHON3_PATH="$BREW_PREFIX/bin/python3"

# Create a Python3 data environment
mkvirtualenv --python=$PYTHON3_PATH py3-data
workon py3-data

# Install Python data science modules
echo "Installing data science packages..."
pip install --upgrade pip wheel setuptools

# Core scientific computing
pip install numpy
pip install scipy
pip install pandas
pip install sympy

# Visualization
pip install matplotlib
pip install seaborn
pip install plotly
pip install bokeh

# Machine Learning
pip install scikit-learn
pip install xgboost
pip install lightgbm

# Jupyter and IPython
pip install "ipython[all]"
pip install jupyter
pip install jupyterlab
pip install notebook

# Web frameworks
pip install Flask
pip install fastapi
pip install uvicorn

# Database
pip install sqlalchemy
pip install psycopg2-binary  # PostgreSQL
pip install mysqlclient      # MySQL

# Testing
pip install pytest
pip install pytest-cov

# Data processing
pip install requests
pip install beautifulsoup4
pip install lxml

###############################################################################
# Install Jupyter/IPython Profile
###############################################################################

echo "------------------------------"
echo "Installing Jupyter/IPython Default Profile"

# Add the IPython profile if it exists
if [ -d "init/profile_default/" ]; then
  mkdir -p ~/.ipython
  cp -r init/profile_default/ ~/.ipython/profile_default
  echo "IPython profile installed"
else
  echo "No IPython profile found in init/ directory, skipping..."
fi

echo "------------------------------"
echo "Script completed."
echo "Usage: workon py3-data for Python 3"
echo "To start Jupyter Lab: jupyter lab"
echo "To start Jupyter Notebook: jupyter notebook"