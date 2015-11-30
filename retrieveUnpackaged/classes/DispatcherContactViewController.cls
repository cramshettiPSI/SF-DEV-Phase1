public class DispatcherContactViewController {

    public DispatcherContactViewController(ApexPages.StandardController controller) {
        this.controller = controller;
    }

    public PageReference getRedir() {

        Contact c = [Select id, recordtypeid From Contact Where Id = :ApexPages.currentPage().getParameters().get('id')];

        PageReference newPage;

        if (c.recordtypeid == 'Expert Reviewers') {
            newPage = Page.Contact_View_1;
        } else {
            newPage = new PageReference('/' + c.id);
            newPage.getParameters().put('nooverride', '1');
        }

        newPage.getParameters().put('id', c.id);
        return newPage.setRedirect(true);

    }

    private final ApexPages.StandardController controller;

}