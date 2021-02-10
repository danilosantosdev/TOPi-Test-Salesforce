global class RepositoryControllerCalloutMock implements httpCalloutMock{

    global HTTPResponse respond(HTTPRequest req) {
        System.assertEquals('https://api.github.com/search/repositories?q=language:Apex&sort=stars&page=1', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());

        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('"items" : [{"id":"123", "name": "apex-test"}, {"id":"1234", "name": "apex-pattern"}]');
        res.setStatusCode(200);

        return res;
    }
}