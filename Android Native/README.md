# INTEGRATION Webchat webview in Android Native:

● First, let's start a clean Kotlin/Java/Groovy project

● We have to create function named WebViewScreen

<img width="719" alt="MicrosoftTeams-image (18)" src="https://github.com/sestek/integration-webchat-plugin/assets/52357126/510831ea-2ebd-4cc1-8a96-aea036f1d276">

<img width="550" alt="MicrosoftTeams-image (15)" src="https://github.com/sestek/integration-webchat-plugin/assets/52357126/114abc0f-80a1-48d5-b3ca-7ae1910d3abb">


Here we allow few features like localstorage, js usage.

Required for capturing shutdown event and You can use this section to capture and customize events from webchat.


<img width="707" alt="MicrosoftTeams-image (16)" src="https://github.com/sestek/integration-webchat-plugin/assets/52357126/57ddb247-992a-4b69-a961-a264f558dfd2">


● We naturally call the composable WebViewScreen function we created


<img width="551" alt="MicrosoftTeams-image (19)" src="https://github.com/sestek/integration-webchat-plugin/assets/52357126/9324a989-8a23-4849-b8d4-3a886040424b">


● We need to grant some permissions in AndroidManifest.xml. Such as internet access etc.


<img width="596" alt="MicrosoftTeams-image (14)" src="https://github.com/sestek/integration-webchat-plugin/assets/52357126/d7e56495-03db-4134-a718-ac6ca892e9ae">


● Implement these packages in your build.gralde file


<img width="631" alt="MicrosoftTeams-image (13)" src="https://github.com/sestek/integration-webchat-plugin/assets/52357126/0567904a-522e-4709-bce0-608d28dd3782">


● Here we wanted to show the webview view with a buttonModalSheet. You can configure it as you wish.


<img width="730" alt="MicrosoftTeams-image (17)" src="https://github.com/sestek/integration-webchat-plugin/assets/52357126/e84fe9d8-beaf-477e-b69b-721302f2285b">


● After opening the webview and closing the chat, routing and using is entirely up to your skills. Develop with fun ✨ 🎉


<img width="325" alt="MicrosoftTeams-image (10)" src="https://github.com/sestek/integration-webchat-plugin/assets/52357126/33286826-3298-4895-ae5e-be751aa44abd">
<img width="325" alt="MicrosoftTeams-image (11)" src="https://github.com/sestek/integration-webchat-plugin/assets/52357126/0f3ba0ba-8004-4913-81f1-540e08179f5d">
<img width="325" alt="MicrosoftTeams-image (12)" src="https://github.com/sestek/integration-webchat-plugin/assets/52357126/df0557fa-d55e-4c16-b50e-3e3ffb00a863">


● It has been tested and developed with current android versions 🎯 .

