#####################
# Arrow animation
#####################
$(".organization-img-wrapper").hover (->
  $(".caption-wrapper", this).stop().animate
    top: "0"
  ,
    queue: false
    duration: 300

  return
), ->
  $(".caption-wrapper", this).stop().animate
    top: "100%"
  ,
    queue: false
    duration: 300

  return


##########################
# Menu animation
##########################

menu_focus = (element, i) ->
  if $(element).hasClass("active")
    if i is 6
      return  if $(".navbar").hasClass("inv") is false
    else
      return
  if i is 1 or i is 4
    $(".navbar").removeClass "inv"
  else
    $(".navbar").addClass "inv"
  $(".nav > li").removeClass "active"
  $(element).addClass "active"
  icon = $(element).find(".fa")
  left_pos = icon.offset().left - $(".nav").offset().left
  el_width = icon.width() + $(element).find(".text").width() + 10
  $(".active-menu").stop(false, false).animate
    left: left_pos
    width: el_width
  , 1500, "easeInOutQuart"
  return

$(document).scroll (e) ->
  pause = 50
  delay (->
    tops = []
    $(".story").each (index, element) ->
      tops.push $(element).offset().top - 200
      return

    scroll_top = $(this).scrollTop()
    lis = $(".nav > li")
    i = tops.length - 1

    while i >= 0
      if scroll_top >= tops[i]
        menu_focus lis[i], i + 1
        break
      i--
    return
  ), pause
  return

delay = (->
  timer = 0
  (callback, ms) ->
    clearTimeout timer
    timer = setTimeout(callback, ms)
    return
)()

goToByScroll = (dataslide, htmlbody) ->
  offset_top = (if (dataslide is 1) then "0px" else $(".slide[slide=\"" + dataslide + "\"]").offset().top)
  htmlbody.stop(false, false).animate
    scrollTop: offset_top
  , 1500, "easeInOutQuart"



$ ->
  #Cache some variables
  menu_item = $(".nav").find("li")
  menu_item.hover ((e) ->
      icon = $(this).find(".fa")
      left_pos = icon.offset().left - $(".nav").offset().left
      el_width = icon.width() + $(this).find(".text").width() + 10
      hover_bar = $("<div class=\"active-menu special-active-menu\"></div>").css("left", left_pos).css("width", el_width).attr("id", "special-active-menu")
      $(".active-menu").after hover_bar
      return
    ), (e) ->
      $(".special-active-menu").remove()

############################
# Scroll animation
############################


  links = $(".nav").find("li")
  slide = $(".slide")
  button = $(".button")
  mywindow = $(window)
  htmlbody = $("html,body")

  #When the user clicks on the navigation links, get the data-slide attribute value of the link and pass that variable to the goToByScroll function
  links.click (e) ->
    e.preventDefault()
    dataslide = $(this).attr("slide")
    goToByScroll dataslide, htmlbody
    $(".nav-collapse").collapse "hide"

  #When the arrow-intro
  $(".intro-next").click (e) ->
    e.preventDefault()
    dataslide = $(this).attr("slide")
    goToByScroll dataslide, htmlbody
    $(".nav-collapse").collapse "hide"
  $('#fianceCarrousel').carousel({
    interval:   4000
  });

  ###################################
  # Contact form validation
  ###################################
