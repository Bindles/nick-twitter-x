<h2>Friends</h2>
<ul>
  
  <% @user.friends.each do |friend| %>
  <%= button_to 'Remove', friend_path(friend), method: :delete, data: { confirm: 'Are you sure?' }, form: { 'data-turbo-frame': 'friends' } %>
    <li><%= friend.email %> (<%= link_to 'Remove', friend_path(friend), method: :delete, data: { confirm: 'Are you sure?' } %>)</li>

    <li><%= friend.email %> (<%= link_to 'Remove', friend_path(friend), method: :delete, data: { confirm: 'Are you sure?' } %>)</li>
      <%#= button_to "Destroy this color", friend, method: :delete %>
  <% end %>
</ul>

<h2>All Users</h2>
<ul>
  <% @all_users&.each do |user| %>
    <li>
      <%= user.email %>
      <% unless current_user.friends.include?(user) || current_user == user %>
        <%= form_with(url: friends_path(friend_id: user.id), method: :post) do |form| %>
          <%= form.hidden_field :friend_id, value: user.id %>
          <%= form.submit 'Add Friend' %>
        <% end %>
      <% end %>
    </li>
  <% end %>
</ul>