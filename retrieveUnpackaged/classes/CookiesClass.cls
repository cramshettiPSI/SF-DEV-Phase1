public class CookiesClass {
    public string inputCookie{
        get {
            Cookie cName = ApexPages.currentPage().getCookies().get('apex__final_cookie');
            system.debug('cName ********'+cName);
            if(cName == null) {
                return null;
            }
            return cName.getValue();
        }set{}
     }

    }