<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xsl tei xs" version="2.0">
    <xsl:template match="/" name="nav_bar">
        <div class="wrapper-fluid wrapper-navbar sticky-navbar" id="wrapper-navbar" itemscope="" itemtype="http://schema.org/WebSite">
            <a class="skip-link screen-reader-text sr-only" href="#content">Zum Inhalt</a>
            <nav class="navbar navbar-expand-lg navbar-light">
                <div class="container-fluid">
                    <!-- Your site title as branding in the menu -->
                    <a href="index.html" class="navbar-brand custom-logo-link" rel="home" itemprop="url">
                        <img src="img/logo.jpg" class="img-fluid" alt="schnitzler-briefe" itemprop="logo"/>
                    </a><!-- end custom logo -->
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"/>
                    </button>
                    <div class="collapse navbar-collapse justify-content-end" id="navbarNavDropdown">
                        <ul id="main-menu" class="navbar-nav">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    Zur Edition
                                </a>
                                <div class="dropdown-menu">
                                    <a class="dropdown-item" href="projekt.html">Zur Edition</a>
                                    <a class="dropdown-item" href="editionsprinzipien.html">Editionsprinzipien</a>
                                    <a class="dropdown-item" href="mithilfe.html">Mithilfe</a>
                                    <a class="dropdown-item" href="zitat.html">Zitieren</a>
                                    <a class="dropdown-item" href="ebook.html">E-Book</a>
                                    <a title="Links" href="https://www.digital.wienbibliothek.at/wbrobv/content/titleinfo/4183713"
                                        class="nav-link" target="_blank">Faksimile der Wienbibliothek</a>
                                    <a title="Links" href="CP-aufsatz.html" class="nav-link">Biografischer Aufsatz (Stephan Kurz)</a>
                                    <a title="Links" href="https://schnitzler.acdh.oeaw.ac.at"
                                        class="nav-link" target="_blank">Schnitzler am ACDH-CH</a>
                                    <a title="Links"
                                        href="https://github.com/arthur-schnitzler/pollaczek-data"
                                        class="nav-link" target="_blank">Daten auf GitHub</a>
                                </div>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    Clara Katharina Pollaczek
                                </a>
                                <div class="dropdown-menu">
                                    <a title="Links" href="listBibl.html"
                                        class="nav-link" target="_blank">Bibliografie</a>
                                    <a title="Links" href="https://de.wikipedia.org/wiki/Clara_Katharina_Pollaczek"
                                        class="nav-link" target="_blank">Wikipedia-Eintrag</a>
                                    <a title="Links" href="https://www.geschichtewiki.wien.gv.at/Clara_Katharina_Pollaczek"
                                        class="nav-link" target="_blank">Wien Geschichte Wiki</a>
                                    <a title="Links" href="https://fraueninbewegung.onb.ac.at/node/2555"
                                        class="nav-link" target="_blank">Frauen in Bewegung</a>
                                    <a title="Links"
                                        href="https://permalink.obvsg.at/wbr/AC15900634"
                                        class="nav-link" target="_blank">Teilnachlass Wienbibliothek</a>
                                    <a title="Links" href="https://schnitzler-tagebuch.acdh.oeaw.ac.at/person_18863.html"
                                        class="nav-link" target="_blank">… in Schnitzlers Tagebuch</a>
                                    
                                </div>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="calendar.html">Kalender</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="toc.html">Inhaltsverzeichnis</a>
                            </li>
                            <!--<li class="nav-item">
                                <a class="nav-link isDisabled" href="#">Personen</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link isDisabled" href="#">Werke</a>
                            </li> 
                            <li class="nav-item">
                                <a class="nav-link isDisabled" href="#">Orte</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link isDisabled" href="#">Institutionen</a>
                            </li>-->
                        </ul>
                        <a href="search.html">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-search">
                                <circle cx="11" cy="11" r="8"/>
                                <line x1="21" y1="21" x2="16.65" y2="16.65"/>
                            </svg>
                            SUCHE
                        </a>
                    </div>
                    <!-- .collapse navbar-collapse -->
                </div>
                <!-- .container -->
            </nav>
            <!-- .site-navigation -->
        </div>
    </xsl:template>
</xsl:stylesheet>