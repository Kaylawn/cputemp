param([Int32]$seconds=15)
cls
write-host("`n`n`n`n`n`n`n")
While($True)
{
	$t = Get-WmiObject MSAcpi_ThermalZoneTemperature -Namespace "root/wmi"
	$hotest_core = ($t.CurrentTemperature | Measure-Object -Maximum).Maximum

	$currentTempKelvin = $hotest_core / 10
	$currentTempCelsius = $currentTempKelvin - 273.15
	$currentTempFahrenheit = (9/5) * $currentTempCelsius + 32

    	write-host("Hotest CPU Core`n" + $currentTempCelsius.ToString("#.##") + "C : " + $currentTempFahrenheit.ToString("#.##") + "F : " + $currentTempKelvin.ToString("#.##") + "K")

 	write-host("`nAll Cores")
	foreach ($temp in $t.CurrentTemperature)
	{
		$currentTempKelvin = $temp / 10
		$currentTempCelsius = $currentTempKelvin - 273.15
		$currentTempFahrenheit = (9/5) * $currentTempCelsius + 32

    		write-host($currentTempCelsius.ToString("#.##") + "C : " + $currentTempFahrenheit.ToString("#.##") + "F : " + $currentTempKelvin.ToString("#.##") + "K")
	}

	for ($i = 1; $i -le $seconds; $i++)
	{
		$P = [int]($i*(100/$seconds))
		Write-Progress -Activity "Next update in $seconds seconds" -Status "$P%" -PercentComplete ($i*(100/$seconds))
		Start-Sleep -seconds 1
	}

	cls
	write-host("`n`n`n`n`n`n`n")

}
