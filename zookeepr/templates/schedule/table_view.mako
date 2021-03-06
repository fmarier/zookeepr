<%inherit file="/base.mako" />

<%
import hashlib
%>

<%def name="toolbox_extra_admin()">
% if h.auth.authorized(h.auth.has_organiser_role):
  <li>${ h.link_to('Edit Proposal', url=h.url_for(controller='proposal', action='edit',id=c.talk.id)) }</li>
  <li>${ h.link_to('View Proposal', url=h.url_for(controller='proposal', action='view',id=c.talk.id)) }</li>
% endif 
</%def>

<p>${ h.link_to('<-- Back to schedule', url=h.url_for(controller='schedule', action='table', id=None, day=c.day)) }</p>

<h2>${ c.talk.title | h }</h2>

<table>
% for schedule in  c.talk.event.schedule:
  <tr class="${ h.cycle('even', 'odd')}">
    <td><strong>Day:</strong></td><td>${ schedule.time_slot.start_time.strftime("%A %d %B %Y") }</td>
    <td><strong>Time:</strong></td><td>${ schedule.time_slot.start_time.strftime("%H:%M") } - ${ schedule.time_slot.end_time.strftime("%H:%M") }</td>
    <td><strong>Location:</strong></td><td>${ schedule.location.display_name }</td>
  </tr>
% endfor

% if c.talk.project or c.talk.url:
  <tr class="${ h.cycle('even', 'odd')}">
    <td><strong>Project:</td>
    <td colspan="5">
%   if c.talk.url:
## FIXME: I reckon this should go into the helpers logic
%     if '://' in c.talk.url:
      <a href="${ c.talk.url | h }">
%     else:
      <a href="http://${ c.talk.url | h }">
%     endif
%   endif
%   if c.talk.project:
${ c.talk.project }
%   endif
%   if c.talk.url:
%     if not c.talk.project:
${ c.talk.url }
%     endif
</a>
%   endif
% endif
</td>

% if c.talk.type.name.startswith('Tutorial'):
  <tr class="${ h.cycle('even', 'odd')}">
    <td><strong>Wiki Page:</td>
    <td colspan="5"><a href="/wiki/Tutorials/${ c.talk.title }">${ c.talk.title }</a></td>
  </tr>
% endif

</table>


<div id="proposal">
<div class="abstract">
<blockquote>
<p>${ h.line_break(h.url_to_link(c.talk.abstract)) | n}</p>
</blockquote>
</div>

% for person in c.talk.people:
<h2>${ person.firstname | h} ${ person.lastname | h}</h2>
<div class="bio">
<blockquote>
<div style="float: right; padding-left: 5px; padding-bottom: 5px; "><img src="${person.avatar_url()}" alt=""></div>
<p>
%   if person.bio:
${ h.line_break(h.url_to_link(person.bio)) | n  }
%   else:
[none provided]
%   endif
</p></blockquote>
</div>

% endfor

</div>

<%def name="title()">
${ h.truncate(c.talk.title) } - ${ parent.title() }
</%def>
