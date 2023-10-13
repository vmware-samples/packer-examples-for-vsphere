---
icon: octicons/shield-check-24
---

# Service Account Privileges

Create a custom vSphere role with the required privileges to integrate HashiCorp Packer with VMware vSphere. A service account can be added to the role to ensure that Packer has least privilege access to the infrastructure.

## Required Privileges

:fontawesome-regular-clone: &nbsp; Clone the default **Read-Only** vSphere role and add the following privileges:

::spantable::

| Category                       | Privilege                                           | Reference                                          |
| ------------------------------ | --------------------------------------------------- | -------------------------------------------------- |
| Content Library @span          | Add library item                                    | `ContentLibrary.AddLibraryItem`                    |
|                                | Update Library Item                                 | `ContentLibrary.UpdateLibraryItem`                 |
| Cryptographic Operations @span | Direct Access <br/> (Required for `packer_cache` upload.) | `Cryptographer.Access`                             |
|                                | Encrypt <br/> (Required for vTPM.)                        | `Cryptographer.Encrypt`                            |
| Datastore @span                | Allocate space                                      | `Datastore.AllocateSpace`                          |
|                                | Browse datastore                                    | `Datastore.Browse`                                 |
|                                | Low level file operations                           | `Datastore.FileManagement`                         |
| Host                           | Configuration > System Management                   | `Host.Config.SystemManagement`                     |
| Network                        | Assign network                                      | `Network.Assign`                                   |
| Resource                       | Assign virtual machine to resource pool             | `Resource.AssignVMToPool`                          |
| vApp                           | Export                                              | `vApp.Export`                                      |
| Virtual Machine @span          | Configuration > Add new disk                        | `VirtualMachine.Config.AddNewDisk`                 |
|                                | Configuration > Add or remove device                | `VirtualMachine.Config.AddRemoveDevice`            |
|                                | Configuration > Advanced configuration              | `VirtualMachine.Config.AdvancedConfig`             |
|                                | Configuration > Change CPU count                    | `VirtualMachine.Config.CPUCount`                   |
|                                | Configuration > Change memory                       | `VirtualMachine.Config.Memory`                     |
|                                | Configuration > Change settings                     | `VirtualMachine.Config.Settings`                   |
|                                | Configuration > Change Resource                     | `VirtualMachine.Config.Resource`                   |
|                                | Configuration > Modify device settings              | `VirtualMachine.Config.EditDevice`                 |
|                                | Configuration > Set annotation                      | `VirtualMachine.Config.Annotation`                 |
|                                | Edit Inventory > Create from existing               | `VirtualMachine.Inventory.CreateFromExisting`      |
|                                | Edit Inventory > Create new                         | `VirtualMachine.Inventory.Create`                  |
|                                | Edit Inventory > Remove                             | `VirtualMachine.Inventory.Delete`                  |
|                                | Interaction > Configure CD media                    | `VirtualMachine.Interact.SetCDMedia`               |
|                                | Interaction > Configure floppy media                | `VirtualMachine.Interact.SetFloppyMedia`           |
|                                | Interaction > Connect devices                       | `VirtualMachine.Interact.DeviceConnection`         |
|                                | Interaction > Inject USB HID scan codes             | `VirtualMachine.Interact.PutUsbScanCodes`          |
|                                | Interaction > Power off                             | `VirtualMachine.Interact.PowerOff`                 |
|                                | Interaction > Power on                              | `VirtualMachine.Interact.PowerOn`                  |
|                                | Provisioning > Create template from virtual machine | `VirtualMachine.Provisioning.CreateTemplateFromVM` |
|                                | Provisioning > Mark as template                     | `VirtualMachine.Provisioning.MarkAsTemplate`       |
|                                | Provisioning > Mark as virtual machine              | `VirtualMachine.Provisioning.MarkAsVM`             |
|                                | State > Create snapshot                             | `VirtualMachine.State.CreateSnapshot`              |
:
::end-spantable::

Once the custom vSphere role is created, assign **Global Permissions** in vSphere for the service account that will be used for the HashiCorp Packer to VMware vSphere integration in the next step. Global permissions are required for the content library.

For example:

1. Log in to the vCenter Server at _`https://<management_vcenter_server_fqdn>/ui`_ as `administrator@vsphere.local`.

1. Select **Menu** > **Administration**.

1. Create service account in vSphere SSO if it does not exist: In the left pane, select **Single Sign On** > **Users and Groups** and click on **Users**, from the dropdown select the domain in which you want to create the user (_e.g.,_`rainpole.io`) and click **ADD**, fill all the username (_e.g.,_ `svc-packer-vsphere)` and all required details, then click **ADD** to create the user.

1. In the left pane, select **Access control** > **Global permissions** and click the **Add permissions** icon.

1. In the **Add permissions** dialog box, enter the service account (_e.g.,_ `svc-packer-vsphere@rainpole.io`), select the custom role (_e.g.,_ Packer to vSphere Integration Role) and the **Propagate to children** checkbox, and click **OK**.

In an environment with many vCenter Server instances, such as management and workload domains, you may wish to further reduce the scope of access across the infrastructure in vSphere for the service account. For example, if you do not want Packer to have access to your management domain, but only allow access to workload domains:

1. From the **Hosts and clusters** inventory, select management domain vCenter Server to restrict scope, and click the **Permissions** tab.

1. Select the service account with the custom role assigned and click the **Edit**.

1. In the **Change role** dialog box, from the **Role** drop-down menu, select **No Access**, select the **Propagate to children** checkbox, and click **OK**.

### :material-terraform: Terraform Example

If you would like to automate the creation of the custom vSphere role, a Terraform example is included in the project.

1. Navigate to the directory for the example.

      ```shell
      cd terraform/vsphere-role
      ```

2. Duplicate the `terraform.tfvars.example` file to `terraform.tfvars` in the directory.

      ```shell
      cp terraform.tfvars.example terraform.tfvars
      ```

3. Open the `terraform.tfvars` file and update the variables according to your environment.

4. Initialize the current directory and the required Terraform provider for VMware vSphere.

      ```shell
      terraform init
      ```

5. Create a Terraform plan and save the output to a file.

      ```shell
      terraform plan -out=tfplan
      ```

6. Apply the Terraform plan.

      ```shell
      terraform apply tfplan
      ```
