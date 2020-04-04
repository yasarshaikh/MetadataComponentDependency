# MetadataComponentDependency

<a href="https://githubsfdeploy.herokuapp.com?owner=yasarshaikh&repo=MetadataComponentDependency">
  <img alt="Deploy to Salesforce"
       src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/src/main/webapp/resources/img/deploy.png">
</a>


> Caveat : This entire dependency functionality relies on [MetadataComponentDepenency](https://developer.salesforce.com/docs/atlas.en-us.api_tooling.meta/api_tooling/tooling_api_objects_metadatacomponentdependency.htm) object, which is still in Beta as of v48.0

<br />
Steps to use:
==============
1. Add remote site setting with your VF page's domain
2. Go to `MetadataComponentDependencyRenderer` page
3. Preview it.
<br />
<br />
<br />

Special Thanks:
===============
1. Ajinkya Shedage  - For UI related help
2. [Vis](https://visjs.github.io/vis-network/docs/network/) - For beautiful graph library 
3. [Andrew Fawcett](https://www.linkedin.com/in/andyfawcett)   - For [Deploy to salesforce button](https://andyinthecloud.com/category/githubsfdeploy)
<br />
<br />
<br />

Technical details:
==================
We have used [MetadataComponentDepenency](https://developer.salesforce.com/docs/atlas.en-us.api_tooling.meta/api_tooling/tooling_api_objects_metadatacomponentdependency.htm) from tooling api [Salesforce](https://www.salesforce.com/). 
This will fetch all the dependent component. This will be visualized by Vis library by means of Visaulforce page with JS Remoting. 
<br />
<br />
<br />

Future Aspects:
===============
1. Need to have configuration for the graph(e.g. shape of Node, color of node depending on type of Node)
2. Need to implement asynchronous flow to fetch all types one by one(instead in single go). This will help to make it progressive. 
3. Checkboxes on the top to make sure only those types should be considered for dependency checks. 
4. Need to make Ux more intutive by means of more readable buttons, alerts/toasts, progress bar etc.
5. Responsive to the device scale
6. And many more...
