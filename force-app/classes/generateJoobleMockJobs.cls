/**
 * Created by islam on 4/9/2024.
 */

public with sharing class generateJoobleMockJobs implements HttpCalloutMock {
    public HttpResponse respond(HttpRequest request) {
        HttpResponse httpResponse = new HttpResponse();
        httpResponse.setHeader('Content-Type', 'application/json');
        httpResponse.setBody('{\n' +
                '    "totalCount": 998,\n' +
                '    "jobs": [\n' +
                '        {\n' +
                '            "title": "Salesforce Product Owner",\n' +
                '            "location": "Dayton, OH",\n' +
                '            "snippet": "&nbsp;...<b>Salesforce </b>Product Owner \\r\\n CoverMyMeds, part of McKesson Corporation, is a fast-growing healthcare technology company recognized as a “Best Place to Work” by Glassdoor and a “Best Company to Work For” by FORTUNE. Through innovation and collaboration, CoverMyMeds’ solutions...&nbsp;",\n' +
                '            "salary": "$90k - $130k",\n' +
                '            "source": "sonicjobs.com",\n' +
                '            "type": "Full-time",\n' +
                '            "link": "https://jooble.org/desc/-2849789841963915506?ckey=Salesforce&rgn=0&pos=1&groupId=36958&elckey=2730508911600716119&p=1&aq=-6399998284419032153&cid=3376&jobAge=18&relb=128&brelb=115&bscr=4735.993&scr=5271.366121739131",\n' +
                '            "company": "MCKESSON",\n' +
                '            "updated": "2024-04-08T01:14:55.4897136+00:00",\n' +
                '            "id": -2849789841963915506\n' +
                '        },\n' +
                '        {\n' +
                '            "title": "Salesforce Solution Architect",\n' +
                '            "location": "Saint Petersburg, FL",\n' +
                '            "snippet": "&nbsp;...difference as we develop scalable solutions to support our global growth, we want to hear from you!\\r\\n \\r\\n The Opportunity: \\r\\n \\r\\n As the <b>Salesforce </b>Solution Architect, you will plan the architecture and solution design of a collection of systems in a large technology ecosystem...&nbsp;",\n' +
                '            "salary": "$62.5 - $83.33 per hour",\n' +
                '            "source": "sonicjobs.com",\n' +
                '            "type": "Full-time",\n' +
                '            "link": "https://jooble.org/desc/8115803784812062853?ckey=Salesforce&rgn=0&pos=2&groupId=36958&elckey=2730508911600716119&p=1&aq=-6399998284419032153&cid=3376&jobAge=186&relb=125&brelb=115&bscr=4667.9717&scr=5073.882282608696",\n' +
                '            "company": "Fisher Investments",\n' +
                '            "updated": "2024-04-01T00:00:00.0000000",\n' +
                '            "id": 8115803784812062853\n' +
                '        },\n' +
                '        {\n' +
                '            "title": "Sr Manager, Salesforce Administration",\n' +
                '            "location": "Middletown, OH",\n' +
                '            "snippet": "&nbsp;...Manager, <b>Salesforce </b>Administration \\r\\n\\r\\n CoverMyMeds, part of McKesson Corporation, is a fast-growing healthcare technology company recognized as a “Best Place to Work” by Glassdoor and a “Best Company to Work For” by FORTUNE. Through innovation and collaboration, CoverMyMeds...&nbsp;",\n' +
                '            "salary": "$110k - $140k",\n' +
                '            "source": "sonicjobs.com",\n' +
                '            "type": "Full-time",\n' +
                '            "link": "https://jooble.org/desc/-2614374294284814892?ckey=Salesforce&rgn=0&pos=3&groupId=36958&elckey=2730508911600716119&p=1&aq=-6399998284419032153&cid=3376&jobAge=18&relb=128&brelb=115&bscr=4445.479&scr=4948.011408695653",\n' +
                '            "company": "MCKESSON",\n' +
                '            "updated": "2024-04-08T01:14:53.0231863+00:00",\n' +
                '            "id": -2614374294284814892\n' +
                '        },\n' +
                '        {\n' +
                '            "title": "Salesforce Developer",\n' +
                '            "location": "Plano, TX",\n' +
                '            "snippet": "Kforce has a client in Plano, TX that is seeking a highly motivated <b>Salesforce </b>Developer join our growing team. You will play a key role in developing and implementing innovative solutions using Salesforce Einstein to streamline our customer support operations.\\n\\nResponsibilities...&nbsp;",\n' +
                '            "salary": "$45 - $55 per hour",\n' +
                '            "source": "kforce.com",\n' +
                '            "type": "Temporary",\n' +
                '            "link": "https://jooble.org/desc/6970915713835289246?ckey=Salesforce&rgn=0&pos=4&groupId=36958&elckey=2730508911600716119&p=1&aq=-6399998284419032153&cid=3376&jobAge=90&relb=110&brelb=110&bscr=4730.338&scr=4730.338",\n' +
                '            "updated": "2024-04-05T00:00:00.0000000",\n' +
                '            "id": 6970915713835289246\n' +
                '        },\n' +
                '        {\n' +
                '            "title": "Salesforce Developer",\n' +
                '            "location": "Palm Beach Gardens, FL",\n' +
                '            "snippet": "Kforce has a client that is seeking a <b>Salesforce </b>Developer in Palm Beach Gardens, FL.\\n\\nResponsibilities:\\n* Develop end to end Salesforce solutions\\n* Salesforce Developer will collaborate with IT/Developers for other systems to integrate across the business\\n* Automate business...&nbsp;",\n' +
                '            "salary": "$45 - $55 per hour",\n' +
                '            "source": "kforce.com",\n' +
                '            "type": "Temporary",\n' +
                '            "link": "https://jooble.org/desc/8661846937073878400?ckey=Salesforce&rgn=0&pos=5&groupId=36958&elckey=2730508911600716119&p=1&aq=-6399998284419032153&cid=3376&jobAge=114&relb=110&brelb=110&bscr=4708.0312&scr=4708.0312",\n' +
                '            "updated": "2024-04-04T00:00:00.0000000",\n' +
                '            "id": 8661846937073878400\n' +
                '        },\n' +
                '        {\n' +
                '            "title": "Salesforce Developer",\n' +
                '            "location": "Columbus, OH",\n' +
                '            "snippet": "Kforce\'s client, one of the world\'s largest financial institutions is seeking to hire a team of 8 <b>Salesforce </b>Developers in Columbus, OH, Chicago (IL), and Plano (TX).\\r\\n* Bachelor\'s degree in Electronic Engineering, Computer Engineering, Software Engineering, Management...&nbsp;",\n' +
                '            "salary": "$60 - $72 per hour",\n' +
                '            "source": "kforce.com",\n' +
                '            "type": "Temporary",\n' +
                '            "link": "https://jooble.org/desc/-373318140203390342?ckey=Salesforce&rgn=0&pos=6&groupId=36958&elckey=2730508911600716119&p=1&aq=-6399998284419032153&cid=3376&jobAge=282&relb=110&brelb=110&bscr=4624.477&scr=4624.477",\n' +
                '            "updated": "2024-03-28T00:00:00.0000000",\n' +
                '            "id": -373318140203390342\n' +
                '        },\n' +
                '        {\n' +
                '            "title": "Salesforce Administrator",\n' +
                '            "location": "Milwaukee, WI",\n' +
                '            "snippet": "&nbsp;...Problem Solved. \\r\\n That\'s the FACE Culture that we live and breathe here at MRA. \\r\\n MRA The Management Association is seeking a  <b>Salesforce </b>Administrator  who will be responsible for supporting the multiple business lines of MRA and the ongoing development of our Salesforce...&nbsp;",\n' +
                '            "salary": "$62.18k - $90k",\n' +
                '            "source": "applicantpro.com",\n' +
                '            "type": "Full-time",\n' +
                '            "link": "https://jooble.org/desc/-3215541234958305887?ckey=Salesforce&rgn=0&pos=7&groupId=36958&elckey=2730508911600716119&p=1&aq=-6399998284419032153&cid=3376&jobAge=560&relb=110&brelb=110&bscr=4422.9814&scr=4422.9814",\n' +
                '            "company": "MRA - The Management Association, Inc",\n' +
                '            "updated": "2024-03-16T09:25:54.1459883+00:00",\n' +
                '            "id": -3215541234958305887\n' +
                '        },\n' +
                '        {\n' +
                '            "title": "Salesforce Engineering Manager",\n' +
                '            "location": "Boca Raton, FL",\n' +
                '            "snippet": "Kforce has a client in Boca Raton, FL that is seeking a <b>Salesforce </b>Engineering Manager who is passionate about delivering great solutions and enthusiastic about the Salesforce platform.\\n\\nSummary:\\nAs a Salesforce Engineering Manager, you will be leading one or more teams...&nbsp;",\n' +
                '            "salary": "$120k - $130k",\n' +
                '            "source": "kforce.com",\n' +
                '            "type": "Full-time",\n' +
                '            "link": "https://jooble.org/desc/-5962013214110574466?ckey=Salesforce&rgn=0&pos=8&groupId=36958&elckey=2730508911600716119&p=1&aq=-6399998284419032153&cid=3376&jobAge=354&relb=110&brelb=110&bscr=4336.458&scr=4336.458",\n' +
                '            "updated": "2024-03-25T00:00:00.0000000",\n' +
                '            "id": -5962013214110574466\n' +
                '        },\n' +
                '        {\n' +
                '            "title": "Salesforce Lead Developer",\n' +
                '            "location": "West Palm Beach, FL",\n' +
                '            "snippet": "Kforce has a client that is seeking a <b>Salesforce </b>Lead Developer in West Palm Beach, FL.\\n\\nSummary:\\nWe are seeking a highly motivated and experienced Salesforce Lead Developer to spearhead custom Salesforce applications and integrations with legacy applications. In this...&nbsp;",\n' +
                '            "salary": "$75 - $85 per hour",\n' +
                '            "source": "kforce.com",\n' +
                '            "type": "Temporary",\n' +
                '            "link": "https://jooble.org/desc/8695297635955295460?ckey=Salesforce&rgn=0&pos=9&groupId=36958&elckey=2730508911600716119&p=1&aq=-6399998284419032153&cid=3376&jobAge=354&relb=110&brelb=110&bscr=4331.731&scr=4331.731",\n' +
                '            "updated": "2024-03-25T00:00:00.0000000",\n' +
                '            "id": 8695297635955295460\n' +
                '        },\n' +
                '        {\n' +
                '            "title": "IT Sr. Business Analyst (Salesforce) *main",\n' +
                '            "location": "New York, NY",\n' +
                '            "snippet": "&nbsp;...business case for the use of that technology. \\r\\n~ Experience in an agile software development methodology. \\r\\n~ Familiarity with <b>Salesforce </b>or related enterprise CRM tools. \\r\\n~ Ability to juggle various work activities and shift their attention from one task to another...&nbsp;",\n' +
                '            "salary": "$85k - $150k",\n' +
                '            "source": "appcast.apply.com",\n' +
                '            "type": "Full-time",\n' +
                '            "link": "https://jooble.org/desc/-5924728149194741647?ckey=Salesforce&rgn=0&pos=10&groupId=36958&elckey=2730508911600716119&p=1&aq=-6399998284419032153&cid=3376&jobAge=90&relb=128&brelb=115&bscr=3890.4468&scr=4330.236438260869",\n' +
                '            "company": "Leaf Home",\n' +
                '            "updated": "2024-04-05T00:00:00.0000000",\n' +
                '            "id": -5924728149194741647\n' +
                '        },\n' +
                '        {\n' +
                '            "title": "Salesforce Administrator",\n' +
                '            "location": "Chicago, IL",\n' +
                '            "snippet": "&nbsp;...client for filling key positions in their software development and solutions team. We are currently hiring for the position of  <b>Salesforce </b>Administrator  . Applicants are expected to have worked in regulated industries with stringent compliance.  Specific Requirements...&nbsp;",\n' +
                '            "salary": "$80 - $85 per hour",\n' +
                '            "source": "cvviz.com",\n' +
                '            "type": "Temporary",\n' +
                '            "link": "https://jooble.org/desc/-6564376142104771108?ckey=Salesforce&rgn=0&pos=11&groupId=36958&elckey=2730508911600716119&p=1&aq=-6399998284419032153&cid=3376&jobAge=72&relb=100&brelb=100&bscr=4292.0986&scr=4292.0986",\n' +
                '            "company": "Force Smiths",\n' +
                '            "updated": "2024-04-05T17:39:03.0519927+00:00",\n' +
                '            "id": -6564376142104771108\n' +
                '        },\n' +
                '        {\n' +
                '            "title": "Salesforce Architect",\n' +
                '            "location": "Chicago, IL",\n' +
                '            "snippet": "&nbsp;...client for filling key positions in their software development and solutions team. We are currently hiring for the position of  <b>Salesforce </b>Architect.  Applicants are expected to have worked in regulated industries with stringent compliance.  Specific Requirements:...&nbsp;",\n' +
                '            "salary": "$85 - $90 per hour",\n' +
                '            "source": "cvviz.com",\n' +
                '            "type": "Temporary",\n' +
                '            "link": "https://jooble.org/desc/-5878354666311703630?ckey=Salesforce&rgn=0&pos=12&groupId=36958&elckey=2730508911600716119&p=1&aq=-6399998284419032153&cid=3376&jobAge=72&relb=100&brelb=100&bscr=4292.0986&scr=4292.0986",\n' +
                '            "company": "Force Smiths",\n' +
                '            "updated": "2024-04-05T17:39:03.0122226+00:00",\n' +
                '            "id": -5878354666311703630\n' +
                '        },\n' +
                '        {\n' +
                '            "title": "Salesforce Lightening Developer - Junior",\n' +
                '            "location": "Houston, TX",\n' +
                '            "snippet": "&nbsp;...help our customers succeed. Come be a part of something truly special!\\r\\n\\r\\n We are seeking a junior level (2-3 years experience) <b>Salesforce </b>Lightening Developer for a long term contract role. Candidates will posess the following: \\r\\n Strong Lightning web component custom...&nbsp;",\n' +
                '            "salary": "$75k - $85k",\n' +
                '            "source": "applicantpro.com",\n' +
                '            "type": "Full-time",\n' +
                '            "link": "https://jooble.org/desc/-8863560385844578575?ckey=Salesforce&rgn=0&pos=13&groupId=36958&elckey=2730508911600716119&p=1&aq=-6399998284419032153&cid=3376&jobAge=93&relb=110&brelb=110&bscr=4205.413&scr=4205.413",\n' +
                '            "company": "Halvik",\n' +
                '            "updated": "2024-04-04T20:26:29.4777295+00:00",\n' +
                '            "id": -8863560385844578575\n' +
                '        },\n' +
                '        {\n' +
                '            "title": "Salesforce/Data Entry Internship",\n' +
                '            "location": "Indianapolis, IN",\n' +
                '            "snippet": "&nbsp;...dates from May to August 2024.  Interns must be available to wo  rk up to   40 hours  per week, for  at least   10 weeks  . \\r\\n The  <b>Salesforce </b>/Data Entry    Intern  will play a vital role in  administering our Salesforce platform  . This internship offers a unique...&nbsp;",\n' +
                '            "salary": "$20 per hour",\n' +
                '            "source": "applicantpro.com",\n' +
                '            "type": "Internship, Temporary",\n' +
                '            "link": "https://jooble.org/desc/-5868682225540769035?ckey=Salesforce&rgn=0&pos=14&groupId=36958&elckey=2730508911600716119&p=1&aq=-6399998284419032153&cid=3376&jobAge=201&relb=110&brelb=110&bscr=4158.3&scr=4158.3",\n' +
                '            "company": "Envelop Group",\n' +
                '            "updated": "2024-03-31T08:30:48.2425693+00:00",\n' +
                '            "id": -5868682225540769035\n' +
                '        },\n' +
                '        {\n' +
                '            "title": "Salesforce Developer",\n' +
                '            "location": "San Francisco, CA",\n' +
                '            "snippet": "&nbsp;...business requirements.\\r\\n~Engage with business stakeholders to gather and analyze requirements and propose solutions that leverage <b>Salesforce </b>functionality.\\r\\n~Configure and maintain custom objects, record types, fields, page layouts, formulas, data validation rules,...&nbsp;",\n' +
                '            "salary": "$57.5k - $90k",\n' +
                '            "source": "wearehiring.io",\n' +
                '            "type": "Full-time",\n' +
                '            "link": "https://jooble.org/jdp/-2305533345539769371?ckey=Salesforce&rgn=0&pos=15&groupId=36958&elckey=2730508911600716119&p=1&aq=-6399998284419032153&cid=3376&jobAge=394&relb=100&brelb=100&bscr=4151.568&scr=4151.568",\n' +
                '            "company": "Density",\n' +
                '            "updated": "2024-03-23T07:41:34.8583636+00:00",\n' +
                '            "id": -2305533345539769371\n' +
                '        },\n' +
                '        {\n' +
                '            "title": "Salesforce Business Systems Analyst",\n' +
                '            "location": "Chicago, IL",\n' +
                '            "snippet": "Kforce has a client in Chicago, IL that is seeking a highly skilled and motivated <b>Salesforce </b>Business Systems Analyst (BSA) specializing in Sales Cloud and Manufacturing Cloud to join our growing team. This role offers an exciting opportunity to contribute to the optimization...&nbsp;",\n' +
                '            "salary": "$50 - $62 per hour",\n' +
                '            "source": "kforce.com",\n' +
                '            "type": "Temporary",\n' +
                '            "link": "https://jooble.org/desc/-3111206382019518358?ckey=Salesforce&rgn=0&pos=16&groupId=36958&elckey=2730508911600716119&p=1&aq=-6399998284419032153&cid=3376&jobAge=258&relb=110&brelb=110&bscr=4150.834&scr=4150.834",\n' +
                '            "updated": "2024-03-29T00:00:00.0000000",\n' +
                '            "id": -3111206382019518358\n' +
                '        },\n' +
                '        {\n' +
                '            "title": "Salesforce Architect",\n' +
                '            "location": "Chicago, IL",\n' +
                '            "snippet": "&nbsp;...career with one of the fastest growing industries? LaSalle Network is partnered with a top Chicago-based client looking to hire a <b>Salesforce </b>Architect to their team.\\r\\nThe Salesforce Architect will be responsible for collaborating with various business units across the...&nbsp;",\n' +
                '            "salary": "$160k - $180k",\n' +
                '            "source": "The LaSalle Network Inc",\n' +
                '            "type": "Full-time",\n' +
                '            "link": "https://jooble.org/jdp/-4208654917821001859?ckey=Salesforce&rgn=0&pos=17&groupId=36958&elckey=2730508911600716119&p=1&aq=-6399998284419032153&cid=3376&jobAge=390&relb=100&brelb=100&bscr=4141.5557&scr=4141.5557",\n' +
                '            "company": "The LaSalle Network Inc",\n' +
                '            "updated": "2024-03-23T12:01:48.1135659+00:00",\n' +
                '            "id": -4208654917821001859\n' +
                '        },\n' +
                '        {\n' +
                '            "title": "Salesforce Administrator",\n' +
                '            "location": "Chicago, IL",\n' +
                '            "snippet": "&nbsp;...career with one of the fastest growing industries? LaSalle Network is partnered with a top Chicago-based client looking to hire a <b>Salesforce </b>Administrator to their team.\\r\\nThe Salesforce Administrator will be responsible for collaborating with various business units...&nbsp;",\n' +
                '            "salary": "$100k - $120k",\n' +
                '            "source": "The LaSalle Network Inc",\n' +
                '            "type": "Full-time",\n' +
                '            "link": "https://jooble.org/jdp/-5141595811519663989?ckey=Salesforce&rgn=0&pos=18&groupId=36958&elckey=2730508911600716119&p=1&aq=-6399998284419032153&cid=3376&jobAge=471&relb=100&brelb=100&bscr=4094.54&scr=4094.54",\n' +
                '            "company": "The LaSalle Network Inc",\n' +
                '            "updated": "2024-03-20T03:12:45.4800000",\n' +
                '            "id": -5141595811519663989\n' +
                '        },\n' +
                '        {\n' +
                '            "title": "Salesforce Apex Developer",\n' +
                '            "location": "Chicago, IL",\n' +
                '            "snippet": "&nbsp;...client for filling key positions in their software development and solutions team. We are currently hiring for the position of  <b>Salesforce </b>Apex Developer  . Applicants are expected to have worked in regulated industries with stringent compliance.  Specific Requirements...&nbsp;",\n' +
                '            "salary": "$80 - $85 per hour",\n' +
                '            "source": "cvviz.com",\n' +
                '            "type": "Temporary",\n' +
                '            "link": "https://jooble.org/desc/7922122615090222932?ckey=Salesforce&rgn=0&pos=19&groupId=36958&elckey=2730508911600716119&p=1&aq=-6399998284419032153&cid=3376&jobAge=72&relb=100&brelb=100&bscr=4090.2854&scr=4090.2854",\n' +
                '            "company": "Force Smiths",\n' +
                '            "updated": "2024-04-05T17:39:02.7446739+00:00",\n' +
                '            "id": 7922122615090222932\n' +
                '        },\n' +
                '        {\n' +
                '            "title": "Salesforce Engineer - Team Lead",\n' +
                '            "location": "Boca Raton, FL",\n' +
                '            "snippet": "Kforce has a client that is seeking a <b>Salesforce </b>Engineer - Team Lead in Boca Raton, FL.\\n\\nResponsibilities:\\n* Provide technical development leadership in designing, developing, and maintaining the Salesforce ecosystems, aligned with Architecture and implementation best...&nbsp;",\n' +
                '            "salary": "$130k - $140k",\n' +
                '            "source": "kforce.com",\n' +
                '            "type": "Full-time",\n' +
                '            "link": "https://jooble.org/desc/2947479561777174055?ckey=Salesforce&rgn=0&pos=20&groupId=36958&elckey=2730508911600716119&p=1&aq=-6399998284419032153&cid=3376&jobAge=354&relb=110&brelb=110&bscr=4080.4438&scr=4080.4438000000005",\n' +
                '            "updated": "2024-03-25T00:00:00.0000000",\n' +
                '            "id": 2947479561777174055\n' +
                '        }\n' +
                '    ]\n' +
                '}');

        httpResponse.setStatusCode(200);
        return httpResponse;
    }
}