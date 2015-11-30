public with sharing class TestController {

    public List<String> lstSections { get; set; }
    public TestController(ApexPages.StandardController controller) {
         lstSections = new List<String>();
    }

    public PageReference addSection() {
       
        return null;
    }

}