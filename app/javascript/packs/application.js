/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";
const FileSaver = require('file-saverjs');
const TableExport = require('tableexport');

// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';
// import "select2";
const exportfunc = (exportexl) =>{
    exportexl.addEventListener('click', (btn) => {
    let table = new TableExport(document.getElementsByTagName("table"), {exportButtons: false});
    var exportData = table.getExportData();
    console.log(exportData)
    let xlsxData
    xlsxData = exportData[Object.keys(exportData)[0]].xlsx
    table.export2file(xlsxData.data, xlsxData.mimeType, xlsxData.filename, xlsxData.fileExtension, xlsxData.merges, xlsxData.RTL, xlsxData.sheetname)
  });
}
const option1 = {
  "width": "200px",
  "language": {
      "noResults": () => { return "לא נמצאו תוצאות"; }
  },
   escapeMarkup: (markup) =>{ return markup; }
};
const option2 = {...option1}
const option3 = {...option1}
const option4 = {...option1}
option4["width"] = "80%";
option3["width"] = "280px";
option2["minimumResultsForSearch"] = -1;

document.addEventListener('turbolinks:load', () => {
  $(document).ready(function(){
      // Turn on js-selectable class so that it becomes SELCT 2 tag
      $('.js-selectable').select2(option1);
      $('.js-select').select2(option2);
      $('.js-selectable-xl').select2(option3);
      $('.js-selectable-w80').select2(option4);
  });
  let solidlocal = document.getElementById("user_helplocal");
  let solidcampus = document.getElementById("user_solidaritycampus");
  let localdiv = document.getElementsByClassName("user_solidaritylocaladdress")
  let localcampus = document.querySelectorAll(".user_campus, .user_campusactivity, .user_studentactivist")
  const updateShow = () => {
    if (solidlocal.checked){
      localdiv[0].classList.remove("hide")
      }
    else{
      localdiv[0].classList.add("hide")
      }
    if (solidcampus.checked){
      localcampus.forEach((item) => item.classList.remove('hide'))
      }
    else{
      localcampus.forEach((item) => item.classList.add('hide'))
      }
  }
  if (solidlocal !== null && solidlocal !== "undefined" ){
    updateShow();
    solidlocal.addEventListener('click', (btn) => updateShow());
    solidcampus.addEventListener('click', (btn) => updateShow());
  }
  let exportbtn = null
  exportbtn = document.getElementById('exportexl');
  if (exportbtn !== null) exportfunc(exportbtn);
});
