<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:functx="http://www.functx.com" version="2.0"
    xmlns:local="http://dse-static.foo.bar" exclude-result-prefixes="xsl tei xs">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes"
        omit-xml-declaration="yes"/>
    <xsl:function name="functx:escape-for-regex" as="xs:string" xmlns:functx="http://www.functx.com">
        <xsl:param name="arg" as="xs:string?"/>
        <xsl:sequence
            select="replace($arg, '(\.|\[|\]|\\|\||\-|\^|\$|\?|\*|\+|\{|\}|\(|\))', '\\$1')"/>
    </xsl:function>
    <xsl:function name="functx:substring-after-last" as="xs:string"
        xmlns:functx="http://www.functx.com">
        <xsl:param name="arg" as="xs:string?"/>
        <xsl:param name="delim" as="xs:string"/>
        <xsl:sequence select="replace($arg, concat('^.*', functx:escape-for-regex($delim)), '')"/>
    </xsl:function>
    <xsl:import href="./partials/shared.xsl"/>
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="partials/html_footer.xsl"/>
    <xsl:import href="partials/osd-container.xsl"/>
    <xsl:import href="partials/tei-facsimile.xsl"/>
    <xsl:variable name="teiSource">
        <xsl:choose>
            <xsl:when test="tei:TEI/@xml:id">
                <xsl:value-of select="data(tei:TEI/@xml:id)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="functx:substring-after-last(base-uri(root()), '/')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select="root()//tei:titleStmt//tei:title[@type = 'main'][1]/text()"/>
        </xsl:variable>
        <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
        <html>
            <xsl:call-template name="html_head">
                <xsl:with-param name="html_title" select="$doc_title"/>
            </xsl:call-template>
            <body class="page">
                <div class="hfeed site" id="page">
                    <xsl:call-template name="nav_bar"/>
                    <div class="container-fluid">
                        <div class="card">
                            <div class="card-header">
                                <h2 align="center">
                                    <xsl:value-of select="$doc_title"/>
                                </h2>
                                <h3 align="center">
                                    <xsl:choose>
                                        <xsl:when
                                            test="contains(descendant::tei:teiHeader//tei:titleStmt/tei:author, ', ')">
                                            <xsl:value-of
                                                select="substring-after(descendant::tei:teiHeader//tei:titleStmt/tei:author, ', ')"/>
                                            <xsl:text> </xsl:text>
                                            <xsl:value-of
                                                select="substring-before(descendant::tei:teiHeader//tei:titleStmt/tei:author, ', ')"
                                            />
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of
                                                select="(descendant::tei:teiHeader//tei:titleStmt/tei:author, ',')"
                                            />
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </h3>
                                <h3 align="center">
                                    <a href="{$teiSource}">
                                        <i class="fas fa-code" title="zeige TEI"/>
                                    </a>
                                </h3>
                            </div>
                            <div class="card-body-index">
                                <xsl:apply-templates select=".//tei:body"/>
                                <xsl:apply-templates select=".//tei:standOff"/>
                            </div>
                            <xsl:if test="descendant::tei:footNote">
                                <div class="card-body-index">
                                    <p/>
                                    <xsl:element name="ol">
                                        <xsl:attribute name="class">
                                            <xsl:text>list-for-footnotes-meta</xsl:text>
                                        </xsl:attribute>
                                        <xsl:apply-templates select="descendant::tei:footNote"
                                            mode="footnote"/>
                                    </xsl:element>
                                </div>
                            </xsl:if>
                        </div>
                    </div>
                    <div class="card-footer">
                        <h3>Anmerkungen</h3>
                        <xsl:for-each select=".//tei:note[not(./tei:p)][@type = 'footnote']">
                            <p class="footnotes" id="{local:makeId(.)}">
                                <xsl:element name="a">
                                    <xsl:attribute name="name">
                                        <xsl:text>fn</xsl:text>
                                        <xsl:number level="any" format="1" count="tei:note"/>
                                    </xsl:attribute>
                                    <a>
                                        <xsl:attribute name="href">
                                            <xsl:text>#fna_</xsl:text>
                                            <xsl:number level="any" format="1" count="tei:note"/>
                                        </xsl:attribute>
                                        <span
                                            style="font-size:7pt;vertical-align:super; margin-right: 0.4em">
                                            <xsl:number level="any" format="1" count="tei:note"/>
                                        </span>
                                    </a>
                                </xsl:element>
                                <xsl:apply-templates/>
                                <xsl:if test="not(ends-with(string-join(.//text(), ''), '.'))">
                                    <xsl:text>. </xsl:text>
                                </xsl:if>
                            </p>
                        </xsl:for-each>
                    </div>
                    <xsl:call-template name="html_footer"/>
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="tei:p">
        <p id="{generate-id()}">
            <xsl:choose>
                <xsl:when test="@rend = 'summary'">
                    <xsl:attribute name="style">font-style:italic</xsl:attribute>
                </xsl:when>
            </xsl:choose>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="tei:div">
        <div id="{generate-id()}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="tei:biblStruct">
        <li>
            <div id="{generate-id()}" class="my-5">
                <span class="text-muted">(<xsl:value-of select="@type"/>, <xsl:choose>
                        <xsl:when test="./tei:analytic/tei:date"><xsl:apply-templates
                                select="./tei:analytic/tei:date"/></xsl:when>
                        <xsl:otherwise><xsl:apply-templates select="./tei:monogr//tei:date"
                            /></xsl:otherwise>
                    </xsl:choose>)</span><br/>
                <xsl:if test="./tei:analytic">
                    <xsl:apply-templates select="tei:analytic"/>
                </xsl:if>
                <xsl:if test="./tei:analytic and ./tei:monogr//tei:title//text()"
                    ><xsl:text> In: </xsl:text></xsl:if>
                <xsl:if test="./tei:monogr//tei:title//text()">
                    <xsl:apply-templates select="tei:monogr"/>
                    <xsl:text>. </xsl:text></xsl:if>
                <div class="notes">
                    <xsl:apply-templates select="./tei:note"/>
                </div>
                <xsl:if test="tei:analytic/tei:ref">
                    <p>Link<xsl:if test="tei:analytic/tei:ref[2]">s</xsl:if>: <xsl:apply-templates
                            select="tei:analytic/tei:ref"/>
                    </p>
                </xsl:if>
            </div>
        </li>
    </xsl:template>
    <xsl:template match="tei:analytic">
        <xsl:apply-templates select="tei:author"/>
        <xsl:apply-templates select="tei:title"/>
        <xsl:text>. </xsl:text>
    </xsl:template>
    <xsl:template match="tei:monogr">
        <xsl:if test="string-length(string-join(.//text(), '')) gt 2">
            <xsl:if test="tei:author">
                <xsl:apply-templates select="tei:author"/>
            </xsl:if>
            <xsl:if test="tei:editor">
                <xsl:apply-templates select="tei:editor"/>
                <xsl:text>: </xsl:text>
            </xsl:if>
            <xsl:if test="tei:title//text()">
                <xsl:apply-templates select="tei:title"/>
                <xsl:if test="not(preceding-sibling::tei:analytic)">
                    <xsl:text>. </xsl:text>
                </xsl:if>
            </xsl:if>
            <xsl:apply-templates select="tei:imprint"/>
            <xsl:if test="tei:date//text()">
                <span class="text-muted date">
                    <xsl:apply-templates select="./tei:date"/>
                </span>
            </xsl:if>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:author | tei:editor">
        <span class="{./name()}">
            <xsl:choose>
                <xsl:when test="@key = 'https://d-nb.info/gnd/13950916X'">
                    <!-- gobble CKP -->
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="tei:surname and tei:forename">
                            <strong>
                                <xsl:apply-templates select="tei:surname"/>
                            </strong>
                            <xsl:text>, </xsl:text>
                            <xsl:apply-templates select="tei:forename"/>
                            <xsl:if test="parent::tei:monogr or parent::tei:analytic">
                                <xsl:text>: </xsl:text>
                            </xsl:if>
                        </xsl:when>
                        <xsl:otherwise>
                            <strong>
                                <xsl:apply-templates select=".//text()"/>
                            </strong>
                            <xsl:if test="parent::tei:monogr or parent::tei:analytic">
                                <xsl:text>: </xsl:text>
                            </xsl:if>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>
    <xsl:template match="tei:imprint">
        <xsl:if test="./tei:pubPlace">
            <span class="pubPlace">
                <xsl:apply-templates select="./tei:pubPlace"/>
            </span>
            <xsl:text>: </xsl:text>
        </xsl:if>
        <xsl:if test="./tei:publisher">
            <span class="publisher">
                <xsl:apply-templates select="./tei:publisher"/>
            </span>
            <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:if test="tei:date">
            <span class="date">
                <xsl:apply-templates select="./tei:date"/>
            </span>
        </xsl:if>
        <xsl:if test="tei:biblScope[@unit = 'jg']/text()">
            <xsl:text>, Jg. </xsl:text>
            <xsl:apply-templates select="tei:biblScope[@unit = 'jg']"/>
        </xsl:if>
        <xsl:if test="tei:biblScope[@unit = 'volume']/text()">
            <xsl:text> (</xsl:text>
            <xsl:apply-templates select="tei:biblScope[@unit = 'volume']"/>
            <xsl:text>) </xsl:text>
        </xsl:if>
        <xsl:if test="tei:biblScope[@unit = 'number']/text()">
            <xsl:apply-templates select="tei:biblScope[@unit = 'number']"/>
            <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:if test="tei:biblScope[@unit = 'page']/text()">
            <xsl:text>, </xsl:text>
            <xsl:apply-templates select="tei:biblScope[@unit = 'page']"/>
        </xsl:if>
        <xsl:apply-templates select="./tei:note[@type = 'url']"/>
    </xsl:template>
    <xsl:template match="tei:head">
        <h2>
            <xsl:apply-templates/>
        </h2>
    </xsl:template>
    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>
    <xsl:template match="tei:unclear">
        <abbr title="unclear">
            <xsl:apply-templates/>
        </abbr>
    </xsl:template>
    <xsl:template match="tei:del">
        <del>
            <xsl:apply-templates/>
        </del>
    </xsl:template>
    <xsl:template match="tei:ref">
        <xsl:choose>
            <xsl:when test="starts-with(data(@target), 'http')">
                <a>
                    <xsl:attribute name="href">
                        <xsl:value-of select="@target"/>
                    </xsl:attribute>
                    <xsl:attribute name="title">
                        <xsl:value-of select="@target"/>
                    </xsl:attribute>
                    <xsl:choose>
                        <xsl:when test="ancestor::tei:item/tei:listRef">
                            <xsl:text>[</xsl:text>
                            <xsl:value-of select="number(position()) div 2"/>
                            <xsl:text>] </xsl:text>
                        </xsl:when>
                        <xsl:when test="ancestor::tei:analytic">
                            <xsl:text>[</xsl:text>
                            <xsl:value-of select="number(position())"/>
                            <xsl:text>] </xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="."/>
                        </xsl:otherwise>
                    </xsl:choose>
                </a>
            </xsl:when>
            <xsl:when test="@subtype = 'arthur-schnitzler-und-ich'">
                <a href="{concat(@target, '.html')}">AS und ich, <xsl:value-of
                        select="substring-after(@target, 'ckp')"/></a>
            </xsl:when>
            <xsl:when test="@subtype = 'schnitzler-tagebuch'">
                <a
                    href="{concat('https://schnitzler-tagebuch.acdh.oeaw.ac.at/entry__', @target, '.html')}"
                    >Schnitzler Tagebuch, <xsl:value-of select="@target"/></a>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:list">
        <ul>
            <xsl:apply-templates/>
        </ul>&#160; </xsl:template>
    <xsl:template match="tei:listBibl">
        <section xml:id="{@type}">
            <div>
                <xsl:apply-templates/>
            </div>&#160; </section>
    </xsl:template>
    <xsl:template match="tei:item">
        <li>
            <xsl:apply-templates/>
        </li>&#160; </xsl:template>
    <xsl:template match="tei:hi[@rend = 'italics']">
        <i>
            <xsl:apply-templates/>
        </i>
    </xsl:template>
    <xsl:template match="tei:hi[@rend = 'bold']">
        <b>
            <xsl:apply-templates/>
        </b>
    </xsl:template>
    <xsl:template match="tei:hi[@rend = 'underline']">
        <u>
            <xsl:apply-templates/>
        </u>
    </xsl:template>
    <xsl:template match="tei:title">
        <em class="title">
            <xsl:apply-templates/>
        </em>
    </xsl:template>
    <xsl:template match="tei:title[parent::tei:analytic or (parent::tei:monogr and not(parent::tei:monogr/preceding-sibling::tei:analytic))]">
            <span style="font-weight: bold; color: #1e81b0;">
                <xsl:apply-templates/>
            </span>
    </xsl:template>
    
    <xsl:template match="tei:bibl">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:note[@type = 'footnote']">
        <xsl:element name="a" xmlns="http://www.w3.org/1999/xhtml">
            <xsl:attribute name="name">
                <xsl:text>fna_</xsl:text>
                <xsl:number level="any" format="1" count="tei:note"/>
            </xsl:attribute>
            <xsl:attribute name="href">
                <xsl:text>#fn</xsl:text>
                <xsl:number level="any" format="1" count="tei:note"/>
            </xsl:attribute>
            <xsl:attribute name="title">
                <xsl:value-of select="normalize-space(.)"/>
            </xsl:attribute>
            <sup>
                <xsl:number level="any" format="1" count="tei:note"/>
            </sup>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:note[not(@type = 'footnote')]">
        <p class="{@type}">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="tei:standOff">
        <ul>
            <xsl:apply-templates select="tei:biblStruct"/>
        </ul>
    </xsl:template>
</xsl:stylesheet>