$ ->
  $("#contact-form").bootstrapValidator
    message: 'Valeur non valide'
    disableSubmitButtons: true
    feedbackIcons:
      valid: "glyphicon glyphicon-ok"
      invalid: "glyphicon glyphicon-remove"
      validating: "glyphicon glyphicon-refresh"
    fields:
      name:
        validators:
          notEmpty:
            message: 'Votre nom est requis'
      email:
        validators:
          notEmpty:
            message: 'Votre mail est requis'
          emailAddress:
            message: 'Votre adresse mail n\'est pas valide'
      message:
        validators:
          notEmpty:
            message: 'Votre message ne peut etre vide'
    submitHandler: (validator, form) ->
      # form is the jQuery object present the current form
      #form.find('.alert').html('Thanks for signing up. Now you can sign in as ' + validator.getFieldElements('username').val()).show();
      form.find('.alert').html('Merci pour votre message. On vous r&eacute;pond vite').show()
      dbConnection='https://flickering-fire-8590.firebaseio.com/v1/requests/request-'+new Date();
      dbRequest = new Firebase(dbConnection)
      values = new Array()
      values=$('#contact-form').serializeArray()
      values.forEach (entry) ->
        dbRequest.child(entry.name).set(entry.value)

###################################
# Housing form validation
###################################
$ ->
  $("#housing-form").bootstrapValidator
    message: 'Valeur non valide'
    disableSubmitButtons: true
    feedbackIcons:
      valid: "glyphicon glyphicon-ok"
      invalid: "glyphicon glyphicon-remove"
      validating: "glyphicon glyphicon-refresh"
    fields:
      name:
        validators:
          notEmpty:
            message: 'Votre nom est requis'
      email:
        validators:
          notEmpty:
            message: 'Votre mail est requis'
          emailAddress:
            message: 'Votre adresse mail n\'est pas valide'
      message:
        validators:
          notEmpty:
            message: 'Votre message ne peut etre vide'
    submitHandler: (validator, form) ->
      form.find('.alert').html('Merci pour votre message. On vous confirme votre r&eacute;servation par mail').show()
      dbConnection='https://flickering-fire-8590.firebaseio.com/v1/bookings/booking-'+new Date();
      dbRequest = new Firebase(dbConnection)
      values = new Array()
      values=$('#housing-form').serializeArray()
      values.forEach (entry) ->
        dbRequest.child(entry.name).set(entry.value)

###################################
# playlist form validation
###################################
$ ->
  $("#playlist-form").bootstrapValidator
    message: 'Valeur non valide'
    disableSubmitButtons: true
    feedbackIcons:
      valid: "glyphicon glyphicon-ok"
      invalid: "glyphicon glyphicon-remove"
      validating: "glyphicon glyphicon-refresh"
    fields:
      name:
        validators:
          notEmpty:
            message: 'Votre nom est requis'
      title:
        validators:
          notEmpty:
            message: 'Le titre est requis'
      author:
        validators:
          notEmpty:
            message: 'L\'auteur est requis'
    submitHandler: (validator, form) ->
      form.find('.alert').html('Merci pour votre message. Vivement la soir&eacute;e').show()
      dbConnection='https://flickering-fire-8590.firebaseio.com/v1/musics/music-'+new Date();
      dbRequest = new Firebase(dbConnection)
      values = new Array()
      values=$('#playlist-form').serializeArray()
      values.forEach (entry) ->
        dbRequest.child(entry.name).set(entry.value)

