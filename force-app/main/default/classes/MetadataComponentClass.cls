/**
 * @File Name          : MetadataComponentClass.cls
 * @Description        : 
 * @Author             : Yasar Shaikh
 * @Group              : 
 * @Last Modified By   : Yasar Shaikh
 * @Last Modified On   : 23/3/2020, 7:18:15 pm
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    23/3/2020         Yasar Shaikh            Initial Version
**/
public class MetadataComponentClass {
	public String	metadataComponentName;
    public String	metadataComponentType;
    public String	metadataComponentId;
    public String   Id;
    public String	refMetadataComponentName;
    public String	refMetadataComponentType;
    public String	refMetadataComponentId;
    public Attributes attributes;
    
    public class Attributes {
		public String url;
        public String type;
    }
}