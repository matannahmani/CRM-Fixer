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
let exportxl = document.getElementById('exportexl');
const exportfunc = (exportexl) =>{
    exportexl.addEventListener('click', (btn) => {
    const table = new TableExport(document.getElementsByTagName("table"), {exportButtons: false});
    var exportData = table.getExportData();
    var xlsxData = exportData['tableexport-1'].xlsx
    table.export2file(xlsxData.data, xlsxData.mimeType, xlsxData.filename, xlsxData.fileExtension, xlsxData.merges, xlsxData.RTL, xlsxData.sheetname)
  });
}
if (exportexl !== 'null' || exportexl !== 'undefined'){
  exportfunc(exportexl);
}
else{
  location.reload();
}
document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  // initSelect2();
});