$ ->
  $('#owl-transport').owlCarousel
    singleItem: true
    stopOnHover: true
    autoPlay: 10000
  owlTransport = $('#owl-transport').data('owlCarousel')
  $('#goToMapSlide').click (e) ->
    e.preventDefault()
    owlTransport.goTo(1)
  $('#goToCarSlide').click (e) ->
    e.preventDefault()
    owlTransport.goTo(2)
  $('#goToTrainSlide').click (e) ->
    e.preventDefault()
    owlTransport.goTo(3)
  $('#goToAvionSlide').click (e) ->
    e.preventDefault()
    owlTransport.goTo(4)


  $('#owl-housing').owlCarousel
    items: 3
    autoPlay: 10000

  $('#owl-tourism').owlCarousel
    singleItem: true
    stopOnHover: true
    autoPlay: 10000
    autoHeight : true

  ############################
  # Schedule google maps
  ############################

  mapStyle= [
    {
      stylers: [visibility: "off"]
    }
    {
      featureType: "road"
      stylers: [
        {
          visibility: "on"
        }
        {
          color: "#ffffff"
        }
      ]
    }
    {
      featureType: "road.arterial"
      stylers: [
        {
          visibility: "on"
        }
        {
          color: "#fee379"
        }
      ]
    }
    {
      featureType: "road.highway"
      stylers: [
        {
          visibility: "on"
        }
        {
          color: "#fee379"
        }
      ]
    }
    {
      featureType: "landscape"
      stylers: [
        {
          visibility: "on"
        }
        {
          color: "#f3f4f4"
        }
      ]
    }
    {
      featureType: "water"
      stylers: [
        {
          visibility: "on"
        }
        {
          color: "#7fc8ed"
        }
      ]
    }
    {
      featureType: "road"
      elementType: "labels"
      stylers: [visibility: "off"]
    }
    {
      featureType: "poi.park"
      elementType: "geometry.fill"
      stylers: [
        {
          visibility: "on"
        }
        {
          color: "#83cead"
        }
      ]
    }
    {
      elementType: "labels"
      stylers: [visibility: "on"]
    }
    {
      featureType: "landscape.man_made"
      elementType: "geometry"
      stylers: [
        {
          weight: 0.9
        }
        {
          visibility: "off"
        }
      ]
    }
  ]

  #########################################
  # Schedule gmaps
  #########################################
  mapOptions =
    center: new google.maps.LatLng(49.3000000,1.416700)
    zoom: 11
    mapTypeId: google.maps.MapTypeId.ROADMAP
    zoomControl: false
    streetViewControl: false
    panControl: false
    mapTypeControl: false
    styles: mapStyle

  collegialeIcon = {
    url: '../images/icons/gmap-collegiale.png'
    size: new google.maps.Size(64, 64)
    origin: new google.maps.Point(0, 0)
    anchor: new google.maps.Point(0, 64)
  }

  grangeIcon = {
    url: '../images/icons/gmap-grange.png'
    size: new google.maps.Size(64, 64)
    origin: new google.maps.Point(0, 0)
    anchor: new google.maps.Point(0, 64)
  }
  ################################
  # manage clipping issue within bootstrap modal
  ################################
  $("#schedule-modal").on "shown.bs.modal", (e) ->
    map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions)  if map is `undefined`

    ################################
    # Markers
    ################################
    collegialeMarker = new google.maps.Marker(
      position: new google.maps.LatLng(49.3105,1.4325)
      map: map
      animation: google.maps.Animation.DROP
      icon: collegialeIcon
      title: "Collegiale Notre Dame d'Ecouis - 27440 Ecouis"
    )

    grangeMarker = new google.maps.Marker(
      position: new google.maps.LatLng(49.237586,1.503573)
      map: map
      animation: google.maps.Animation.DROP
      icon: grangeIcon
      title: "La Grange de Bourgoult - Harquency - 27700 Les andelys"
    )

    ################################
    # Infowindow
    ################################
    collegialeInfowindow = new google.maps.InfoWindow(
      content: "<p>Collegiale Notre Dame d'Ecouis - 27440 Ecouis<br> <a target=\"_blank\" href=\"https://www.google.fr/maps/place/Place+de+la+Coll%C3%A9giale/@49.3055998,1.4460643,12z/data=!4m2!3m1!1s0x47e6d4ddfc8ef14d:0xf39aafeacb50ef3e\">Lien google Map</a></p>"
    )

    grangeInfowindow = new google.maps.InfoWindow(
      content: "<p>La Grange de Bourgoult - Harquency - 27700 Les andelys.<br> <a target=\"_blank\" href=\"https://www.google.fr/maps/place/La+Grange+de+Bourgoult/@49.2129744,1.5309315,12z/data=!4m2!3m1!1s0x47e6d3c28263b351:0xc5c961d1f320beab\">Lien google Map</a></p>"
    )

    google.maps.event.addListener collegialeMarker, "click", ->
      collegialeInfowindow.open map, collegialeMarker

    google.maps.event.addListener grangeMarker, "click", ->
     grangeInfowindow.open map, grangeMarker

    google.maps.event.trigger(map, "resize");

  ######################################################
  # Google Maps Car transport
  ######################################################
  carMapOptions =
    center: new google.maps.LatLng(49.579774,0.8765789)
    zoom: 9
    mapTypeId: google.maps.MapTypeId.ROADMAP
    zoomControl: true
    streetViewControl: false
    panControl: true
    mapTypeControl: false

  trainMapOptions =
    center: new google.maps.LatLng(49.579774,0.8765789)
    zoom: 9
    mapTypeId: google.maps.MapTypeId.ROADMAP
    zoomControl: true
    streetViewControl: false
    panControl: true
    mapTypeControl: false

  planeMapOptions =
    center: new google.maps.LatLng(49.579774,0.8765789)
    zoom: 9
    mapTypeId: google.maps.MapTypeId.ROADMAP
    zoomControl: true
    streetViewControl: false
    panControl: true
    mapTypeControl: false

  $("#transport-modal").on "shown.bs.modal", (e) ->
    carMap = new google.maps.Map(document.getElementById("car_map_canvas"), carMapOptions)  if carMap is `undefined`
    trainMap = new google.maps.Map(document.getElementById("train_map_canvas"), trainMapOptions)  if trainMap is `undefined`
    planeMap = new google.maps.Map(document.getElementById("plane_map_canvas"), planeMapOptions)  if planeMap is `undefined`
    carDirectionsDisplay = new google.maps.DirectionsRenderer();
    trainDirectionsDisplay = new google.maps.DirectionsRenderer();
    trainDirectionsDisplay.setMap(trainMap);
    carDirectionsDisplay.setMap(carMap);
    planeDirectionsDisplay = new google.maps.DirectionsRenderer();
    planeDirectionsDisplay.setMap(planeMap);
    carRequest = {
      origin: 'Paris'
      destination: 'Ecouis'
      travelMode: google.maps.TravelMode.DRIVING
    }
    trainRequest = {
      origin: 'Gare+SNCF+de+Gaillon,+Rue+de+la+Gare,+27940+Aubevoye'
      destination: 'Ecouis'
      travelMode: google.maps.TravelMode.DRIVING
    }
    planeRequest = {
      origin: 'Aeroport+Paris+Beauvais+Tille,+60000+Beauvais'
      destination: 'Ecouis'
      travelMode: google.maps.TravelMode.DRIVING
    }
    carDirectionsService = new google.maps.DirectionsService();
    carDirectionsService.route carRequest, (result, status) ->
      carDirectionsDisplay.setDirections result  if status is google.maps.DirectionsStatus.OK
    trainDirectionsService = new google.maps.DirectionsService();
    trainDirectionsService.route trainRequest, (result, status) ->
      trainDirectionsDisplay.setDirections result  if status is google.maps.DirectionsStatus.OK
    planeDirectionsService = new google.maps.DirectionsService();
    planeDirectionsService.route planeRequest, (result, status) ->
      planeDirectionsDisplay.setDirections result  if status is google.maps.DirectionsStatus.OK

  ######################################################
  # Google analytics snippet
  ######################################################
  ((i, s, o, g, r, a, m) ->
    i["GoogleAnalyticsObject"] = r
    i[r] = i[r] or ->
      (i[r].q = i[r].q or []).push arguments
    i[r].l = 1 * new Date()
    a = s.createElement(o)
    m = s.getElementsByTagName(o)[0]
    a.async = 1
    a.src = g
    m.parentNode.insertBefore a, m) window, document, "script", "//www.google-analytics.com/analytics.js", "ga"
  ga "create", "UA-49987500-1", "annesophie-et-emmanuel.fr"
  ga "send", "pageview"

  ###########################################################
  # Animate homepage
  ###########################################################