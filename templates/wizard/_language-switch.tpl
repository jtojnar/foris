<div id="wizard-language-switch">
  {{ trans("Language") }}:
  <a href="{{ url("change_lang", lang="cs", backlink=request.fullpath) }}">CZE</a>
  | <a href="{{ url("change_lang", lang="en", backlink=request.fullpath) }}">ENG</a>
</div>