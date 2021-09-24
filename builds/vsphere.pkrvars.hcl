/*
    DESCRIPTION: 
    VMaware vSphere variables used for all builds.
    - Variables are use by the source blocks.
*/

// vSphere Credentials
vsphere_endpoint            = "r2c1-vcsa.vcf.vxrail.local"
vsphere_username            = "administrator@vsphere.local"
vsphere_password            = "Vx5eals!!"
vsphere_insecure_connection = true

// vSphere Settings
vsphere_datacenter = "vxrail-datacenter"
vsphere_cluster    = "vxrail-main-cluster"
vsphere_datastore  = "vxrail-vsan-ds"
vsphere_network    = "workload-net"
vsphere_folder     = "Templates"