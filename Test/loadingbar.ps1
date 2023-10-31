#----------------------------------------------INNERLOOP---------------------------------------------#
#Array of 100 numbers
$inner=@(1..100)

#----------------------------------------------OUTERLOOP----------------------------------------------#
#Array of 10 numbers
$outer=@(1..10) 

$counter=1
foreach($x in $outer){

    $innercounter=1
    foreach($y in $inner){
        #Progress bar for inner loop
        Write-Progress -Id 2 -Activity "Inner_loop" -Status "$(($innercounter/$inner.count)*100)% Complete" -PercentComplete (($innercounter/$inner.count)*100)
        $innercounter++
        Start-Sleep -Milliseconds 1 #Sleep for 1 second
    }
    #Progress bar for outer loop
    Write-Progress -Id 1 -Activity "Loop" -Status "$(($counter/$outer.count)*100)% Complete" -PercentComplete (($counter/$outer.count)*100) 
    $counter++
    Start-Sleep -Milliseconds 1 #Sleep for 1 second
}