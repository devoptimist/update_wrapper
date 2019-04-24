# update_wrapper

####  Azure Setup for Test Kitchen:
In the `.kitchen.yml` file alter the driver section to your needs

```

driver:
  name: azurerm
  subscription_id: "<your subscription id>"
  location: 'North Europe'
  machine_size: 'Standard_D1'
```

then create an azure credentials file in your home directory:
`.~/azure/credentials`

```
[your subscription id]
client_id = "<client-id>"
client_secret = "<client-secret>"
tenant_id = "<tenant-id>"
```

#

### Running the upgrade

First run kitchen converge to create a centos and windows image in Azure
`kitchen converge`
Once the system is converged you will have two servers running chef 13.0.118
Now edit the policyfile.rb and chenge the runlist from:
```
# run_list: chef-client will run these recipes in the order specified.
run_list 'update_wrapper::default'
```
to

```
# run_list: chef-client will run these recipes in the order specified.
run_list 'update_wrapper::update'
```
`vim Policyfile.rb`

then remove the Policyfile.lock.json to enable a new one to be generated

`rm -rf Policyfile.lock.json`
Now we can converge again to see the updater cookbook run and update chef client 13.0.118 to chef client 14.11.21

`kitchen converge`

example log output
```
       Recipe: update_wrapper::update
         * chef_client_updater[Install 14.11.21] action update
           * chef_gem[mixlib-install] action install
             - install version ~> 3.11 of package mixlib-install
           * remote_file[C:\Users\azure\AppData\Local\Temp\kitchen\cache/handle.zip] action createSUCCESS: The scheduled task "Chef_upgrade" has successfully been created.
       
             - create new file C:\Users\azure\AppData\Local\Temp\kitchen\cache/handle.zip
             - update content in file C:\Users\azure\AppData\Local\Temp\kitchen\cache/handle.zip from none to 9a1c33
             (new content is binary, diff output suppressed)
           * powershell_script[name] action run
             - execute "C:\windows\system32\WindowsPowerShell\v1.0\powershell.exe" -NoLogo -NonInteractive -NoProfile -ExecutionPolicy Bypass -InputFormat None -File "C:/Users/azure/AppData/Local/Temp/chef-script20190424-4336-wjmxht.ps1"
           - upgrade chef-client 13.0.118 to 14.11.21[2019-04-24T09:04:06+00:00] WARN: New chef-client installed and exit is allowed. Forcing chef e
