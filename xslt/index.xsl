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
                        <div class="jumbotron"
                            style="background-image: url(img/teaser.jpg); background-size: 100%;">
                            <div class="carousel-caption"
                                style="background-image: linear-gradient(rgba(38.0, 35.3, 37.6, 0.5), rgba(38.0, 35.3, 37.6, 0.5));position: static;">
                                <h1>Clara Katharina Pollaczek</h1>
                                <h2>»Arthur Schnitzler und ich«</h2>
                                <h2>Digitale Ausgabe</h2>
                            </div>
                        </div>
                    </div>
                    <div class="container" style="margin-top:1em;">
                        <div class="row">
                            <div class="col-md-8" style="margin: 0 auto; ">
                                <p style="font-size:18px;line-heigth:27px;">Am 21. Oktober 1931
                                    starb Arthur Schnitzler. In den 20 Monaten, die auf seinen Tod
                                    folgten, verfasste Clara Katharina Pollaczek, geborene Loeb,
                                    ihre Erinnerungen an das Kennenlernen in jungen Jahren und vor
                                    allem an die gemeinsame Zeit seit Februar 1923, während der sie seine
                                    zentrale Lebenspartnerin war. Sie fügte Briefe und
                                    Tagebucheinträge und teilweise auch andere Quellen zusammen und versah sie
                                    gelegentlich mit überleitenden Texten. Das Typoskript, für die
                                    postume Veröffentlichung vorgesehen, umfasst 990 von
                                    Schnitzlers Sekretärin Frieda Pollak getippte Seiten und blieb nach ihrem Tod am 22. Juli
                                    1951 siebzig Jahre lang unveröffentlicht. Bis zur vorliegenden Publikation war es
                                    zwar der Forschung bekannt, konnte aber nur in ihrem <a href="https://permalink.obvsg.at/wbr/AC15900634" target="_blank">Teilnachlass</a> in
                                    der Wienbibliothek im Rathaus eingesehen werden.</p>
                                <p style="font-size:18px;line-heigth:27px;">Wir legen hier eine
                                    digitale Ausgabe des Manuskripts in einer <b>Rohfassung</b> vor, die nur teilweise
                                    fehlerbereinigt ist. Genauere Hinweise finden sich in den <a
                                        href="editionsprinzipien.html">Editionsprinzipien</a>.</p>
                                <p style="font-size:18px;line-heigth:27px;">In Vorbereitung ist eine technisch überarbeitete Fassung der Aufsätze zu Pollaczek, die in dem von Stephan Kurz, Michael Rohrwasser und Daniel Schopper herausgegebenen Band <em>„A. ist manchmal wie ein kleines Kind“. Clara Katharina Pollaczek und Arthur Schnitzler gehen ins Kino</em> (Wien: Böhlau 2012) versammelt sind.</p>
                                <p style="font-size:18px;line-heigth:27px;">Wir freuen uns über Ihre
                                        <a href="mithilfe.html">Mithilfe</a>!</p>
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
