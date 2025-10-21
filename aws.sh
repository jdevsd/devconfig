#!/usr/bin/env bash

# ~/aws.sh
# Updated for modern Python 3, boto3, and ARM Mac compatibility

# Removed user's cached credentials
# This script might be run with .dots, which uses elevated privileges
sudo -K

echo "------------------------------"
echo "Setting up AWS tools."
echo "This script requires pip and virtualenvwrapper to be installed."
echo "See the pydata.sh script."

echo "------------------------------"
echo "Source virtualenvwrapper from ~/.extra"
source ~/.extra

###############################################################################
# Python 3 Virtual Environment with AWS Tools                                 #
###############################################################################

echo "------------------------------"
echo "Updating py3-data virtual environment with AWS modules."

# Detect Python 3 path from Homebrew
BREW_PREFIX=$(brew --prefix)
PYTHON3_PATH="$BREW_PREFIX/bin/python3"

# Create a Python3 data environment if it doesn't exist
# If this environment already exists from running pydata.sh,
# it will not be overwritten
mkvirtualenv --python=$PYTHON3_PATH py3-data 2>/dev/null || true
workon py3-data

# Install modern AWS tools
pip install --upgrade pip
pip install boto3  # Modern AWS SDK (replaces boto)
pip install awscli
pip install aws-sam-cli  # AWS Serverless Application Model
pip install s3cmd

# Configure AWS CLI autocomplete
EXTRA_PATH=~/.extra
echo $EXTRA_PATH
if ! grep -q "aws_completer" $EXTRA_PATH 2>/dev/null; then
  echo "" >> $EXTRA_PATH
  echo "# Configure AWS CLI autocomplete, added by aws.sh" >> $EXTRA_PATH
  echo "complete -C '$BREW_PREFIX/bin/aws_completer' aws" >> $EXTRA_PATH
  source $EXTRA_PATH
fi

###############################################################################
# System-Wide Packages                                                        #
###############################################################################

echo "------------------------------"
echo "Installing Apache Spark (optional - commented out by default)"

# Uncomment to install Apache Spark
# Note: Spark is quite large and may not be needed for all AWS workflows
# brew install apache-spark

###############################################################################
# Install Jupyter Notebook Spark Integration (Optional)
###############################################################################

# Uncomment to install Jupyter Spark integration
# echo "------------------------------"
# echo "Installing Jupyter Notebook Spark integration"
#
# # Add the pyspark Jupyter profile if it exists
# if [ -d "init/profile_pyspark/" ]; then
#   mkdir -p ~/.ipython
#   cp -r init/profile_pyspark/ ~/.ipython/profile_pyspark
#   echo "PySpark IPython profile installed"
# fi
#
# BREW_PREFIX=$(brew --prefix)
# SPARK_VERSION=$(brew list --versions apache-spark | awk '{print $2}')
# BASH_PROFILE_PATH=~/.bash_profile
#
# if ! grep -q "SPARK_HOME" $BASH_PROFILE_PATH; then
#   echo "" >> $BASH_PROFILE_PATH
#   echo "# Jupyter Notebook Spark integration, added by aws.sh" >> $BASH_PROFILE_PATH
#   echo "export SPARK_HOME='$BREW_PREFIX/Cellar/apache-spark/$SPARK_VERSION/libexec'" >> $BASH_PROFILE_PATH
#   echo "export PYSPARK_PYTHON=python3" >> $BASH_PROFILE_PATH
#   echo "export PYSPARK_DRIVER_PYTHON=jupyter" >> $BASH_PROFILE_PATH
#   echo "export PYSPARK_DRIVER_PYTHON_OPTS='notebook'" >> $BASH_PROFILE_PATH
#   echo "" >> $BASH_PROFILE_PATH
#   source $BASH_PROFILE_PATH
# fi

echo "------------------------------"
echo "Script completed."
echo "Next steps:"
echo "1. Configure AWS CLI: Run 'aws configure' to set up your credentials and region"
echo "2. Update .aws/config and .aws/credentials with your AWS settings"
echo "3. For S3: Run 's3cmd --configure' to set up S3 access"
echo ""
echo "AWS tools installed:"
echo "- boto3 (modern AWS SDK for Python)"
echo "- awscli (AWS command line interface)"
echo "- aws-sam-cli (AWS Serverless Application Model)"
echo "- s3cmd (S3 command line tool)"