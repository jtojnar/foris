%# Foris - web administration interface for OpenWrt based on NETCONF
%# Copyright (C) 2013 CZ.NIC, z.s.p.o. <http://www.nic.cz>
%#
%# This program is free software: you can redistribute it and/or modify
%# it under the terms of the GNU General Public License as published by
%# the Free Software Foundation, either version 3 of the License, or
%# (at your option) any later version.
%#
%# This program is distributed in the hope that it will be useful,
%# but WITHOUT ANY WARRANTY; without even the implied warranty of
%# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%# GNU General Public License for more details.
%#
%# You should have received a copy of the GNU General Public License
%# along with this program.  If not, see <http://www.gnu.org/licenses/>.
%#
%rebase("config/base.tpl", **locals())

%if not defined('is_xhr'):
<div id="page-config" class="config-page">
%end
    <form id="main-form" class="config-form" action="{{ request.fullpath }}" method="post" autocomplete="off" novalidate>
        <p class="config-description">{{! description }}</p>
        %include("_messages.tpl")
        <input type="hidden" name="csrf_token" value="{{ get_csrf_token() }}">
        %for field in form.active_fields:
            %if field.hidden:
                {{! field.render() }}
            %else:
            <div class="row">
                {{! field.render() }}
                {{! field.label_tag[lang()] }}
                {{ field.hint[lang()] }}
                %if field.errors:
                  <div class="server-validation-container">
                    <ul>
                      <li>{{ field.errors }}</li>
                    </ul>
                  </div>
                %end
            </div>
            %end
        %end
        %if len(form.active_fields) == 0:
          <div class="message warning">
            {{ trans("List of available software was not downloaded from the server yet. Please come back later.") }}
          </div>
        %else:
          <div class="form-buttons">
              <a href="{{ request.fullpath }}" class="button grayed">{{ trans("Discard changes") }}</a>
              <button type="submit" name="send" class="button">{{ trans("Save changes") }}</button>
          </div>
        %end
    </form>
%if not defined('is_xhr'):
</div>
%end
