/**
 * @File Name          : FetchMetadataComponentDependency.cls
 * @Description        : 
 * @Author             : Yasar Shaikh
 * @Group              :  
 * @Last Modified By   : Yasar Shaikh
 * @Last Modified On   : 4/4/2020, 12:25:43 am
 * @Modification Log   :  
 * Ver       Date            Author      		    Modification
 * 1.0      23/3/2020         Yasar Shaikh            Initial Version
**/
public class FetchMetadataComponentDependency 
{
    public FetchMetadataComponentDependency(){
        System.debug('Constructor');
    }
    

    //can be called parallely to have faster data processing.  //by using aura/remoteactions etc.
    @RemoteAction
    public static String fetchMetadata(String typeName)
    {
        HttpRequest req = new HttpRequest();        
        req.setHeader('Authorization'   , 'Bearer ' + UserInfo.getSessionID()); //Get user Session ID	
        req.setHeader('Content-Type'    , 'application/json');
        String domainUrl = URL.getSalesforceBaseUrl().toExternalForm();
        
        String path     = '/services/data/v48.0/tooling/query?q=';
        List<String> listOfFieldsToRetrieve = new List<String>();
        listOfFieldsToRetrieve.add( 'Id'                        );
        listOfFieldsToRetrieve.add( 'metadataComponentId'       );
        listOfFieldsToRetrieve.add( 'metadataComponentName'     );
        listOfFieldsToRetrieve.add( 'metadataComponentType'     );
        listOfFieldsToRetrieve.add( 'refMetadataComponentId'    );
        listOfFieldsToRetrieve.add( 'refmetadataComponentName'  );
        listOfFieldsToRetrieve.add( 'refmetadataComponentType'  );

        String query;
        if(String.isNotBlank(typeName))
        {
            query = 'SELECT+'+ String.join(listOfFieldsToRetrieve, ',') +'+From+MetadataComponentDependency+Where+MetadataComponentType=\'' + typeName +'\'';
        }
        else{
         	query = 'SELECT+'+ String.join(listOfFieldsToRetrieve, ',') +'+From+MetadataComponentDependency';   
        }
        String endpoint	=	domainURL + path + query;
        System.debug('Endpoint ::: ' + endpoint);
        req.setEndpoint(endpoint);
        req.setMethod('GET');

        Http h                          =   new Http();
		HttpResponse response 	        =   h.send(req);
		String responseBody 	        =   response.getBody();
        Map<String, Object> statusJson 	=   (Map<String, Object>) JSON.deserializeUntyped(responseBody);        
        String recordsJson	            =  JSON.serialize( statusJSON.get('records') ) ;

        List<MetadataComponentClass> metaRecords                     = (List<MetadataComponentClass>)JSON.deserializeStrict(recordsJson, List<MetadataComponentClass>.class);                
        Map<String, List<MetadataComponentClass>> parentToDependents =   new Map<String, List<MetadataComponentClass>>();

        for(MetadataComponentClass meta : metaRecords)
        {
            String metaName = meta.MetadataComponentName;

            if(parentToDependents.containsKey( metaName ) )
            {
                List<MetadataComponentClass> temp = parentToDependents.get( metaName );
                temp.add(meta);
                parentToDependents.put( metaName, temp);
            }
            else
            {
                List<MetadataComponentClass> temp = new List<MetadataComponentClass>();
                temp.add( meta );
                parentToDependents.put( metaName, temp);
            }
        }

        for(String key : parentToDependents.keySet() ){
            System.debug( key + ' has ' + parentToDependents.get(key).size()  + ' dependencies');
        }
        
        //System.debug( JSON.serialize( parentToDependents  )  )  ;
        return JSON.serialize( parentToDependents );
    }
}