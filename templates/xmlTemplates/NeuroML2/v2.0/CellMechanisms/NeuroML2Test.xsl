<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:cml="http://www.neuroml.org/schema/neuroml2"
    xmlns:meta="http://morphml.org/metadata/schema">

    <xsl:import href="../ReadableUtils.xsl"/>

<!--
    
    This file is used to convert NeuroML2 files to a "neuroscientist friendly" HTML view.
    
    Author: Rokas Stanislovas
      
-->

<xsl:output method="html" indent="yes" />


<!--Main template-->

<xsl:template match="/cml:neuroml">

<xsl:if test="count(/cml:neuroml/cml:notes) &gt; 0">
<table frame="box" rules="all" align="centre" cellpadding="4" width ="100%">
    <xsl:call-template name="tableRow">
        <xsl:with-param name="name">General notes</xsl:with-param>
        <xsl:with-param name="comment">Notes present in NeuroML2 file</xsl:with-param>
        <xsl:with-param name="value">&lt;b&gt;<xsl:value-of select="/cml:neuroml/cml:notes"/>&lt;/b&gt;</xsl:with-param>
     </xsl:call-template>
</table>
</xsl:if>

<br/>



<xsl:apply-templates  select="cml:ionChannel"/>

<xsl:apply-templates select="cml:expTwoSynapse"/>

<xsl:apply-templates  select="cml:ComponentType"/>

</xsl:template>
<!--End Main template-->

<xsl:template match="cml:ionChannel">
<h3>Channel: <xsl:value-of select="@id"/></h3>


<table frame="box" rules="all" align="centre" cellpadding="4" width ="100%">
<xsl:call-template name="tableRow">
        <xsl:with-param name="name">Channel id</xsl:with-param>
        <xsl:with-param name="value">&lt;b&gt;<xsl:value-of select="@id"/>&lt;/b&gt;</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tableRow">
        <xsl:with-param name="name"> Max conductance</xsl:with-param>
        <xsl:with-param name="value">&lt;b&gt;<xsl:value-of select="@conductance"/>&lt;/b&gt;</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tableRow">
        <xsl:with-param name="name"> NeuroML2 component type</xsl:with-param>
        <xsl:with-param name="value">&lt;b&gt;<xsl:value-of select="@type"/>&lt;/b&gt;</xsl:with-param>
</xsl:call-template>

<xsl:if test="count(cml:notes) &gt; 0">
<xsl:call-template name="tableRow">
        <xsl:with-param name="name">Description</xsl:with-param>
        <xsl:with-param name="comment">Notes specific to the stored ion channel component</xsl:with-param>
        <xsl:with-param name="value">&lt;b&gt;<xsl:value-of select="cml:notes"/>&lt;/b&gt;</xsl:with-param>
</xsl:call-template>
</xsl:if>

<xsl:if test="count(cml:annotation) &gt; 0">
<xsl:call-template name="tableRow">
        <xsl:with-param name="name">Annotation</xsl:with-param>
        <xsl:with-param name="value">&lt;b&gt;<xsl:value-of select="cml:annotation"/>&lt;/b&gt;</xsl:with-param>
</xsl:call-template>
</xsl:if>

