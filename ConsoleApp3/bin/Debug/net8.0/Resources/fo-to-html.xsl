<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <xsl:output method="html" indent="yes"/>

  <!-- Match the root of the FO document -->
  <xsl:template match="/fo:root">
    <html lang="en">
      <head>
        <title>Converted FO to HTML</title>
        <style>
          table { border-collapse: collapse; width: 100%; }
          td, th { border: 1px solid #ccc; padding: 4px; }
        </style>
      </head>
      <body>
        <xsl:apply-templates select=".//fo:flow"/>
      </body>
    </html>
  </xsl:template>

  <!-- Map fo:block to p -->
  <xsl:template match="fo:block">
    <p>
      <xsl:attribute name="style">
        <xsl:if test="@font-weight">font-weight: <xsl:value-of select="@font-weight"/>;</xsl:if>
        <xsl:if test="@font-size">font-size: <xsl:value-of select="@font-size"/>;</xsl:if>
        <xsl:if test="@color">color: <xsl:value-of select="@color"/>;</xsl:if>
        <xsl:if test="@text-align">text-align: <xsl:value-of select="@text-align"/>;</xsl:if>
        <xsl:if test="@background-color">background-color: <xsl:value-of select="@background-color"/>;</xsl:if>
      </xsl:attribute>
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <!-- Map fo:inline to span -->
  <xsl:template match="fo:inline">
    <span>
      <xsl:attribute name="style">
        <xsl:if test="@font-weight">font-weight: <xsl:value-of select="@font-weight"/>;</xsl:if>
        <xsl:if test="@font-size">font-size: <xsl:value-of select="@font-size"/>;</xsl:if>
        <xsl:if test="@color">color: <xsl:value-of select="@color"/>;</xsl:if>
        <xsl:if test="@text-decoration">text-decoration: <xsl:value-of select="@text-decoration"/>;</xsl:if>
      </xsl:attribute>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!-- Map fo:table -->
  <xsl:template match="fo:table">
    <table>
      <xsl:apply-templates/>
    </table>
  </xsl:template>

  <xsl:template match="fo:table-header">
    <thead><xsl:apply-templates/></thead>
  </xsl:template>

  <xsl:template match="fo:table-body">
    <tbody><xsl:apply-templates/></tbody>
  </xsl:template>

  <xsl:template match="fo:table-row">
    <tr><xsl:apply-templates/></tr>
  </xsl:template>

  <xsl:template match="fo:table-cell">
    <td>
      <xsl:attribute name="style">
        <xsl:if test="@text-align">text-align: <xsl:value-of select="@text-align"/>;</xsl:if>
        <xsl:if test="@background-color">background-color: <xsl:value-of select="@background-color"/>;</xsl:if>
      </xsl:attribute>
      <xsl:apply-templates/>
    </td>
  </xsl:template>

  <!-- Fallback: pass through unknown elements -->
  <xsl:template match="*">
    <xsl:apply-templates/>
  </xsl:template>

</xsl:stylesheet>
