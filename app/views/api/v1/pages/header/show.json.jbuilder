# frozen_string_literal: true

envelope json, (@status || 200) do
  json.header do
    begin
      json.custom_logo_url image_url(customize_logo_url)
    rescue StandardError
      json.custom_logo_url nil
    end
    json.svg_logo(
      %(<svg id="logo-header" viewBox="0 0 170 140" xmlns="http://www.w3.org/2000/svg">
        <g id="logo">
          <path d="m56.757132,-0.271446l0,77.5l-33.1,0l0,-77.5l33.1,0z" id="svg_2"></path>
          <path d="m136.857132,-0.271446l0,77.5l-33.1,0l0,-77.5l33.1,0z" id="svg_3"></path>
          <path d="m80.257132,100.728554c-13,0 -23.5,-10.5 -23.5,-23.5l-33.1,0c0,31.3 25.3,56.6 56.6,56.6s56.6,-25.3 56.6,-56.6l-33.1,0c0,13 -10.6,23.5 -23.5,23.5z" id="svg_4"></path>
          <circle class="tochka" cx="153.357132" cy="117.328554" id="svg_5" r="16.5"></circle>
          <path class="hvost" d="m0.057132,100.828554l0,33.1c31.4,0 56.7,-25.3 56.7,-56.7l-33.1,0c-0.1,12.9 -10.8,23.6 -23.6,23.6z" id="svg_6"></path>
        </g>
      </svg>
      <svg id="logo-header_all" version="1.1" viewBox="-36 257 235 63" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/2000/svg" y="0px">
        <g>
          <path class="letter_2 path" d="M-20.1,320.1v-39c0.2-5.5,4.7-10,10.2-10s10,4.5,10,10v39h14.1v-39c0-13.3-10.8-24.2-24.2-24.2s-24.2,10.8-24.2,24.2v39
          H-20.1z"></path>
          <polygon class="letter_3 path" points="114.8,256.9 66.5,256.9 66.5,271 83.5,271 83.5,320.1 97.6,320.1 97.6,271 114.8,271 "></polygon>
          <path class="letter_4 path" d="M148.3,271h14.4v-14.1h-14.5l0,0c-10.6,0.1-19.2,8.6-19.2,19.3c0,4.7,1.6,8.9,4.4,12.3c-2.7,3.3-4.4,7.6-4.4,12.2
          c0,10.7,8.5,19.2,19.2,19.3l0,0h14.5v-14.1h-14.4l0,0c-2.9-0.2-5.1-2.5-5.1-5.3s2.3-5.1,5.1-5.1h14.4v-14.1h-14.4
          c-2.9-0.1-5.1-2.4-5.1-5.3C143.1,273.3,145.4,271,148.3,271z"></path>
          <path class="letter_5 path" d="M38.4,281.1v39h14.1v-39c0-13.3-10.8-24.2-24.2-24.2v14.2h0.1C33.9,271.1,38.4,275.6,38.4,281.1z"></path>
        </g>
      </svg>)
    )
  end
end
