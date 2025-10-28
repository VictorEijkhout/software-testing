#!/usr/bin/env python3

import argparse
import os
import subprocess
import sys
from pathlib import Path

from time import gmtime, strftime


# Check if we are even going to check things?
TRUES = [True, "true", "1", "t", "yes", "on"]

from ruamel.yaml import YAML

# Process command-line arguments
parser = argparse.ArgumentParser(
    description="Checks SIESTA test results against references"
)
parser.add_argument(
    "-a",
    "--abs-tol",
    type=float,
    default=1.0e-7,
    help="Absolute tolerance for comparisons (overrides configuration)",
)
parser.add_argument(
    "-c",
    "--config",
    default="test-cfg.yml",
    help="Config file containing the SIESTA test suite specifications",
)
parser.add_argument(
    "-o",
    "--output",
    default="tests-report.yml",
    help="File to store a YAML version of the report with full details",
)
parser.add_argument("-n", "--name", default="TESTNAME", help="Name of the test")
parser.add_argument(
    "-p",
    "--parser",
    default="out_digest_yaml.awk",
    help="AWK script that parses SIESTA output into yaml",
)
parser.add_argument(
    "-r",
    "--refdir",
    default="YAML_Refs",
    help="Directory containing reference YAML files",
)
parser.add_argument(
    "-t",
    "--testdir",
    default=".",
    help="Directory containing the test cases with their outputs",
)
parser.add_argument(
    "-y",
    "--yaml",
    default=os.path.join("work", "OUTVARS.yml"),
    help="Relative path where each test stores its YAML data",
)
args = parser.parse_args()

# Check command-line arguments
if not os.path.exists(args.config):
    parser.error("config file not found: '%s'" % args.config)
if not os.path.isfile(args.refdir):
    parser.error("reference file not found: '%s'" % args.refdir)
if not os.path.isfile(args.testdir):
    parser.error("tests file not found: '%s'" % args.testdir)

# Banner
# Compares a given test result to its reference. Both are standard Siesta
# output files that are pre-processed into yaml.

# Here is the meaning of each keyword:
# - ETOL: Some values are beyond permitted tolerances.
# - PASS: The test case meets all requirements.
# - SKIP: The test case has not been executed.
# - XTFL: The test failed as expected.

# A test is successful only if its result is "PASS".

# A report with full details of the tests is stored in the output file listed
# below in YAML format.

# Possible error return values for this script:
#   1 - AWK parser file not found
#   2 - Reference file not found.
#   3 - Test output file not found.
#  -1 - Verification failed due to Energy tolerances.


print(
    """\
SIESTA Test parameters
----------------------

The test comparison script has been run with the following parameters:

- Workdir       : %s
- Configuration : %s
- Reference file: %s
- Test file     : %s
- Output file   : %s

Results
-------
"""
    % (os.getcwd(), args.config, args.refdir, args.testdir, args.output)
)

# Load global configuration
yaml_doc = YAML()
yaml_cfg = {"tests": []}
with open(args.config, "r") as cfg_file:
    yaml_cfg = yaml_doc.load(cfg_file)

# Check that AWK parser exists.
parser_path = args.parser
if not os.path.exists(parser_path):
    print("Missing AWK parser file.")
    sys.exit(1)


# Perform test comparisons

# Check that test reference exists
if not os.path.exists(args.refdir):
    print("Missing reference file for %s", args.name)
    sys.exit(2)
else:
    cmd = ["awk", "-f", args.parser, args.refdir]
    subprocess.run(cmd, stdout=open("REF.yaml", "w"), stderr=sys.stderr)

# Load test reference
yaml_doc = YAML()
with open("REF.yaml", "r") as ref_file:
    yaml_ref = yaml_doc.load(ref_file)

# Check that test output exists
if not os.path.exists(args.testdir):
    print("Missing output file for %s", args.name)
    ref = Path("REF.yaml")
    ref.unlink(True)
    sys.exit(3)
else:
    cmd = ["awk", "-f", args.parser, args.testdir]
    subprocess.run(cmd, stdout=open("OUT.yaml", "w"), stderr=sys.stderr)

# Load test output
yaml_doc = YAML()
with open("OUT.yaml", "r") as out_file:
    yaml_out = yaml_doc.load(out_file)

# Compare energies
siesta_tests = {}
siesta_tests["tolerances"] = {}
ref_vars = yaml_ref["energies"]
out_vars = yaml_out["energies"]
tc_good = []
tc_fail = []
tc_skip = []

for yamlkey in [
    "energies",
    "forces",
    "kgrid",
    "geometry",
    "mulliken",
    "spin",
    "optical",
]:
    if not yamlkey in yaml_ref:
        continue

    ref_vars = yaml_ref[yamlkey]
    out_vars = yaml_out[yamlkey]
    for key, val in ref_vars.items():
        if key in yaml_cfg["tolerances"]:
            tc_tol = yaml_cfg["tolerances"][key]
        else:
            tc_tol = args.abs_tol
        siesta_tests["tolerances"][key] = tc_tol

        if not isinstance(val, list):
            if not (key in out_vars):
                continue

            if abs(out_vars[key] - val) < tc_tol:
                tc_good.append(key)
            else:
                tc_fail.append({"name": key, "value": out_vars[key], "expected": val})
        else:  # Things like stress and vectors.
            if not (key in out_vars):
                continue

            for ival in range(len(val)):
                keyname = key + str(ival)
                if abs(out_vars[key][ival] - val[ival]) < tc_tol:
                    tc_good.append(keyname)
                else:
                    tc_fail.append(
                        {
                            "name": keyname,
                            "value": out_vars[key][ival],
                            "expected": val[ival],
                        }
                    )
tc_skip = sorted([item for item in out_vars.keys() if not item in ref_vars.keys()])


# Store final test result
if len(tc_fail) == 0:
    siesta_tests["result"] = "pass"
    siesta_tests["message"] = "all values within tolerance"
else:
    siesta_tests["result"] = "etol"
    siesta_tests["message"] = "some values beyond tolerance"

# Write down full report
yaml_doc = YAML()
yaml_doc.default_flow_style = False
yaml_doc.indent(mapping=4, sequence=4, offset=2)
report = {"siesta_tests": siesta_tests, "defaults": {"tolerance": args.abs_tol}}
with open(args.output, "w") as rep_file:
    rep_file.write("%YAML 1.2\n---\n\n")
    yaml_doc.dump(report, rep_file)
    rep_file.write("\n...\n")

for file in ("REF.yaml", "OUT.yaml"):
    path = Path(file)
    path.unlink(True)

print("")
print("  - Good: ", tc_good)
print("  - Fail: ", tc_fail)
print("  - Skip: ", tc_skip)
print("")

# Display footer
print(
    """\
Test parser ran on %s (UTC).
"""
    % strftime("%Y/%m/%d %H:%M:%S +0000", gmtime())
)

if siesta_tests["result"] != "pass":
    sys.exit(-1)
