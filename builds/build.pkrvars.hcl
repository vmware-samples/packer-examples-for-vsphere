/*
    DESCRIPTION: 
    Build account variables used for all builds.
    - Variables are passed to and used by guest operationg system configuration files (e.g., ks.cfg, autounattend.xml).
    - Variables are passed to and used by configuration scripts.
*/

// Default Account Credentials
build_username           = "packer"
build_password           = "Sup3rC0mP!exP@s5"
build_password_encrypted = "$6$rounds=4096$HmEVOKNb8EqErgWa$8tSdXVxN/VVTQAk5NFQ4Ri7Jm4NrtXicaj/Fz1D.hE8Iqt5sgk.vdT6XxuWefMV4lVrHCmU8gRhvNIGiC5uDM/"
build_key                = "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBACL+/S7t6qKHiO4P+7yptfIJUExLPfcLRZE3z8IYb8CfCDBSKhlvTdtua68TT6leDf70H2vlyEMWVhF/EVS5WsDjQGnLa0qwqoQLgM7jrPvdlHxic3PRBx+O+TL/ubcn0a1tN2YjGBrSE6xSMiOf93fXy4QkninhN0+kjm45EBrDAzHKg== packer@geos.lab"