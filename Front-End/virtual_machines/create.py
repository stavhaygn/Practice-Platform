# https://docs.opennebula.io/6.4/integration_and_development/system_interfaces/python.html
import time
import pyone

TEMPLATE_ID = 11

for i in range(1, 4):
    num = str(i).zfill(2)
    username = f"student{num}"
    password = f"password{num}"
    one = pyone.OneServer("http://192.168.234.92:2633/RPC2", session=f"{username}:{password}")
    _id = one.template.instantiate(TEMPLATE_ID, "")
    print("VM ID =", _id)
    time.sleep(60)