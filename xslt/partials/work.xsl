<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:df="http://example.com/df" xmlns:mam="whatever" version="2.0"
    exclude-result-prefixes="xsl tei xs">
    <!--<xsl:import href="germandate.xsl"/>-->
    
    
    <xsl:param name="relevant-uris" select="document('../utils/list-of-relevant-uris.xml')"/>
    <xsl:key name="only-relevant-uris" match="item" use="abbr"/>
    <xsl:param name="works" select="document('../../data/indices/listwork.xml')"/>
    <xsl:key name="work-lookup" match="tei:bibl" use="tei:relatedItem/@target"/>
    <xsl:param name="authors" select="document('../../data/indices/listperson.xml')"/>
    <xsl:key name="author-lookup" match="tei:person" use="tei:idno[@subtype='pmb']"/>
    <xsl:param name="work-day"
        select="document('../../data/indices/index_work_day.xml')"/>
    <xsl:key name="work-day-lookup" match="item" use="ref"/>
    
    <xsl:function name="mam:normalize-date">
        <xsl:param name="date-string-mit-spitze" as="xs:string?"/>
        <xsl:variable name="date-string" as="xs:string">
            <xsl:choose>
                <xsl:when test="contains($date-string-mit-spitze, '&lt;')">
                    <xsl:value-of select="substring-before($date-string-mit-spitze, '&lt;')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$date-string-mit-spitze"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:analyze-string select="$date-string" regex="^(\d{{4}})-(\d{{2}})-(\d{{2}})$">
            <xsl:matching-substring>
                <xsl:variable name="year" select="xs:integer(regex-group(1))"/>
                <xsl:variable name="month">
                    <xsl:choose>
                        <xsl:when test="starts-with(regex-group(2), '0')">
                            <xsl:value-of select="substring(regex-group(2), 2)"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="regex-group(2)"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:variable name="day">
                    <xsl:choose>
                        <xsl:when test="starts-with(regex-group(3), '0')">
                            <xsl:value-of select="substring(regex-group(3), 2)"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="regex-group(3)"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:value-of select="concat($day, '. ', $month, '. ', $year)"/>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:analyze-string select="." regex="^(\d{{2}}).(\d{{2}}).(\d{{4}})$">
                    <xsl:matching-substring>
                        <xsl:variable name="year" select="xs:integer(regex-group(3))"/>
                        <xsl:variable name="month">
                            <xsl:choose>
                                <xsl:when test="starts-with(regex-group(2), '0')">
                                    <xsl:value-of select="substring(regex-group(2), 2)"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="regex-group(2)"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <xsl:variable name="day">
                            <xsl:choose>
                                <xsl:when test="starts-with(regex-group(1), '0')">
                                    <xsl:value-of select="substring(regex-group(1), 2)"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="regex-group(1)"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <xsl:value-of select="concat($day, '. ', $month, '. ', $year)"/>
                    </xsl:matching-substring>
                    <xsl:non-matching-substring>
                        <xsl:value-of select="."/>
                    </xsl:non-matching-substring>
                </xsl:analyze-string>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:function>
    <xsl:function name="df:germanNames">
        <xsl:param name="input"/>
        <xsl:choose>
            <xsl:when test="$input='Monday'">Montag</xsl:when>
            <xsl:when test="$input='Tuesday'">Dienstag</xsl:when>
            <xsl:when test="$input='Wednesday'">Mittwoch</xsl:when>
            <xsl:when test="$input='Thursday'">Donnerstag</xsl:when>
            <xsl:when test="$input='Friday'">Freitag</xsl:when>
            <xsl:when test="$input='Saturday'">Samstag</xsl:when>
            <xsl:when test="$input='Sunday'">Sonntag</xsl:when>
            <xsl:when test="$input='January'">Januar</xsl:when>
            <xsl:when test="$input='February'">Februar</xsl:when>
            <xsl:when test="$input='March'">März</xsl:when>
            <xsl:when test="$input='May'">Mai</xsl:when>
            <xsl:when test="$input='June'">Juni</xsl:when>
            <xsl:when test="$input='July'">Juli</xsl:when>
            <xsl:when test="$input='October'">Oktober</xsl:when>
            <xsl:when test="$input='December'">Dezember</xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$input"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <xsl:template match="tei:bibl" name="work_detail">
        <xsl:param name="showNumberOfMentions" as="xs:integer" select="50000"/>
        <xsl:variable name="selfLink">
            <xsl:value-of select="concat(data(@xml:id), '.html')"/>
        </xsl:variable>
        <div class="card-body-index">
            
            <xsl:if test="tei:author">
                <div id="autor_innen">
                    <p>
                        <legend>Geschaffen von</legend>
                        <xsl:choose>
                            <xsl:when test="tei:author[2]">
                                <ul>
                                    <xsl:for-each select="tei:author">
                                        <li>
                                            <xsl:variable name="keyToRef" as="xs:string">
                                                <xsl:choose>
                                                    <xsl:when test="@key !=''">
                                                        <xsl:value-of select="@key"/>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <xsl:value-of select="@ref"/>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </xsl:variable>
                                            <xsl:variable name="autor-ref" as="xs:string">
                                                <xsl:choose>
                                                    <xsl:when test="contains($keyToRef, 'person__')">
                                                        <xsl:value-of select="substring-after($keyToRef, 'person__')"/>
                                                    </xsl:when>
                                                    <xsl:when test="starts-with($keyToRef, 'pmb')">
                                                        <xsl:value-of select="replace($keyToRef, 'pmb', '')"/>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <xsl:value-of select="$keyToRef"/>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </xsl:variable>
                                            <xsl:choose>
                                                <xsl:when test="$autor-ref = 'pmb2121'">
                                                    <a href="pmb2121.html">
                                                        <xsl:text>Arthur Schnitzler</xsl:text>
                                                    </a>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                        <xsl:choose>
                                                            <xsl:when
                                                                test="child::tei:forename and child::tei:surname">
                                                                <xsl:value-of select="tei:persName/tei:forename"/>
                                                                <xsl:text> </xsl:text>
                                                                <xsl:value-of select="tei:persName/tei:surname"/>
                                                            </xsl:when>
                                                            <xsl:when test="child::tei:surname">
                                                                <xsl:value-of select="child::tei:surname"/>
                                                            </xsl:when>
                                                            <xsl:when test="child::tei:forename">
                                                                <xsl:value-of select="child::tei:forename"/>"/> </xsl:when>
                                                            <xsl:when test="contains(., ', ')">
                                                                <xsl:value-of
                                                                    select="concat(substring-after(., ', '), ' ', substring-before(., ', '))"
                                                                />
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <xsl:value-of select="."/>
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    <xsl:if test="@role = 'editor'">
                                                        <xsl:text> (Herausgabe)</xsl:text>
                                                    </xsl:if>
                                                    <xsl:if test="@role = 'translator'">
                                                        <xsl:text> (Übersetzung)</xsl:text>
                                                    </xsl:if>
                                                    <xsl:if test="@role = 'illustrator'">
                                                        <xsl:text> (Illustration)</xsl:text>
                                                    </xsl:if>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </li>
                                    </xsl:for-each>
                                </ul>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:variable name="keyToRef" as="xs:string">
                                    <xsl:choose>
                                        <xsl:when test="tei:author/@key !=''">
                                            <xsl:value-of select="tei:author/@key"/>
                                        </xsl:when>
                                        <xsl:when test="tei:author/@ref !=''">
                                            <xsl:value-of select="tei:author/@ref"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:text>SELTSAM</xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:variable>
                                <xsl:variable name="autor-ref" as="xs:string">
                                    <xsl:choose>
                                        <xsl:when test="contains($keyToRef, 'person__')">
                                            <xsl:value-of select="substring-after($keyToRef, 'person__')"/>
                                        </xsl:when>
                                        <xsl:when test="starts-with($keyToRef, 'pmb')">
                                            <xsl:value-of select="replace($keyToRef, 'pmb', '')"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="$keyToRef"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:variable>
                                <xsl:choose>
                                    <xsl:when test="$autor-ref = 'pmb2121'">
                                        <a href="pmb2121.html">
                                            <xsl:text>Arthur Schnitzler</xsl:text>
                                        </a>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="./tei:author"/><!--<xsl:variable name="autor-ref-schnitzler-tagebuch" select="key('author-lookup', concat('https://pmb.acdh.oeaw.ac.at/entity/', $autor-ref), $authors)/tei:idno[@subtype='schnitzler-tagebuch']/substring-after(., 'https://schnitzler-tagebuch.acdh.oeaw.ac.at/entity/')"/>
                                        <a>
                                            <xsl:attribute name="href">
                                                <xsl:value-of select="concat($autor-ref-schnitzler-tagebuch, '.html')"/>
                                            </xsl:attribute>
                                            <xsl:choose>
                                                <xsl:when
                                                    test="child::tei:forename and child::tei:surname">
                                                    <xsl:value-of select="tei:persName/tei:forename"/>
                                                    <xsl:text> </xsl:text>
                                                    <xsl:value-of select="tei:persName/tei:surname"/>
                                                </xsl:when>
                                                <xsl:when test="child::tei:surname">
                                                    <xsl:value-of select="child::tei:surname"/>
                                                </xsl:when>
                                                <xsl:when test="child::tei:forename">
                                                    <xsl:value-of select="child::tei:forename"/>"/> </xsl:when>
                                                <xsl:when test="contains(., ', ')">
                                                    <xsl:value-of
                                                        select="concat(substring-after(tei:author[1], ', '), ' ', substring-before(tei:author[1], ', '))"
                                                    />
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:value-of select="tei:author[1]"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </a>
                                        <xsl:if test="@role = 'editor'">
                                            <xsl:text> (Herausgabe)</xsl:text>
                                        </xsl:if>
                                        <xsl:if test="@role = 'translator'">
                                            <xsl:text> (Übersetzung)</xsl:text>
                                        </xsl:if>
                                        <xsl:if test="@role = 'illustrator'">
                                            <xsl:text> (Illustration)</xsl:text>
                                        </xsl:if>-->
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:otherwise>
                        </xsl:choose>
                    </p>
                </div>
                <div id="erscheinungsdatum" class="mt-2">
                    <p>
                        <xsl:if test="tei:date[1]">
                            <legend>Erschienen</legend>
                            <xsl:choose>
                                <xsl:when test="contains(tei:date[1], '–')">
                                    <xsl:choose>
                                        <xsl:when test="normalize-space(tokenize(tei:date[1], '–')[1]) = normalize-space(tokenize(tei:date[1], '–')[2])">
                                            <xsl:value-of select="mam:normalize-date(normalize-space((tokenize(tei:date[1], '–')[1])))"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="mam:normalize-date(normalize-space(tei:date[1]))"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="mam:normalize-date(tei:date[1])"/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <xsl:if test="not(ends-with(tei:date[1], '.'))">
                                <xsl:text>.</xsl:text>
                            </xsl:if>
                        </xsl:if>
                    </p>
                </div>
                <p/>
            </xsl:if>
            <xsl:if
                test="tei:title[@type = 'werk_bibliografische-angabe' or starts-with(@type,  'werk_link')]">
                <div id="labels" class="mt-2">
                    <span class="infodesc mr-2">
                        <ul>
                            <xsl:for-each select="tei:title[@type = 'werk_bibliografische-angabe']">
                                <li><xsl:text>Bibliografische Angabe: </xsl:text>
                                    <xsl:value-of select="."/>
                                </li>
                            </xsl:for-each>
                            <xsl:for-each select="tei:title[starts-with(@type, 'werk_link')]">
                                <li>
                                    <a>
                                        <xsl:attribute name="href">
                                            <xsl:value-of select="."/>
                                        </xsl:attribute>
                                        <xsl:attribute name="target">
                                            <xsl:text>_blank</xsl:text>
                                        </xsl:attribute>
                                        <xsl:text>Online verfügbar</xsl:text>
                                    </a>
                                </li>
                            </xsl:for-each>
                        </ul>
                    </span>
                </div>
            </xsl:if>
            <!--<div id="mentions" class="mt-2">
                <span class="infodesc mr-2">Erwähnt am</span>
                <ul class="list-unstyled">
                    
                </ul>
            </div>-->
        </div>
    </xsl:template>
    
    
</xsl:stylesheet>