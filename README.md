# Ubuntu_Shell_Script
Develop shell together

# NOTE : ![#f03c15](https://placehold.it/15/f03c15/000000?text=+) Very Important
## Need to do follow things first (Require Internet Connection)

1. Run requirements setup script "setup.py",
```sh
    $ sudo python3 setup.py
```

2. Install requirements manually:
```sh
    $ sudo apt-get install -y p7zip-full python3-pip python3-requests python3-pytest
    $ sudo pip3 install requests
    $ sudo pip3 install -U pytest
    $ sudo pip3 install pytest-html
```

3. If pip can not be use then execute below command:
```sh
    $ sudo apt-get install -y python3-requests python3-pytest
```

4. Modify "test_config.ini" before run pytest scripts,
    contans require test configuration.
```sh
    # change package V005200 to V005400 by one line command.
    $ sed -i 's,/home/allen/Desktop/release/AS60G1_BMC_V005200.zip,/home/allen/Desktop/release/AS60G1_BMC_V005400.zip,g' test_config.ini
```

5. How to run pytest:
```sh
    # with file
    $ py.test-3.4 test_1_CheckImageFile.py -s --html=report.html
    # current path
    $ py.test-3.4 -s --html=report.html
    # output log
    $ py.test-3.4 test_2_BmcImageFlash.py -s --html=report.html 2>&1 | tee output_report.log
```
