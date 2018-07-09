function(){
	tabPanel(strong("About"),
	         
		HTML('
      
      <div style="display:inline;float:right;margin:0px 0px 5px 20px">
        <img src="Logo.jpg" border="0" width="300" style="margin:0px">
      </div>

      <div style="max-width:1000px; word-wrap:break-word;">
        <p style="font-size:120%;text-align:justify">
          This interactive web application has been designed to provide an easy-to-use interface to visualize 
          socio-ecological interactions at different scales in 16 case studies across Europe. It was developed as part of a research project funded 
          by the <a href="http://www.alter-net.info/" target=_blank>ALTER-Net</a> network through the 
          <a href="http://www.alter-net.info/ahia" target=_blank>AHIA</a> funding instrument. 
        </p>
      </div>   

      <div style="max-width:1000px; word-wrap:break-word;">
        <p style="font-size:120%;text-align:justify">
          Socio-ecological interactions have been extracted from 
          a <a href="https://www.flickr.com//" target=_blank>Flickr</a> database containing more than 150,000 photographs
          taken by about 2,000 users between 2000 and 2017 in the 16 case study sites. We defined an interaction as the presence of a particular
          users in a given zone of a site during a given hour. In practice, we divided every sites in zones using square grid cells
          with a side length of 500 meters. In order to ensure that only nature based interaction 
          are considered, each photograph has been manually validated and classified according to the Common International 
          Classification of Ecosystem Services*. This enabled us to identify different types of interactions (landscape, recreational activity...). Besides, we identified the place of residence of every users based on their
          Flickr timeline using 100 x 100 km world grid cells. Flickr users have been separated into two groups (locals & visitors) according to the distance between their place of residence and the sites. At the end of the process we obtain a multiscale socio-ecological network composed of 7,354 socio-ecological interactions from 365 distinct places of residence all over the world to 3,418 grid cells located in 16 study sites. More details about the methods used to build the multiscale socio-ecological network are avalaible in 
          the paper (reference below).
        </p>
      </div> 

      <div style="max-width:1000px; word-wrap:break-word;">
        <p style="font-size:120%;text-align:justify">
         This interactive application focuses on the visualisation of several characteristics of the network at different scales: spatial interactions (global scale), spatial and temporal distributions of interactions (local scale) and distribution of interactions according to the type of interaction (local scale).
        </p>
      </div>


      <div style="max-width:1000px; word-wrap:break-word;">
        <p style="font-size:120%;text-align:justify">
          * Haines-Young R and Potschin M (2011) Common International Classification of Ecosystem Services (CICES). Report to the European Environmental Agency.
        </p>
      </div>  

      <br>

      <span style="font-size:120%;color:#64645F;font-weight:bold;">Network</span>
      <div style="max-width:1000px; word-wrap:break-word;">
        <p style="font-size:120%;text-align:justify;">
          The network represents the number of interactions between users place of residence (blue dots) 
          and the case study sites (red dots). 
        </p>
      </div>  

      <br>

      <span style="font-size:120%;color:#64645F;font-weight: bold;">Spatial distribution</span>
      <div style="max-width:1000px; word-wrap:break-word;">
        <p style="font-size:120%;text-align:justify">
          The spatial distribution of interactions within each study site are displayed at different spatial granularities (from 250 meters to 5,000 kilometers)
          and according to the type of users (local or visitor). An histogram of the different indicators is available in the panel.
          A 3D explorer is also available (configuring your web browser to allow pop-up window).
        </p>
      </div>  

      <br>

      <span style="font-size:120%;color:#64645F;font-weight:bold;">Temporal distribution</span>
      <div style="max-width:1000px; word-wrap:break-word;">
        <p style="font-size:120%;text-align:justify;">
           The temporal distribution of interactions are displayed at different temporal scales and according to the users origin.
        </p>
      </div>  

      <br>

      <span style="font-size:120%;color:#64645F;font-weight:bold;">Interactions</span>
      <div style="max-width:1000px; word-wrap:break-word;">
        <p style="font-size:120%;text-align:justify;">
           Distribution of interactions according to the different Cultural Ecosystem Service categories.
        </p>
      </div>  
		
      <hr width="1000", align="left" style="height:0.5px;border:none;color:#A0A5A8;background-color:#A0A5A8;" />
  
		  

      <span style="color:#64645F;font-weight:bold;">Reference</span>
		  <div style="max-width:1000px; word-wrap:break-word;">
		     <p style="text-align:justify;">
		     
		     Lenormand <i>et al.</i> (2018) <a href="https://arxiv.org/abs/1805.00734" target=_blank>Multiscale socio-ecological networks in the age of information</a> <i>arXiv preprint</i> 1805.00734.
		     
		     </p>
		  </div>  

		  <span style="color:#64645F;font-weight: bold;">Author</span>
		  <div style="max-width:1000px; word-wrap:break-word;">
		     <p style="text-align:justify">
		        <a href="http://www.maximelenormand.com/" target=_blank>Maxime Lenormand</a>
		     </p>
		  </div>  

		  <span style="color:#64645F;font-weight:bold;">Code</span>
		  <div style="max-width:1000px; word-wrap:break-word;">
		     <p style="text-align:justify;">
		        Source code available <a href="http://www.maximelenormand.com/Codes" target=_blank>here</a>
		     </p>
		  </div> 

		  <span style="color:#64645F;font-weight:bold;">License</span>
		  <div style="max-width:1000px; word-wrap:break-word;">
		     <p style="text-align:justify;">
		        Coded under License GPLv3
		     </p>
		  </div> 

		  <span style="color:#64645F;font-weight:bold;">Acknowledgements</span>
		  <div style="max-width:1000px; word-wrap:break-word;">
		     <p style="text-align:justify;">
		        A special thanks goes to <a href="https://github.com/chapinux" target=_blank>Chapinux</a> for his help on the 3D visualizations generated with the amazing <a href="https://github.com/minorua/Qgis2threejs" target=_blank>Qgis2threejs plugin</a>. 
		     </p>
		  </div> 

		'),
		
		value="about"
	)
}
