	//properties for check rules
	var targetVersion = '1,6,0,11';
	var unsupportJreVersionArr = new Array('1,6,0,14');
	var accessNewerVersion = true;

	//properties for debugging
	var skipCheckJRE = false;
	var isAlertDebugMsg = false;
	var version = '';

	var targetVersionArr = targetVersion.split(',');
	
	function isNeedInstall(version){
		try{
			//no jre installed
			if(version == null){
				if(isAlertDebugMsg){
					alert('no jre installed');
				}
				return true;
			}
			
			var versionArr = version.split(',');
			//unsupported version check
			
			for(var i = 0; i < unsupportJreVersionArr.length; i++){
				if(version == unsupportJreVersionArr[i]){
					if(isAlertDebugMsg){
						alert('is unsupported JRE version! [' + version + ']');
					}
					return true;
				}
			}
			
			// default accessNewerVersion is true 
			if(!accessNewerVersion){
				//check newer jre version			
				if( (versionArr[0] && parseInt(versionArr[0], 10) >= parseInt(targetVersionArr[0], 10)) 
						&& (versionArr[1] && parseInt(versionArr[1], 10) >= parseInt(targetVersionArr[1], 10))
						&& (versionArr[2] && parseInt(versionArr[2], 10) >= parseInt(targetVersionArr[2], 10))
				        && (versionArr[3] && parseInt(versionArr[3], 10) >  parseInt(targetVersionArr[3], 10)) ){
					if(isAlertDebugMsg){
						alert('is disaccecpt newer JRE version! [' + version + ']');
					}
					return true;
				}
			}

			//normal check - older JRE version			
			if( (versionArr[0] && parseInt(versionArr[0], 10) < parseInt(targetVersionArr[0], 10)) 
					|| (versionArr[1] && parseInt(versionArr[1], 10) < parseInt(targetVersionArr[1], 10))
			        || (versionArr[2] && parseInt(versionArr[2], 10) < parseInt(targetVersionArr[2], 10))
			        || (versionArr[3] && parseInt(versionArr[3], 10) < parseInt(targetVersionArr[3], 10)) ){

				if(isAlertDebugMsg){
					alert('is disaccecpt older JRE version! [' + version + ']');
				}
				return true;	
			}
		}
		catch(e){
			if(isAlertDebugMsg){
				alert(e.description);
			}
		} 
		return false;
	}

	//Handle PluginDetect exception
	try{
		version = PluginDetect.getVersion("Java");
	}
	catch(e){
		if(isAlertDebugMsg){
			alert(e.description);
		}
	}

	if(version == ''){
		skipCheckJRE = true;
		if(isAlertDebugMsg){
			alert('Retrieve JRE version occurs error! Skip to check JRE.');
		}
	}