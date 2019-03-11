#Script for remote change ip
#RUN BY DOMAIN ADMIN!
#get old and new IPs from file ips.csv in folder with script


$ips = Import-Csv "$PSScriptRoot\ips.csv" -Delimiter ";" #read csv
foreach($ip_host in $ips)
{
$ipToChange = $ip_host.old_ip
Write-Host "Old ip remote computer is $ipToChange" -ForegroundColor Yellow #Out ip
#cache errors
if (!(Test-Connection $ipToChange -Quiet))
    {Write-Host "Remote computer $ipToChange is no ping, nothing to do =(" -ForegroundColor Red
    } else 
    {
    $newIp = $ip_host.new_ip
    Write-Host "New ip remote computer is $newIp" -ForegroundColor Yellow
    if ((Test-Connection $newIp -Quiet))
        { 
        Write-Host "New Ip for remote computer already ping! It`s will be conflict! Nothing to do" -ForegroundColor Red
        }else
        {
        #Get network adapter configuraton and change it
        Try
            {
            $NetworkAdapterConfiguration = Get-Wmiobject Win32_NetworkAdapterConfiguration -ComputerName $ipToChange -Filter "IPEnabled = $true" -ErrorAction Stop -ThrottleLimit 2 |
            Where-Object {$_.IPAddress -eq $ipToChange}
            $NetworkAdapterConfiguration.EnableStatic($newip,"255.255.0.0")
            }

        catch [system.exception]{}#if error - silent
        
        #Check changes
        Finally 
            {
            if (Test-Connection $newIp -Quiet)
                {
                Write-Host "New ip $newIp is ping, all ok! " -ForegroundColor Green
                }else
                {
                Write-Host "New ip $newIp is NOT ping, ERROR!" -ForegroundColor Red
          
                }
            }
        }
    }
}
