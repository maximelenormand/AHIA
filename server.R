# Import libraries
library(shiny)
library(leaflet)
library(rgdal)
library(fmsb)
library(scales)

# Load data
load(file = "Network.RData")
load(file = "Spatial.RData")
load(file = "Temporal.RData")
load(file = "Interactions.RData")

# Server
shinyServer(function(input, output, session) {
  
  ##### Network #####################################################################################

  # A reactive expression that returns the network attributes
  net=reactive({
    
    #Case study
    if(input$CSnet==0){
      fromi=from
      toi=to
      linki=link
    }else{
      toi=to[to[,1]==input$CSnet,]
      ind=link@data[,2]==input$CSnet
      fromi=as.numeric(link@data[ind,1])
      fromi=from[match(fromi,from[,1]),]
      linki=link[ind,]
    }
    
    #Filter link according to the number of users
    ind=linki@data[,3]>=input$W
    fromi=fromi[match(as.numeric(linki@data[ind,1]),fromi[,1]),]
    linki=linki[ind,]
    
    net=list(toi=toi,fromi=fromi,linki=linki)
    
  })
  
  # Create the base map
  output$mapnet=renderLeaflet({

    leaflet() %>%
      addTiles() %>%
      fitBounds(-8.865578,29.048034,29.334944,66.491464)  #%>%

  })

  # Update map according to the inputs value
  observe({

    net=net()
    toi=net$toi
    fromi=net$fromi
    linki=net$linki

    leafletProxy("mapnet") %>%
      clearShapes() %>%
      clearMarkers() %>%
      addPolylines(data = linki, color = "green", opacity = 0.3, weight = 1.5, stroke=T) %>%
      addCircleMarkers(lng = fromi[,2], lat=fromi[,3], radius=6, stroke=FALSE,
                       color = "steelblue", opacity = 0.75, fill = TRUE, fillOpacity = 0.75) %>%
      addCircleMarkers(lng = toi[,3], lat=toi[,4], popup=toi[,2], radius=10, stroke=FALSE,
                       color = "#CC6666", opacity = 0.75, fill = TRUE, fillOpacity = 0.75)


  })
  
  # Reset view button
  observe({

    input$reset_button_net

    leafletProxy("mapnet") %>%
      fitBounds(-8.865578,29.048034,29.334944,66.491464)

  })
  
  # Default values button
  observe({
    
    input$default_values_net
    
    updateSelectInput(session, "CSnet", selected = 0)
    updateNumericInput(session, "W", value = 1)
    
    leafletProxy("mapnet") %>%
      fitBounds(-8.865578,29.048034,29.334944,66.491464)
    
    
    
  })
  
  
  ##### Spatial distribution ##########################################################################
  
  # Reactive expressions that return the shapefiles
  # shpi: case study boundaries
  # csid: id case study
  # shpi4: initial distribution (resolution 2000m and all users)
  # shpij: update distribution
  shpi=reactive({
    
    #Case study
    shpi=shp[shp@data[,2]==as.numeric(input$CSsp) & shp@data[,3]==0,]
    shpi
    
  })
  
  csid=reactive({
    
    #Case study
    csid=shp[shp@data[,2]==as.numeric(input$CSsp) & shp@data[,3]==0,]
    csid=as.character(csid@data[1,1])
    csid=paste("./3D/", csid, "/", csid, "_3D.html", sep="")
    csid
    
  })
  
  shpi4=reactive({
    
    #Case study & scale 200m
    shpi4=shp[shp@data[,2]==as.numeric(input$CSsp) & shp@data[,3]==4,]
    shpi4
    
  })
  
  shpij=reactive({
    
    #Case study & scale
    shpij=shp[shp@data[,2]==as.numeric(input$CSsp) & shp@data[,3]==as.numeric(input$l),]
    
    #Type users
    if(input$typesp==2){
      shpij=shpij[shpij@data[,5]>0,]
    }
    if(input$typesp==3){
      shpij=shpij[shpij@data[,6]>0,]
    } 
    
    shpij
    
  })
  
  #Layer ID to remove (from 1 to the maximal number of cells)
  layeridtoremove=reactive({
    as.character(1:max(table(shp@data[,2])))
  })
  
  # Reset inputs when changing case study
  # observe({
  #   
  #     input$CSsp
  #     
  #     updateNumericInput(session, "l", value = 4)
  #     updateNumericInput(session, "typesp", value = 1)
  #     #updateCheckboxInput(session, "heatmap", value=FALSE)
  # 
  # })
  
  # Create the base map
  output$mapsp=renderLeaflet({
    
    # Import shps
    shpi=shpi()
    shpi4=shpi4()
    
    # Popup
    popupi4=paste0("<span style='color: #7f0000'><strong>#Interactions </strong></span>",
                   shpi4@data$NbInt, 
                   "<br><span style='color: salmon;'><strong>#Locals </strong></span>", 
                   shpi4@data$NbIntLocal,
                   "<br><span style='color: salmon;'><strong>#Visitors </strong></span>", 
                   shpi4@data$NbIntVisitor 
    )
    
    # Bounds
    minlon=bbox(shpi)[1,1]
    minlat=bbox(shpi)[2,1]
    maxlon=bbox(shpi)[1,2]
    maxlat=bbox(shpi)[2,2]
    
    # Map
    leaflet() %>%
      addTiles() %>%
      fitBounds(minlon,minlat,maxlon,maxlat) %>%
      addPolygons(data=shpi, color = "black", weight = 2, smoothFactor = 0.5,
                opacity = 1.0, fillOpacity = 0, fillColor = "black") %>%
      addPolygons(layerId=as.character(1:dim(shpi4)[1]), data=shpi4, color = "black", weight = 2, smoothFactor = 0.5,
                opacity = 1.0, fillOpacity = 0.1, fillColor = "blue", popup=popupi4, 
                highlightOptions = highlightOptions(color = "white", weight = 2,bringToFront = TRUE))

  })

  # Update map according to the inputs value
  observe({
    
    # Import shps
    shpij=shpij()
    
    # Popup
    popupij=paste0("<span style='color: #7f0000'><strong>#Interactions </strong></span>",
                   shpij@data$NbInt, 
                   "<br><span style='color: salmon;'><strong>#Locals </strong></span>", 
                   shpij@data$NbIntLocal,
                   "<br><span style='color: salmon;'><strong>#Visitors </strong></span>", 
                   shpij@data$NbIntVisitor 
    )
    
    # If not heatmap
    if(!input$heatmap){
      
      # Map
      leafletProxy("mapsp") %>%
        removeShape(layerId=layeridtoremove()) %>%
        clearMarkers() %>%
        clearControls() %>%
        addTiles() %>%
        addPolygons(layerId=as.character(1:dim(shpij)[1]), data=shpij, color = "black", weight = 2, smoothFactor = 0.5,
                    opacity = 1.0, fillOpacity = 0.1, fillColor = "blue", popup=popupij,                  
                    highlightOptions = highlightOptions(color = "white", weight = 2,bringToFront = TRUE))
    # If heatmap
    }else{
      
      # Set categories and colors according to the inputs  
      if(input$typesp<4){
        
        cololeg=c('#fcbba1','#fc9272','#fb6a4a','#ef3b2c','#cb181d','#a50f15','#67000d')
        
        nb=shpij@data[,(3+as.numeric(input$typesp))]
        nbc=as.numeric(as.character(cut(nb,breaks=length(cololeg),labels=1:length(cololeg))))
        colo=cololeg[nbc]
        
        minleg=min(nb)
        maxleg=max(nb)
      
        titleg="#Interactions"
        if(input$typesp==2){
          titleg="#Locals"
        }
        if(input$typesp==3){
          titleg="#Visitors"
        }
        
      }else{

        cololeg=colorRampPalette(c('dark red','white','dark blue'))(7)
                
        nb=round(100*shpij@data$NbIntLocal/shpij@data$NbInt, digits=2)
        nbc=as.numeric(as.character(cut(nb,breaks=length(cololeg),labels=1:length(cololeg))))
        colo=cololeg[nbc]
        
        minleg=min(nb)
        maxleg=max(nb)
      
        titleg="%Locals/All"
      } 
      
      # Heatmap
      leafletProxy("mapsp") %>%
        removeShape(layerId=layeridtoremove()) %>%
        clearMarkers() %>%
        clearControls() %>%
        clearTiles() %>%
        addProviderTiles(providers$CartoDB.Positron) %>%
        addPolygons(layerId=as.character(1:dim(shpij)[1]), data=shpij, color = colo, weight = 2, smoothFactor = 0.5,
                    opacity = 0, fillOpacity = 0.5, fillColor = colo, popup=popupij) %>%
        addLegend(position = 'bottomleft', ## choose bottomleft, bottomright, topleft or topright
                  colors = rev(cololeg), 
                  labels = c(maxleg,"","","","","",minleg),  ## legend labels (only min and max)
                  opacity = 0.6,      ##transparency 
                  title = titleg)   ## title of the legend
      
    }
    
  })
  
  
  # Histogram number of interactions
  output$hist <- renderPlot({
    
    shpij=shpij()
    
    if(input$typesp==1){
      x=shpij@data[shpij@data[,3]!=0,]$NbInt
      par(mar=c(5,5,1,1))
      hist(x, breaks=10, col="steelblue3", border="white", axes=FALSE, main="", xlab="", ylab="")
      axis(1, cex.axis=1.25)
      axis(2, las=2, cex.axis=1.25)
      mtext("#Interactions", 1, line=3.5, cex=1.5)
      mtext("Frequence", 2, line=3.5, cex=1.5)
    }
    
    if(input$typesp==2){
      x=shpij@data[shpij@data[,3]!=0,]$NbIntLocal
      par(mar=c(5,5,1,1))
      hist(x, breaks=10, col="steelblue3", border="white", axes=FALSE, main="", xlab="", ylab="")
      axis(1, cex.axis=1.25)
      axis(2, las=2, cex.axis=1.25)
      mtext("#Locals", 1, line=3.5, cex=1.5)
      mtext("Frequence", 2, line=3.5, cex=1.5)     
    }
    
    if(input$typesp==3){
      x=shpij@data[shpij@data[,3]!=0,]$NbIntVisitor
      par(mar=c(5,5,1,1))
      hist(x, breaks=10, col="steelblue3", border="white", axes=FALSE, main="", xlab="", ylab="")
      axis(1, cex.axis=1.25)
      axis(2, las=2, cex.axis=1.25)
      mtext("#Visitors", 1, line=3.5, cex=1.5)
      mtext("Frequence", 2, line=3.5, cex=1.5)       
    }
    
    if(input$typesp==4){
      x=round(100*shpij@data$NbIntLocal/shpij@data$NbInt, digits=2)
      par(mar=c(5,5,1,1))
      hist(x, breaks=10, col="steelblue3", border="white", axes=FALSE, main="", xlab="", ylab="")
      axis(1, cex.axis=1.25)
      axis(2, las=2, cex.axis=1.25)
      mtext("%Locals/All", 1, line=3.5, cex=1.5)
      mtext("Frequence", 2, line=3.5, cex=1.5)       
    }

  })
  
  # Reset view button
  observe({
    
    if(input$reset_button_sp){
    
      shpi=shpi()
      
      # Bounds
      minlon=bbox(shpi)[1,1]
      minlat=bbox(shpi)[2,1]
      maxlon=bbox(shpi)[1,2]
      maxlat=bbox(shpi)[2,2]
      
      # Map
      leafletProxy("mapsp") %>%
        fitBounds(minlon,minlat,maxlon,maxlat)
      
    }
    
  })
  
  # Default values button
  observe({
    
    if(input$default_values_sp){
    
      updateSelectInput(session, "CSsp", selected = 1)
      updateNumericInput(session, "l", value = 4)
      updateNumericInput(session, "typesp", value = 1)
      updateCheckboxInput(session, "heatmap", value=FALSE)
      
      # Map
      leafletProxy("mapsp") %>%
        fitBounds(1.360428,41.192649,2.778114,42.323340)
    }
    
  })
  
  # 3D button
  onclick("tdexplorer", runjs(paste("window.open(", "'", csid(), "'", ",'_blank'",")", sep="")))
  
  ##### Temporal distribution ##########################################################################
  
  # A reactive expression that returns the temporal distribution according to the inputs
  vartemp=reactive({
    
    # Time windows
    if(input$dt==1){
      vartemp_local=hl
      vartemp_visitor=hv
    }else{
      vartemp_local=ml
      vartemp_visitor=mv
    }
    
    # Case study
    if(input$CStemp==0){
      vartemp_local=apply(vartemp_local,2,sum)
      vartemp_visitor=apply(vartemp_visitor,2,sum)
      vartemp_all=vartemp_local+vartemp_visitor      
    }else{
      vartemp_local=vartemp_local[as.numeric(input$CStemp),]
      vartemp_visitor=vartemp_visitor[as.numeric(input$CStemp),]
      vartemp_all=vartemp_local+vartemp_visitor  
    }
    
    vartemp_local=vartemp_local/sum(vartemp_local)
    vartemp_visitor=vartemp_visitor/sum(vartemp_visitor)
    vartemp_all=vartemp_all/sum(vartemp_all)
    
    vartemp=list(vartemp_local=vartemp_local,vartemp_visitor=vartemp_visitor,vartemp_all=vartemp_all)
    
  })
  
  # Plot
  output$plotemp <- renderPlot({
    
    vartemp=vartemp()
    
    vartemp_local=vartemp$vartemp_local
    vartemp_visitor=vartemp$vartemp_visitor
    vartemp_all=vartemp$vartemp_all
    
    catnames=0:23
    lab="Hours"
    if(input$dt==2){
      catnames=1:12
      lab="Months"
    }

    if(input$typetemp==1){
        
      colo=c("steelblue3")
      ylim=c(0,max(vartemp_all))
      
      plot(vartemp_all, ylim=ylim, axes=FALSE, type="n", xlab="", ylab="")
      tic=axTicks(2)
      
      if(ylim[2]>tic[length(tic)]){
         tic=c(tic,tic[length(tic)]+tic[2])
      }
      ylim[2]=tic[length(tic)]
      
      par(mar=c(5,7,2,15))
      barplot(vartemp_all, beside=TRUE, names.arg=catnames, cex.names=1.25, col=colo, xlab="", yaxt="n", ylab="", ylim=ylim, cex.axis=1.25, border=colo)
      axis(2, at=tic, cex.axis=1.5, las=2)
      mtext(lab, 1, cex=2, line=3.5)
      mtext("Fraction of interactions", 2, cex=2, line=5)
  
    }else{
      
      colo=c("steelblue3","#CC6666")
      ylim=c(0,max(c(vartemp_local,vartemp_visitor)))
      
      plot(c(vartemp_local,vartemp_visitor), ylim=ylim, axes=FALSE, type="n", xlab="", ylab="")
      tic=axTicks(2)
      
      if(ylim[2]>tic[length(tic)]){
        tic=c(tic,tic[length(tic)]+tic[2])
      }
      ylim[2]=tic[length(tic)]
      
      par(mar=c(5,7,0.5,15))
      barplot(rbind(vartemp_local,vartemp_visitor), beside=TRUE, names.arg=catnames, cex.names=1.25, col=colo, xlab="", yaxt="n", ylab="", ylim=ylim, cex.axis=1.25, border=colo)
      axis(2, at=tic, cex.axis=1.5, las=2)
      mtext(lab, 1, cex=2, line=3.5)
      mtext("Fraction of interactions", 2, cex=2, line=5)
      
      legend("right", legend=c("Locals","Visitors"), fill=colo, xpd=NA, inset=c(-0.15,0), bty="n", cex=2, border=colo)
    
    }     
  })
  
  
  ##### Interactions ########################################################################################
  
  # Plot
  output$plotint <- renderPlot({
    
    if(input$Catint==1){
      
      tot=lulc_t[as.numeric(input$CSint),]
      loc=lulc_l[as.numeric(input$CSint),] 
      vis=lulc_v[as.numeric(input$CSint),]
      
      catnames=c("Agricultural / Open landscape", "Anthropic infrastructures", "Forest", "Mountain landscape", "Sparse forest", "Water and Wetlands")
      
    }
    
    if(input$Catint==2){
      
      tot=rec_t[as.numeric(input$CSint),]
      loc=rec_l[as.numeric(input$CSint),] 
      vis=rec_v[as.numeric(input$CSint),]
      
      catnames=c("Annual Sports", "Motorized activities", "Recreational", "Summer sports", "Water sports", "Winter outdoor sports")          
      
    }
    
    minlab=0
    maxlab=min(10*(trunc(max(loc,tot,vis)*10)+1),100)
    seqlab=as.character(seq(0,maxlab,length=5))
    
    tab=rbind(maxlab, minlab, 100*tot, 100*loc, 100*vis)
    rownames(tab)=1:5
    tab=as.data.frame(tab)
    colnames(tab)=catnames

    colo=c("lightgrey", "steelblue3" , "#CC6666")
    
    par(mar=c(5,7,0.5,15))
    radarchart(tab, axistype=1, 
               pcol=alpha(colo, 0.5), pfcol=alpha(colo, 0.3), plwd=4 , plty=1, 
               cglcol="grey", cglty=1, axislabcol="black",caxislabels=seqlab, seg=4,cglwd=2,
               vlcex=2)
    legend("right", legend=c("All","Locals","Visitors"), fill=alpha(colo, 0.3), xpd=NA, inset=c(-0.1,0), bty="n", cex=2, border=alpha(colo, 0.5))

  })
  
})
