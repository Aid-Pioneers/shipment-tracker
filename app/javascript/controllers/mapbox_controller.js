import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/starshipsssss/cl42fzh30002x14qlx9knq50y"
    })

    this.#addMarkersToMap()
    this.#fitMapToMarkers()

    // this.map.on('load', () => {
    //   console.log("hello")
    //   this.map.addSource('route', {
    //   'type': 'geojson',
    //   'data': {
    //   'type': 'Feature',
    //   'properties': {},
    //   'geometry': {
    //   'type': 'LineString',
    //   'coordinates': [
    //   [-122.483696, 37.833818],
    //   [-122.483482, 37.833174],
    //   [-122.483396, 37.8327],
    //   [-122.483568, 37.832056],
    //   [-122.48404, 37.831141],
    //   [-122.48404, 37.830497],
    //   [-122.483482, 37.82992],
    //   [-122.483568, 37.829548],
    //   [-122.48507, 37.829446],
    //   [-122.4861, 37.828802],
    //   [-122.486958, 37.82931],
    //   [-122.487001, 37.830802],
    //   [-122.487516, 37.831683],
    //   [-122.488031, 37.832158],
    //   [-122.488889, 37.832971],
    //   [-122.489876, 37.832632],
    //   [-122.490434, 37.832937],
    //   [-122.49125, 37.832429],
    //   [-122.491636, 37.832564],
    //   [-122.492237, 37.833378],
    //   [-122.493782, 37.833683]
    //   ]
    //   }
    //   }
    //   });
    //   this.map.addLayer({
    //   'id': 'route',
    //   'type': 'line',
    //   'source': 'route',
    //   'layout': {
    //   'line-join': 'round',
    //   'line-cap': 'round'
    //   },
    //   'paint': {
    //   'line-color': '#000',
    //   'line-width': 8
    //   }
    //   });
    //   });
  }

  #addMarkersToMap() {
    let uniqueItems = [...new Set(this.markersValue)]
    console.log(uniqueItems)
    this.markersValue.forEach((marker) => {
      // const popup = new mapboxgl.Popup().setHTML(marker.info_window)

      // Create a HTML element for your custom marker
      const customMarker = document.createElement("a")
      customMarker.className = "marker"
      customMarker.style.backgroundImage = `url('${marker.image_url}')`
      customMarker.style.backgroundSize = "fill"
      customMarker.style.backgroundRepeat = "no-repeat"
      customMarker.style.width = "32.5px"
      customMarker.style.height = "40px"
      customMarker.style.paddingBottom = "8px"
      customMarker.href = marker.href
      // customMarker.sty

      // Pass the element as an argument to the new marker
      new mapboxgl.Marker(customMarker)
        .setLngLat([marker.lng, marker.lat])
        // .setPopup(popup)
        .addTo(this.map)
    })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }
}
