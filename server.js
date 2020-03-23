'use strict';

const express = require('express');
const LanguageTranslatorV3 = require('ibm-watson/language-translator/v3');

const PORT = 8080;
const HOST = '0.0.0.0';

const LT_VERSION = '2018-05-01';
const LT_URL = process.env.lt_url;

const languageTranslator = new LanguageTranslatorV3({
  version: LT_VERSION,
  iam_apikey: process.env.lt_key,
  url: LT_URL,
});

const app = express();
app.get('/translate', (req, res) => {

  if(!req.query.text) {
    res.send('You must pass in the text to translate with the url using ?text=text!\n');
  }

  if(!req.query.lang) {
      console.log('No language passed to translate to. Converting to Spanish by default.');
  }

  const translateParams = {
    text: req.query.text,
    model_id: req.query.lang ? req.query.lang : 'en-es',
  };

  languageTranslator.translate(translateParams)
    .then(translationResult => {
      console.log(JSON.stringify(translationResult, null, 2));
      res.send(JSON.stringify(translationResult, null, 2));
    })
    .catch(err => {
      console.log('error:', err);
      res.send('Something went wrong!\n');
    });

});

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);
