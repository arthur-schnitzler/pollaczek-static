<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0" exclude-result-prefixes="tei xsl xs">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes"
        omit-xml-declaration="yes"/>
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="./partials/html_footer.xsl"/>
    <xsl:import href="./partials/params.xsl"/>
    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select="$project_short_title"/>
        </xsl:variable>
        <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
        <html xmlns="http://www.w3.org/1999/xhtml">
            <xsl:call-template name="html_head">
                <xsl:with-param name="html_title" select="$doc_title"/>
            </xsl:call-template>
            <body class="page">
                <div class="hfeed site" id="page">
                    <xsl:call-template name="nav_bar"/>
                    <div class="wrapper" id="wrapper-hero">
                        <div class="jumbotron" style="background-image: url(img/logo.jpg); background-size: 100%;">
                            <div class="carousel-caption" style="background-image: linear-gradient(rgba(38.0, 35.3, 37.6, 0.5), rgba(38.0, 35.3, 37.6, 0.5));position: static;">
                                <h1>Clara Katharina Pollaczek</h1>
                                <h2>»Arthur Schnitzler und ich«</h2>
                                <h2><i>Digitale Edition</i></h2>
                                
                            </div>
                        </div>                       
                    </div>
                    <div class="container" style="margin-top:1em;">
                        <div class="row">
                            <div class="col-md-8" style="margin: 0 auto; ">
                                <p style="font-size:18px;line-heigth:27px;">Am 21. Oktober 1931
                                    starb Arthur Schnitzler. In den folgenden Monaten verfasste
                                    seine Lebenspartnerin seit Februar 1923 ihre Erinnerungen, indem
                                    sie Briefe, Tagebucheinträge zusammenfügte und teilweise mit
                                    überleitenden Texten versah. Das Manuskript, das für die
                                    Veröffentlichung nach ihrem Tod vorgesehen war, umfasste 990 von
                                    Schnitzlers Sekretärin getippte Seiten und war bislang
                                    unveröffentlicht.</p>
                                <p style="font-size:18px;line-heigth:27px;">Wir legen hier eine
                                    Veröffentlichung als <hi rend="bold">Rohfassung</hi> vor, die
                                    nur teilweise fehlerbereinigt ist. Genauere Hinweise finden sich
                                    in den <ref type="url" target="">Editionsprinzipien</ref>.</p>
                                <p style="font-size:18px;line-heigth:27px;">Wir freuen uns über <ref
                                        type="url" target="">Mithilfe</ref>!</p>
                            </div>
                        </div>
                    </div>
                    <xsl:call-template name="html_footer"/>
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="tei:div//tei:head">
        <h2 id="{generate-id()}">
            <xsl:apply-templates/>
        </h2>
    </xsl:template>
    <xsl:template match="tei:p">
        <p id="{generate-id()}">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="tei:list">
        <ul id="{generate-id()}">
            <xsl:apply-templates/>
        </ul>
    </xsl:template>
    <xsl:template match="tei:item">
        <li id="{generate-id()}">
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    <xsl:template match="tei:ref">
        <xsl:choose>
            <xsl:when test="starts-with(data(@target), 'http')">
                <a>
                    <xsl:attribute name="href">
                        <xsl:value-of select="@target"/>
                    </xsl:attribute>
                    <xsl:value-of select="."/>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
