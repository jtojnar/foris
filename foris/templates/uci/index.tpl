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
%rebase("_layout.tpl", **locals())
%def render_buttons(element):
    %if not element.final:
        %if element.tag == "section":
        <a href="{{ url("uci_create", node=element.path, operation="add-option") }}">Add option</a>
        | <a href="{{ url("uci_create", node=element.path, operation="add-list") }}">Add list</a>
        %else:
        <a href="{{ url("uci_create", node=element.path, operation="add") }}">Add value</a>
        %end
    %end
    %if element.tag == "option" or element.tag == "value":
        <a href="{{ url("uci_edit", node=element.path) }}">Edit</a>
    %end
    %if element.tag != "config":
        | <a href="{{ url("uci_remove", node=element.path) }}">Remove</a>
    %end
        | <a href="{{ url("uci_debug", node=element.path) }}">Debug</a>
%end
%def treenode(element, node_path, depth=0):
    <li>
    %if not element.final or depth == 0:
        <input type="checkbox" id="{{ element.path }}" {{! " checked=\"checked\"" if node_path and len(node_path) > depth and node_path[depth] == element.key else "" }}><label for="{{element.path}}">{{element}}</label>
        %render_buttons(element)
    %end
    <ul>
    %for child in element.children:
        %if not child.final:
            %treenode(child, node_path, depth + 1)
        %else:
            <li>{{child}}
                %render_buttons(child)
            </li>
        %end
    %end
    </ul>
    </li>
%end

%############################## PAGE ITSELF STARTS HERE ############################################
<h1>Foris</h1>
<h2>about:config</h2>

%if tree:
    <div class="treeview">
    <ul>
    %for config in tree.children:
        %treenode(config, node_path)
    %end
    </ul>
    </div>
%end