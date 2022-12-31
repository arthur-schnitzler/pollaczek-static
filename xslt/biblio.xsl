<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0" xmlns:local="http://dse-static.foo.bar" exclude-result-prefixes="xsl tei xs">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes"
        omit-xml-declaration="yes"/>
    <xsl:import href="./partials/shared.xsl"/>
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="partials/html_footer.xsl"/>
    <xsl:import href="partials/osd-container.xsl"/>
    <xsl:import href="partials/tei-facsimile.xsl"/>
    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select=".//tei:title[@type = 'main'][1]/text()"/>
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
                                <h2 align="center"><xsl:value-of select="$doc_title"/></h2>
                                <h3><xsl:value-of select="root()//tei:teiHeader//tei:author"/></h3>
                            </div>
                            <div class="card-body-index">                                
                                <xsl:apply-templates select=".//tei:body"></xsl:apply-templates>
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
                        <h3>Noten</h3>
                        
                            <xsl:for-each select=".//tei:note[not(./tei:p)]">
                                <p class="footnotes" id="{local:makeId(.)}">
                                    <xsl:element name="a">
                                        <xsl:attribute name="name">
                                            <xsl:text>fn</xsl:text>
                                            <xsl:number level="any" format="1"
                                                count="tei:note"/>
                                        </xsl:attribute>
                                        <a>
                                            <xsl:attribute name="href">
                                                <xsl:text>#fna_</xsl:text>
                                                <xsl:number level="any" format="1"
                                                    count="tei:note"/>
                                            </xsl:attribute>
                                            <span
                                                style="font-size:7pt;vertical-align:super; margin-right: 0.4em">
                                                <xsl:number level="any" format="1"
                                                    count="tei:note"/>
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
                <xsl:when test="@rend='summary'">
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
    <xsl:template match="tei:head">
        <strong>
            <xsl:apply-templates/>
        </strong>
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
                        <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
                    </xsl:choose>
                </a>
            </xsl:when>
            <xsl:when test="@subtype='arthur-schnitzler-und-ich'"><a href="{concat(@target, '.html')}">AS und ich, <xsl:value-of select="substring-after(@target, 'ckp')"/></a> </xsl:when>
            <xsl:when test="@subtype='schnitzler-tagebuch'"><a href="{concat('https://schnitzler-tagebuch.acdh.oeaw.ac.at/entry__', @target, '.html')}">Schnitzler Tagebuch, <xsl:value-of select="@target"/></a> </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:list">
        <ul>
            <xsl:apply-templates/>
        </ul>
    </xsl:template>
    <xsl:template match="tei:item">
        <li>
            <xsl:apply-templates/>
        </li>
    </xsl:template>
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
        <span>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:item/tei:title">
        <span style="font-weight: bold; color: #1e81b0;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="tei:bibl">
        <p><xsl:apply-templates/></p>
    </xsl:template>

</xsl:stylesheet>
