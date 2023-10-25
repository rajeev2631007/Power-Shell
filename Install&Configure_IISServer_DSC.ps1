configuration IISConfig {
    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Node localhost {
        WindowsFeature IIS {
            Ensure = "Present"
            Name   = "Web-Server"
        }

        xWebsite MyWebsite {
            Ensure          = "Present"
            Name            = "MyWebsite"
            State           = "Started"
            PhysicalPath    = "C:\MyWebsite"
            BindingInfo     = @(MSFT_xWebBindingInformation {
                Protocol   = "HTTP"
                Port       = 80
            })
        }
    }
}

IISConfig -OutputPath C:\DSCConfig
Start-DscConfiguration -Path C:\DSCConfig -Wait -Force