<xsl:if test="count(cml:gate) &gt; 0">
  <xsl:for-each select="cml:gate">
   
    <xsl:call-template name="tableRow">
        <xsl:with-param name="name">Gate id:&lt;b&gt;<xsl:value-of select="@id"/>&lt;/b&gt;</xsl:with-param>
        <xsl:with-param name="comment">Information on the channel gate <xsl:value-of select="@id"/></xsl:with-param>
    </xsl:call-template>
    
    <xsl:call-template name="tableRow">
        <xsl:with-param name="name">Number of instances of gating elements</xsl:with-param>
        <xsl:with-param name="value">&lt;b&gt;<xsl:value-of select="@instances"/>&lt;/b&gt;</xsl:with-param>
    </xsl:call-template>
    
    <xsl:call-template name="tableRow">
        <xsl:with-param name="name">NeuroML2 rate type</xsl:with-param>
        <xsl:with-param name="value">&lt;b&gt;<xsl:value-of select="@type"/>&lt;/b&gt;</xsl:with-param>
    </xsl:call-template>
    
    <xsl:if test="count(cml:forwardRate) &gt; 0">
       <xsl:for-each select="cml:forwardRate">
       
          <xsl:call-template name="tableRow">
             <xsl:with-param name="name">Information on the forward rate:</xsl:with-param>
          </xsl:call-template>
          
          <xsl:call-template name="tableRow">
             <xsl:with-param name="name">NeuroML2 component type</xsl:with-param>
             <xsl:with-param name="value">&lt;b&gt;<xsl:value-of select="@type"/>&lt;/b&gt;</xsl:with-param>
          </xsl:call-template>
          
          <xsl:if test="count(@rate) &gt; 0"> 
            <xsl:call-template name="tableRow">
               <xsl:with-param name="name">Rate</xsl:with-param>
               <xsl:with-param name="value">&lt;b&gt;<xsl:value-of select="@rate"/>&lt;/b&gt;</xsl:with-param>
            </xsl:call-template>
          
            <xsl:call-template name="tableRow">
               <xsl:with-param name="name">Scale</xsl:with-param>
               <xsl:with-param name="value">&lt;b&gt;<xsl:value-of select="@scale"/>&lt;/b&gt;</xsl:with-param>
            </xsl:call-template>
          
            <xsl:call-template name="tableRow">
               <xsl:with-param name="name">Midpoint</xsl:with-param>
               <xsl:with-param name="value">&lt;b&gt;<xsl:value-of select="@midpoint"/>&lt;/b&gt;</xsl:with-param>
            </xsl:call-template>
          </xsl:if>  
          
       </xsl:for-each>
    </xsl:if>
    
    <xsl:if test="count(cml:reverseRate) &gt; 0">
       <xsl:for-each select="cml:reverseRate">
       
          <xsl:call-template name="tableRow">
             <xsl:with-param name="name">Information on the reverse rate:</xsl:with-param>
          </xsl:call-template>
          
          <xsl:call-template name="tableRow">
             <xsl:with-param name="name">NeuroML2 component type</xsl:with-param>
             <xsl:with-param name="value">&lt;b&gt;<xsl:value-of select="@type"/>&lt;/b&gt;</xsl:with-param>
          </xsl:call-template>
          
          <xsl:if test="count(@rate) &gt; 0"> 
            <xsl:call-template name="tableRow">
               <xsl:with-param name="name">Rate</xsl:with-param>
               <xsl:with-param name="value">&lt;b&gt;<xsl:value-of select="@rate"/>&lt;/b&gt;</xsl:with-param>
            </xsl:call-template>
          
            <xsl:call-template name="tableRow">
               <xsl:with-param name="name">Scale</xsl:with-param>
               <xsl:with-param name="value">&lt;b&gt;<xsl:value-of select="@scale"/>&lt;/b&gt;</xsl:with-param>
            </xsl:call-template>
          
            <xsl:call-template name="tableRow">
               <xsl:with-param name="name">Midpoint</xsl:with-param>
               <xsl:with-param name="value">&lt;b&gt;<xsl:value-of select="@midpoint"/>&lt;/b&gt;</xsl:with-param>
            </xsl:call-template>
          </xsl:if>  
          
       </xsl:for-each>
    </xsl:if>
   
  </xsl:for-each>
</xsl:if>

</table>
<br/>
</xsl:template>

<xsl:template match="cml:expTwoSynapse">
<h3>Double exponential synapse: <xsl:value-of select="@id"/></h3>


<table frame="box" rules="all" align="centre" cellpadding="4" width ="100%">

<xsl:call-template name="tableRow">
        <xsl:with-param name="name">Synapse id</xsl:with-param>
        <xsl:with-param name="value">&lt;b&gt;<xsl:value-of select="@id"/>&lt;/b&gt;</xsl:with-param>
</xsl:call-template>

<xsl:if test="count(cml:notes) &gt; 0">
<xsl:call-template name="tableRow">
        <xsl:with-param name="name">Description</xsl:with-param>
        <xsl:with-param name="comment">Notes specific to the synapse component</xsl:with-param>
        <xsl:with-param name="value">&lt;b&gt;<xsl:value-of select="cml:notes"/>&lt;/b&gt;</xsl:with-param>
</xsl:call-template>
</xsl:if>

<xsl:call-template name="tableRow">
        <xsl:with-param name="name"> Rise time constant</xsl:with-param>
        <xsl:with-param name="value">&lt;b&gt;<xsl:value-of select="@tauRise"/>&lt;/b&gt;</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tableRow">
        <xsl:with-param name="name"> Decay time constant</xsl:with-param>
        <xsl:with-param name="value">&lt;b&gt;<xsl:value-of select="@tauDecay"/>&lt;/b&gt;</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tableRow">
        <xsl:with-param name="name"> Base conductance</xsl:with-param>
        <xsl:with-param name="value">&lt;b&gt;<xsl:value-of select="@gbase"/>&lt;/b&gt;</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tableRow">
        <xsl:with-param name="name">Reversal potential</xsl:with-param>
        <xsl:with-param name="value">&lt;b&gt;<xsl:value-of select="@erev"/>&lt;/b&gt;</xsl:with-param>
