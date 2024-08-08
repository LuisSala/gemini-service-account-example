# Setup

Be sure to have Python Poetry installed using the instructions at: https://python-poetry.org/docs/#installation

## Install packages and run sample
```bash
$ poetry install
$ poetry run python gemini-test.py
```

## Sample Output:
```bash
Model Responses:


WARNING: All log messages before absl::InitializeLog() is called are written to STDERR
I0000 00:00:1723155489.215791 1609984 check_gcp_environment_no_op.cc:29] ALTS: Platforms other than Linux and Windows are not supported
The capital of France is **Paris**. 

The capital of Iceland is **Reykjavik**. 
```