# OpenLIMS

## About

The main source of information for the legislative activities of the Council of the District of Columbia is the Legislative Information Management System (LIMS). LIMS is available at <http://lims.dccouncil.us>.

In 2013, the Council upgraded the LIMS interface, which was built on an undocumented REST API. The OpenLIMS API is a simple way of accessing that REST API, so that other sites can access information directly from LIMS.

It has been used to create an [RSS feed for new Council legislation](https://esq.io/lims-rss.xml), a treemap of the number of measures referred to a [committee](http://code.esq.io/limsdash/committees.html), and a listing of bills referred to the [Committee of the Whole](http://chairmanmendelson.com/cow/committee-legislation). 

The OpenLIMS API is built with Ruby and Sinatra and is hosted on Heroku. The source code is [hosted on GitHub](https://github.com/vzvenyach/limsrb). If you have any questions, please [open up an issue](https://github.com/vzvenyach/limsrb/issues).

# Usage

To access the OpenLIMS API, go to <https://openlims.herokuapp.com>. There are currently 4 supported API endpoints:

1.  `measure`
2.  `committees`
3.  `laws`
4.  `search`

Each endpoint is accessible only with a `GET` request and will respond with a json object. The `/measure` endpoint is supported from Council Period 8 through the present. As of right now, that is the only endpoint with data from before Council Period 20.

## Measure

### Parameters 

`/measure/:measure`

### Example

<https://openlims.herokuapp.com/measure/B20-0461>

### Description

Returns metadata associated with the measure.

## Committees

### Parameters

`/committees?committee_id=<id>&status=<status>`

### Example

<https://openlims.herokuapp.com/committees?committee_id=204&status=0>

### Description

Returns all of the measures in a committee based on the `committee_id` and `status` parameters. A listing of parameter values is below.

## Laws

### Parameters

`/laws?count=<count>`

### Example

<https://openlims.herokuapp.com/laws?count=20>

### Description

Gets a list of the most recent acts that are law.

## Search

### Parameters

`/search?q=<q>&measure_type=<measure_type>&status=<status>&start_date=<start_date>&council_period=<council_period>`

### Example

<https://openlims.herokuapp.com/search?q=technology&measure_type=1&status=0&start_date=1/1/2015>

### Description

Allows you to do a full-text search against the LIMS database using the `q` parameter and to filter based on the other parameters. A listing of parameter values is available below.

# Parameter Details

### member_id

id  | councilmember | council period
----|---------------|----------------
230 | Yvette Alexander | 21
239 | Charles Allen | 21
231 | Anita Bonds | 21
232 | Mary Cheh | 21
233 | Jack Evans | 21
234 | David Grosso | 21
235 | Kenyan McDuffie | 21
237 | Phil Mendelson | 21
240 | Brianne Nadeau |21
236 | Vincent Orange | 21
238 | Elissa Silverman | 21

### committee_id

id  | committee_name                             | council period
----|--------------------------------------------|----------------
191 | Business, Consumer, and Regulatory Affairs | 20
192 | Committee of the Whole | 20
193 | Economic Development | 20
194 | Education | 20
195 | Finance and Revenue | 20
196 | Government Operations | 20
197 | Health | 20
198 | Human Services | 20
199 | Judiciary and Public Safety | 20
200 | Retained by the Council | 20
201 | Transportation and the Environment | 20
202 | Retained by the Council | 20
203 | Business, Consumer, and Regulatory Affairs | 21
204 | Committee of the Whole | 21
205 | Education | 21
206 | Finance and Revenue | 21
207 | Health and Human Services | 21
208 | Housing and Community Development | 21
209 | Judiciary | 21
210 | Retained | 21

### status

id | status description
---|-------------------
0 | Any status
10 | New
40 | Under Council Review
50 | Under Mayoral Review
60 | Enacted
70 | Under Congressional Review
80 | Vetoed
90 | Deemed Approved
100 | Deemed Disapproved
110 | Approved
120 | Disapproved
130 | Official Law
140 | Withdrawn

### measure_type

id | description
---|-------------
1  | Bill
2  | Resolution
3  | Contract