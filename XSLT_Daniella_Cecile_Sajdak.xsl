<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs tei"
    version="2.0">
    <!-- On exclue les préfixes de la TEI -->
    
    <!-- Configurationd de l'output : format html, indentation automatique, encodage en UTF-8 -->
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    
    <!-- Pour éviter d'avoir des espaces parasites -->
    <xsl:strip-space elements="*"/>
    
    <!-- GESTION DES CHEMINS DES OUTPUTS -->
    
    <xsl:template match="/">
        <!-- Configuration des sorties dans les règles XSL : création d'une variable qui stocke le chemin du fichier courant -->
        <xsl:variable name="witfile">
            <xsl:value-of select="replace(base-uri(.), 'TEI_Daniella_Cecile_Sajdak.xml', '')"/>
        </xsl:variable>

        <!-- On créé une nouvelle variable pour chaque output html, pour stocker le chemin de chaque output (chemin défini à partir de la variable $witfile créée précédemment) -->
        
        <!-- Variable pour la page d'accueil-->
        <xsl:variable name="path_accueil">
            <xsl:value-of select="concat($witfile, 'html/accueil', '.html')"/>
        </xsl:variable>
        
        <!-- Variable pour la notice-->
        <xsl:variable name="path_meta">
            <xsl:value-of select="concat($witfile, 'html/meta', '.html')"/>
        </xsl:variable>
        
        <!-- Variable pour l'édition-->
        <xsl:variable name="path_edition">
            <xsl:value-of select="concat($witfile, 'html/edition', '.html')"/>
        </xsl:variable>

        <!-- Variable pour la liste des personnes-->
        <xsl:variable name="path_liste_pers">
            <xsl:value-of select="concat($witfile, 'html/liste_pers', '.html')"/>
        </xsl:variable>

        <!-- Variable pour la liste des lieux-->
        <xsl:variable name="path_liste_lieux">
            <xsl:value-of select="concat($witfile, 'html/liste_lieux', '.html')"/>
        </xsl:variable>


        <!-- CREATION DE VARIABLES REUTILISEES DANS LES DIFFERENTS OUTPUTS -->

        <!-- Création du head -->
        <xsl:variable name="head">
            <head>
                <title>                   
                    <!-- On créé le titre en récupérant le titre de l'oeuvre et le nom de l'autrice-->
                    <xsl:value-of
                        select="concat(TEI/teiHeader//sourceDesc//forename, ' ', TEI/teiHeader//sourceDesc//surname, ' : ', TEI/teiHeader//sourceDesc//titleStmt/title)"
                    />
                </title>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
                <meta name="author" content="Cécile Sajdak"/>
                <meta name="description"
                    content="Edition numérique de La Daniella de George Sand"/>
                <meta name="keywords" content="xml-tei, edition, La Daniella, George Sand, TEI, XML, roman_feuilleton"/>
                <!-- On fait appel à Bootstrap pour obtenir une mise en forme CSS simple -->
                <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"/>
                <link
                    href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css"
                    rel="stylesheet"
                    integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6"
                    crossorigin="anonymous"/>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"/>
            </head>
        </xsl:variable>

        <!-- Création de la barre de navigation -->
        <xsl:variable name="navigation">
            <nav class="navbar navbar-expand-md navbar-dark justify-content-between" style="background-color:  #900C3F;">
                <!-- On inclu un titre dans la barre de navigation -->
                <a class="navbar-brand" style="padding-left: 10px" href="{$path_accueil}">Edition numérique de <i><xsl:value-of
                    select="TEI/teiHeader//biblFull/titleStmt/title"/></i> de <xsl:value-of
                        select="TEI/teiHeader//biblFull/titleStmt/author//forename"/>&#160;<xsl:value-of
                            select="TEI/teiHeader//biblFull/titleStmt/author//surname"/>
                </a>
                
                <!-- On insère dans la barre de navigation un lien vers chaque output -->
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="{$path_meta}">Notice</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="{$path_edition}">Edition</a>
                    </li>
         
                    <li class="nav-item">
                        <a class="nav-link" href="{$path_liste_pers}">Liste des personnages</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="{$path_liste_lieux}">Liste des lieux</a>
                    </li>
                </ul>
            </nav>
        </xsl:variable>


        <!-- CREATION DES SORTIES HTML (une par page) -->

        <!-- Création de la page d'accueil.
            On fait appel au chemin de sortie défini plus haut grâce à @href
            On définit le format de sortie (html)
            On définit une indentation automatique-->
        <xsl:result-document href="{$path_accueil}" method="html" indent="yes">
            <html>
                <xsl:copy-of select="$head"/>
                <body>
                    <xsl:copy-of select="$navigation"/>

                    <div class="container">
                            <br/>
                            <h1>Bienvenue !</h1>
                            <br/>
                                <!-- On récupère les informations issues de l'encodingDesc, pour servir de présentation au projet-->
                                <xsl:value-of select="TEI/teiHeader//encodingDesc"/>                     
                    </div>
                </body>
            </html>
        </xsl:result-document>
        
        <!-- Création de la notice-->
        <xsl:result-document href="{$path_meta}" method="html" indent="yes">
            <html>
                <xsl:copy-of select="$head"/>
                <body>
                    <xsl:copy-of select="$navigation"/>
                    <div class="container">
                        <br/>
                        <h1>Notice de l'oeuvre</h1>
                        <br/>
                        <ul>
                            <!-- On récupère les différentes informations issues du teiHeader, en utilisant la fonction concat() lorsque l'on associe ensemble des informations récupérées, ou lorsqu'on y adjoint des caractères -->
                            <li>Titre : <xsl:value-of select="TEI//biblFull/titleStmt/title"/></li>
                            <li>Auteur.rice : <xsl:value-of
                                select="concat(TEI//biblFull/titleStmt//forename, ' ', //biblFull/titleStmt//surname)"
                            /></li>
                            <li>Date : <xsl:value-of select="TEI//biblFull//date"/></li>
                            <li>Journal : <xsl:value-of
                                select="concat(TEI//biblFull/publicationStmt/publisher, ' (', TEI//biblFull//street/num, ' ', TEI//biblFull//street/text(), TEI//biblFull//settlement, ', ',TEI//biblFull//postCode, ')')"
                            /></li>                           
                            <li>Numérisation : <a href="{TEI//biblFull//distributor/@facs}"
                                ><xsl:value-of select="TEI//biblFull//distributor"/></a></li>
                            <li>Licence : <a href="{TEI//biblFull//availability/licence/@target}"
                                ><xsl:value-of select="TEI//biblFull//availability/licence"/></a></li>
                            <br/>                           
                            <li>Episode : <xsl:value-of
                                select="TEI//biblFull/seriesStmt/biblScope[@unit = 'episode']"
                            /></li>
                            <li>Pages : <xsl:value-of
                                select="TEI//biblFull/seriesStmt/biblScope[@unit = 'page']"/></li>
                        </ul>
                    </div>
                    <div class="container">
                        <br/>
                        <h1>Encodage</h1>
                        <ul>
                            <li>Encodage par : <a href="https://github.com/SjdkC"><xsl:value-of
                                select="concat(TEI//fileDesc//respStmt//forename, ' ', TEI//fileDesc//respStmt//surname)"
                            /></a></li>
                            <li><xsl:value-of
                                select="TEI//fileDesc/publicationStmt"
                            /></li>
                        </ul>
                    </div>
                </body>
            </html>
        </xsl:result-document>
        
        
        <!-- Création de la page qui contient le texte édité-->
        <xsl:result-document href="{$path_edition}">
            <html>
                <xsl:copy-of select="$head"/>
                <body>
                    <xsl:copy-of select="$navigation"/>
                    <div class="container">
                        <xsl:element name="div">
                            <br/>
                            <!-- Grâce à l'apply template appliqué au body, on récupèrera les règles définies plus bas-->
                            <xsl:apply-templates select="TEI/text/body"/>
                        </xsl:element>        
                    </div>
                </body>
            </html>
        </xsl:result-document>

        <!-- Création de la page contenant la liste des personnages -->
        <xsl:result-document href="{$path_liste_pers}" method="html" indent="yes">
            <html>
                <xsl:copy-of select="$head"/>
                <body>
                    <xsl:copy-of select="$navigation"/>
                    <div class="container">
                        <br/>
                        <h1>Liste des personnages</h1>
                        <ul>
                            <!-- Le template @pers_liste, que l'on a créé plus bas, est appelé ici -->
                            <xsl:call-template name="pers_liste"/>
                        </ul>
                    </div>
                </body>
            </html>
        </xsl:result-document>

        <!-- Création de la page contenant la liste des lieux -->
        <xsl:result-document href="{$path_liste_lieux}" method="html" indent="yes">
            <html>
                <xsl:copy-of select="$head"/>
                <body>
                    <xsl:copy-of select="$navigation"/>
                    <div class="container">
                        <br/>
                        <h1>Liste des lieux</h1>
                        <ul>
                            <!-- Le template @lieux_liste, que l'on a créé plus bas, est appelé ici-->
                            <xsl:call-template name="lieux_liste"/>
                        </ul>
                    </div>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    
    <!-- REGLES POUR RECUPERER LE TEXTE DE L'EDITION -->
    <!-- Ces règles sont récupérées, pour la page contenant le texte, grâce à l'apply-template sur <body>-->
    
    <!-- Règle pour les <head> au sein des <div1> -->
    <xsl:template match="TEI/text/body/div1/head" mode="#all">
        <xsl:element name="h1">
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    
    <!-- Règle pour la <dateline> -->
    <xsl:template match="TEI/text/body//dateline">
        <xsl:element name="b">
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>
    
    <!-- Règle pour les <head> au sein des <div2> -->
    <xsl:template match="TEI/text/body/div1/div2/head">
        <xsl:element name="h2">
            <xsl:value-of select="."/>
        </xsl:element>
    </xsl:template>    
    
    <!-- Règle pour les <p> -->
    <xsl:template match="TEI/text/body//p">
        <xsl:element name="p">            
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <!-- Règle pour les <persName>-->
    <xsl:template match="TEI//persName">
        <!-- On stocke à nouveau les chemins de fichiers pour qu'ils puissent être utilisés ici -->
        <xsl:variable name="witfile">
            <xsl:value-of select="replace(base-uri(.), 'TEI_Daniella_Cecile_Sajdak.xml', '')"/>
        </xsl:variable>
        <xsl:variable name="path_liste_pers">
            <xsl:value-of select="concat($witfile, 'html/liste_pers', '.html')"/>
        </xsl:variable>
        <!-- Lorsqu'on rencontre un persName, on insère un lien vers la liste des personnages -->
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:value-of select="$path_liste_pers"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <!-- Règle pour les <placeName>-->
    <xsl:template match="TEI//placeName">
        <!-- On stocke à nouveau les chemins de fichiers pour qu'ils puissent être utilisés ici -->
        <xsl:variable name="witfile">
            <xsl:value-of select="replace(base-uri(.), 'TEI_Daniella_Cecile_Sajdak.xml', '')"/>
        </xsl:variable>
        <xsl:variable name="path_liste_lieux">
            <xsl:value-of select="concat($witfile, 'html/liste_lieux', '.html')"/>
        </xsl:variable>
        <!-- Lorsqu'on rencontre un placeName, on insère un lien vers la liste des lieux-->
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:value-of select="$path_liste_lieux"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>  
    
    <!-- Règle pour les <lb/> : on restitue les sauts de ligne
    originaux (afin que les tirets de sauts de ligne
    de l'édition TEI aient un sens). Dans un projet idéal, il aurait peut-être fallu faire un choix différent concernant les tirets, au moment de la transcription-->
    <xsl:template match="TEI/text/body//p//lb">
        <xsl:element name="br">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <!-- Règle pour les <sic> : afficher la version fautive entre parenthèses, avec la mention "sic"-->
    <xsl:template match="TEI/text/body//sic">
        <xsl:element name="small">
            (sic : <xsl:apply-templates/>)
        </xsl:element>
    </xsl:template>    
    
    <!-- Règle pour les <hi> porteurs d'un @rend de valeur 'italic' : avoir un rendu en italique -->
    <xsl:template match="hi[@rend = 'italic']">
        <xsl:element name="i">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <!-- Règle pour les <emph> porteurs d'un @rend de valeur 'italic' : avoir un affichage en italique, mais cette fois si avec <em> (même rendu visuel, mais on respecte ici la valeur sémantique portée par <emph>) -->
    <xsl:template match="emph[@rend = 'italic']">
        <xsl:element name="em">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    

    <!-- CREATION DES TEMPLATES appelés dans les différentes pages -->

    <!-- Création du template pour la liste des personnages -->
    
    <xsl:template name="pers_liste" match="TEI/teiHeader//listPerson">
        <!-- La page est divisée en trois parties : une pour les personnages, une pour les groupes de personnages, une pour les personnes réelles citées dans le roman-feuilleton-->
        <br/>
        <h2>Personnages</h2>
        <br/>
        <!-- On créé une mise en page qui permettra la récupération d'un certain nombre d'informations. La boucle for-each permettra d'obtenir ces informations pour chaque personnage. -->
        <xsl:for-each select="//person[@role='character']">
            <!-- On ordonne les personnages par ordre alphabétique de leur <persName> -->
            <xsl:sort select="persName" order="ascending"/>
            <li>
                <b><xsl:value-of select="persName"/></b>
                <xsl:choose>
                    <!-- On affiche des symboles pour représenter le genre des personnages-->
                    <xsl:when test="@sex='male'">
                        (♂)
                    </xsl:when>
                    <xsl:when test="@sex='female'">
                        (♀)
                    </xsl:when>
                </xsl:choose>
                <xsl:choose>
                    <!-- On affiche une note s'il en existe une-->
                    <xsl:when test="note">
                        <xsl:value-of select="concat(' : ', note)"/>
                    </xsl:when>
                    <!-- sinon, on insère un point-->
                    <xsl:otherwise>.</xsl:otherwise>
                </xsl:choose>
            </li>
        </xsl:for-each>                        
        
        <!-- Même principe pour les groupes de personnages -->
        <br/>
        <h2>Groupes de personnages</h2>
        <br/>
        <xsl:for-each select="//personGrp">
            <xsl:sort select="persName" order="ascending"/>
            <li>
                <b><xsl:value-of select="name"/></b>
            <xsl:choose>
                <xsl:when test="@sex='male'">
                    (♂)
                </xsl:when>
                <xsl:when test="@sex='female'">
                    (♀)
                </xsl:when>
                <xsl:when test="@sex='mixed'">
                    (♀♂)
                </xsl:when>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="note">
                    <xsl:value-of select="concat(' : ', note)"/>
                </xsl:when>
                <xsl:otherwise>.</xsl:otherwise>
            </xsl:choose>
            </li>
        </xsl:for-each>
        
        <!-- Enfin, même principe pour les personnes réelles-->
        <br/>
        <h2>Personnes réelles</h2>
        <br/>
        <xsl:for-each select="//person[@role='real_person']">
            <xsl:sort select="persName" order="ascending"/>
            <li>
                <b><xsl:value-of select="persName"/></b>
                <xsl:choose>
                    <xsl:when test="@sex='male'">
                        (♂)
                    </xsl:when>
                    <xsl:when test="@sex='female'">
                        (♀)
                    </xsl:when>
                </xsl:choose>
                <xsl:choose>
                    <xsl:when test="note">
                        <xsl:value-of select="concat(' : ', note)"/>
                    </xsl:when>
                    <xsl:otherwise>.</xsl:otherwise>
                </xsl:choose>
            </li>
        </xsl:for-each>        
    </xsl:template>       

    <!-- Création du template pour la liste des lieux -->
    
    <xsl:template name="lieux_liste">
        <!-- Ici aussi, on créé une mise en page associée à des informations pour chaque lieu, grâce à la boucle for-each. -->
        <xsl:for-each select="TEI/teiHeader//listPlace/place">
            <!-- On trie les lieux par ordre alphabétique-->
            <xsl:sort select=".//name"/>
            <li>
                <b><xsl:value-of select="placeName/name"/></b>
                <ul>
                        <!-- On récupère la note s'il y en a une-->
                        <xsl:if test="note">
                            <li>
                                <xsl:value-of select="note"/>
                            </li>
                        </xsl:if>
                    <!-- On récupère la typologie du lieu-->
                    <li>
                        <xsl:value-of select="concat('Type de lieu : ', @type)"/>          
                    </li>
                    <!-- On récupère le code postal s'il y en a un-->
                        <xsl:if test="placeName/address/postCode != 'none'">
                            <li>
                                <xsl:value-of select="concat('Code postal : ', placeName//address/postCode)"/>
                            </li>
                        </xsl:if>
                    <!-- On récupère l'appartenance à un découpage géographique (<district>) s'il y en a un-->
                    <xsl:if test="placeName/address/district != 'none'">
                        <li>
                            <xsl:value-of select="concat('Appartient à : ', placeName//address/district)"/>
                        </li>
                    </xsl:if>
                    <!-- On récupère la rue s'il y en a une-->
                    <xsl:if test="placeName/address/street != 'none'">
                        <li>
                            <xsl:value-of select="concat('Rue : ', placeName//address/street)"/>
                        </li>
                    </xsl:if>  
                </ul>               
            </li>
        </xsl:for-each>
    </xsl:template>
    
</xsl:stylesheet>