</xsl:call-template>

<xsl:if test="count(cml:annotation) &gt; 0">
<xsl:call-template name="tableRow">
        <xsl:with-param name="name">Annotation</xsl:with-param>
        <xsl:with-param name="value">&lt;b&gt;<xsl:value-of select="cml:annotation"/>&lt;/b&gt;</xsl:with-param>
</xsl:call-template>
</xsl:if>

</table>
<br/>
</xsl:template>


<xsl:template match="cml:ComponentType">
<table frame="box" rules="all" align="centre" cellpadding="4" width ="100%">
<xsl:call-template name="tableRow">
        <xsl:with-param name="name">Custom NeuroML2 component type:&lt;b&gt;<xsl:value-of select="@name"/>&lt;/b&gt;</xsl:with-param>
</xsl:call-template>

<xsl:call-template name="tableRow">
        <xsl:with-param name="name"> Base component type</xsl:with-param>
        <xsl:with-param name="value">&lt;b&gt;<xsl:value-of select="@extends"/>&lt;/b&gt;</xsl:with-param>
</xsl:call-template>

<xsl:if test="count(cml:notes) &gt; 0">
<xsl:call-template name="tableRow">
        <xsl:with-param name="name">Description</xsl:with-param>
        <xsl:with-param name="comment">Notes specific to the stored component type</xsl:with-param>
        <xsl:with-param name="value">&lt;b&gt;<xsl:value-of select="cml:notes"/>&lt;/b&gt;</xsl:with-param>
</xsl:call-template>
</xsl:if>


    
<xsl:if test="count(cml:Constant) &gt; 0">
   <xsl:for-each select="cml:Constant">
       
          <xsl:call-template name="tableRow">
             <xsl:with-param name="name">Information on constant:&lt;b&gt;<xsl:value-of select="@name"/>&lt;/b&gt;</xsl:with-param>
          </xsl:call-template>
          
          <xsl:call-template name="tableRow">
             <xsl:with-param name="name">Dimension</xsl:with-param>
             <xsl:with-param name="value">&lt;b&gt;<xsl:value-of select="@dimension"/>&lt;/b&gt;</xsl:with-param>
          </xsl:call-template>
          
          <xsl:call-template name="tableRow">
             <xsl:with-param name="name">Value</xsl:with-param>
             <xsl:with-param name="value">&lt;b&gt;<xsl:value-of select="@value"/>&lt;/b&gt;</xsl:with-param>
          </xsl:call-template>
          
          
   </xsl:for-each>
</xsl:if>
    
<xsl:if test="count(cml:Dynamics) &gt; 0">
    <xsl:for-each select="cml:Dynamics">
       
       <xsl:call-template name="tableRow">
         <xsl:with-param name="name">Parameters below define the NeuroML2 dynamics element:</xsl:with-param>
       </xsl:call-template>
          
       <xsl:if test="count(cml:DerivedVariable) &gt; 0"> 
          <xsl:for-each select="cml:DerivedVariable">
             
                <xsl:call-template name="tableRow">
                   <xsl:with-param name="name">Name of the derived parameter</xsl:with-param>
                   <xsl:with-param name="value">&lt;b&gt;<xsl:value-of select="@name"/>&lt;/b&gt;</xsl:with-param>
                </xsl:call-template>
          
                <xsl:call-template name="tableRow">
                   <xsl:with-param name="name">Dimension</xsl:with-param>
                   <xsl:with-param name="value">&lt;b&gt;<xsl:value-of select="@dimension"/>&lt;/b&gt;</xsl:with-param>
                </xsl:call-template>
          
                <xsl:call-template name="tableRow">
                  <xsl:with-param name="name">Value</xsl:with-param>
                  <xsl:with-param name="value">&lt;b&gt;<xsl:value-of select="@value"/>&lt;/b&gt;</xsl:with-param>
                </xsl:call-template>
                
                <xsl:if test="count(@exposure) &gt; 0">
                   <xsl:call-template name="tableRow">
                     <xsl:with-param name="name">Exposure</xsl:with-param>
                     <xsl:with-param name="value">&lt;b&gt;<xsl:value-of select="@exposure"/>&lt;/b&gt;</xsl:with-param>
                   </xsl:call-template>
                </xsl:if> 
                
          </xsl:for-each>
       </xsl:if>  
          
    </xsl:for-each>
</xsl:if>

</table>
<br/>
<br/>
</xsl:template>

</xsl:stylesheet>
