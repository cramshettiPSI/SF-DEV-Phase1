public class DispatcherContactEditController {

    public DispatcherContactEditController(ApexPages.StandardController controller) {
        this.controller = controller;
    }

    public PageReference getRedir() {

        Contact c = [Select id, recordtypeid From Contact Where Id = :ApexPages.currentPage().getParameters().get('id')];

        PageReference newPage;

        if (c.recordtypeid == '012r00000004IA3') {
            newPage = Page.Contact_Edit_1;

        } else {
            newPage = new PageReference('/' + c.id + '/e');
            newPage.getParameters().put('nooverride', '1');
        }

        newPage.getParameters().put('id', c.id);

        return newPage.setRedirect(true);
    }

    private final ApexPages.StandardController controller;
}