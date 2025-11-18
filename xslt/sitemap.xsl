<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="2.0">

    <xsl:include href="./partials/params.xsl"/>
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>

    <xsl:template match="/">
        <urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
            <!-- Hauptseiten -->
            <url>
                <loc><xsl:value-of select="$base_url"/>/index.html</loc>
                <changefreq>monthly</changefreq>
                <priority>1.0</priority>
            </url>
            <url>
                <loc><xsl:value-of select="$base_url"/>/toc.html</loc>
                <changefreq>monthly</changefreq>
                <priority>0.9</priority>
            </url>
            <url>
                <loc><xsl:value-of select="$base_url"/>/calendar.html</loc>
                <changefreq>monthly</changefreq>
                <priority>0.9</priority>
            </url>
            <url>
                <loc><xsl:value-of select="$base_url"/>/search.html</loc>
                <changefreq>monthly</changefreq>
                <priority>0.8</priority>
            </url>
            <url>
                <loc><xsl:value-of select="$base_url"/>/CP-aufsatz.html</loc>
                <changefreq>yearly</changefreq>
                <priority>0.7</priority>
            </url>
            <url>
                <loc><xsl:value-of select="$base_url"/>/bibliografie.html</loc>
                <changefreq>yearly</changefreq>
                <priority>0.7</priority>
            </url>
            <url>
                <loc><xsl:value-of select="$base_url"/>/listBibl.html</loc>
                <changefreq>yearly</changefreq>
                <priority>0.6</priority>
            </url>
            <url>
                <loc><xsl:value-of select="$base_url"/>/listplace.html</loc>
                <changefreq>yearly</changefreq>
                <priority>0.6</priority>
            </url>
            <url>
                <loc><xsl:value-of select="$base_url"/>/listperson.html</loc>
                <changefreq>yearly</changefreq>
                <priority>0.6</priority>
            </url>
            <url>
                <loc><xsl:value-of select="$base_url"/>/listorg.html</loc>
                <changefreq>yearly</changefreq>
                <priority>0.6</priority>
            </url>
            <url>
                <loc><xsl:value-of select="$base_url"/>/projekt.html</loc>
                <changefreq>yearly</changefreq>
                <priority>0.7</priority>
            </url>
            <url>
                <loc><xsl:value-of select="$base_url"/>/editionsprinzipien.html</loc>
                <changefreq>yearly</changefreq>
                <priority>0.6</priority>
            </url>
            <url>
                <loc><xsl:value-of select="$base_url"/>/mithilfe.html</loc>
                <changefreq>yearly</changefreq>
                <priority>0.6</priority>
            </url>
            <url>
                <loc><xsl:value-of select="$base_url"/>/zitat.html</loc>
                <changefreq>yearly</changefreq>
                <priority>0.5</priority>
            </url>
            <url>
                <loc><xsl:value-of select="$base_url"/>/ebook.html</loc>
                <changefreq>yearly</changefreq>
                <priority>0.6</priority>
            </url>
            <url>
                <loc><xsl:value-of select="$base_url"/>/imprint.html</loc>
                <changefreq>yearly</changefreq>
                <priority>0.3</priority>
            </url>

            <!-- Editions - dynamisch alle ckp*.xml Dateien -->
            <xsl:for-each select="collection('../data/editions?select=ckp*.xml')">
                <xsl:variable name="filename" select="replace(document-uri(.), '.*/(.*)\.xml$', '$1')"/>
                <url>
                    <loc><xsl:value-of select="concat($base_url, '/', $filename, '.html')"/></loc>
                    <changefreq>yearly</changefreq>
                    <priority>0.5</priority>
                </url>
            </xsl:for-each>
        </urlset>
    </xsl:template>
</xsl:stylesheet>
