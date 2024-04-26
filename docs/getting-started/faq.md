---
icon: octicons/comment-discussion-24
---

# Frequently Asked Questions

!!! note

    The section will be updated as questions are asked.

???+ question "Why can't I build a Windows Desktop Professional template using the default evaluation mode?"

    The project defaults all builds of Windows Server and Windows Desktop editions to use evaluations
    (or Insider Preview). Unfortunately, Windows Desktop Professional Edition does not support evaluation mode.
    The ISO provided by the Microsoft Evaluation Center only provides support for Enterprise Edition.

    For Windows Desktop Professional Edition, set:

    ```hcl linenums="11"  hl_lines="1 5"
    vm_inst_os_eval      = true
    vm_inst_os_language  = "en-US"
    vm_inst_os_keyboard  = "en-US"
    vm_inst_os_image_pro = "Windows 10 Pro"
    vm_inst_os_key_pro   = <YourProductKey>
    vm_inst_os_image_ent = "Windows 10 Enterprise"
    vm_inst_os_key_ent   = "XXXXX-XXXXX-XXXXX-XXXXX-XXXXX"
    ```
